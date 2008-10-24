# vim: set et sw=4 sts=4 encoding=utf-8 foldmethod=marker :

#{{{ Imports
import cherrypy
from turbogears import controllers, expose, redirect, url
from turbogears import validate, flash, error_handler
from turbogears import validators as V
from turbogears import widgets as W
from turbogears import identity
from turbogears import paginate
from docutils.core import publish_parts
from sercom.subcontrollers import validate as val
from sercom.model import ComandoEjecutado, ComandoPruebaEjecutado, Entrega, Correccion, Curso, Ejercicio, InstanciaDeEntrega, Grupo, Miembro, AlumnoInscripto
from sercom.ziputil import unzip
from sqlobject import *
from zipfile import ZipFile, BadZipfile
from cStringIO import StringIO
from datetime import datetime
import os, shutil, subprocess

#}}}

#{{{ Configuración
cls = Entrega
name = 'entrega'
namepl = name + 's'
#}}}

#{{{ Validación
def validate_get(id):
    return val.validate_get(cls, name, id)

def validate_set(id, data):
    return val.validate_set(cls, name, id, data)

def validate_new(data):
    return val.validate_new(cls, name, data)
#}}}

def get_ejercicios_activos():
    # TODO : Mostrar solo los ejercicios con instancias de entrega activos
    return [(0, _(u'--'))] + [(a.id, a) for a in (Ejercicio.select(
        AND(Ejercicio.q.id==InstanciaDeEntrega.q.ejercicioID, InstanciaDeEntrega.q.inicio <= DateTimeCol.now(),
            InstanciaDeEntrega.q.fin >= DateTimeCol.now())))]

ajax = """
    function clearInstancias ()
    {
        l = MochiKit.DOM.getElement('form_instancia');
        l.options.length = 0;
        l.disabled = true;
    }

    function mostrarInstancias(res)
    {
        clearInstancias();
        for(i=0; i < res.instancias.length; i++) {
            id = res.instancias[i].id;
            label = res.instancias[i].numero;
            MochiKit.DOM.appendChildNodes("form_instancia", OPTION({"value":id}, label))
        }
        if (l.options.length > 0)
            l.disabled = false;
    }

    function err (err)
    {
        alert("The metadata for MochiKit.Async could not be fetched :(");
    }

    function actualizar_instancias ()
    {
        l = MochiKit.DOM.getElement('form_ejercicio');
        id = l.options[l.selectedIndex].value;
        if (id == 0) {
            clearInstancias();
            return;
        }

        url = "/mis_entregas/instancias?ejercicio_id="+id;
        var d = loadJSONDoc(url);
        d.addCallbacks(mostrarInstancias, err);
    }

    function prepare()
    {
        connect('form_ejercicio', 'onchange', actualizar_instancias);
        clearInstancias();
    }

    MochiKit.DOM.addLoadEvent(prepare)
"""
#{{{ Formulario
class EntregaForm(W.TableForm):
    class Fields(W.WidgetsList):
        ejercicio = W.SingleSelectField(label=_(u'Ejercicio'),
            options=get_ejercicios_activos, validator=V.Int(not_empty=True))
        instancia = W.SingleSelectField(label=_(u'Instancia de Entrega'), validator=V.Int(not_empty=True))
        archivo = W.FileField(label=_(u'Archivo'), help_text=_(u'Archivo en formaro ZIP con tu entrega'))
    fields = Fields()
    javascript = [W.JSSource("MochiKit.DOM.focusOnLoad('form_ejercicio');"), W.JSSource(ajax)]

form = EntregaForm()

#}}}

#{{{ Controlador
class MisEntregasController(controllers.Controller, identity.SecureResource):
    """Basic model admin interface"""
    require = identity.has_permission('entregar')

    hide_to_admin = 1

    @expose()
    def default(self, tg_errors=None):
        """handle non exist urls"""
        raise redirect('list')

    @expose()
    def index(self):
        raise redirect('list')

    @expose(template='kid:%s.templates.list' % __name__)
    @paginate('records')
    def list(self):
        """List records in model"""
        # Un admin no tiene sentido en este area y por las dudas
        # lo mando al home.
        if 'admin' in identity.current.permissions:
            raise redirect(url("/dashboard"))

        # Grupos en los que el usuario formo parte
        m = [i.grupo.id for i in Grupo.selectByAlumno(identity.current.user)]
        try:
            entregador = AlumnoInscripto.selectByAlumno(identity.current.user)
            m.append(entregador.id)
        except:
            pass
        r = cls.select(IN(cls.q.entregadorID, m))
        return dict(records=r, name=name, namepl=namepl)

    @expose(template='kid:%s.templates.new' % __name__)
    def new(self, **kw):
        """Create new records in model"""
        return dict(name=name, namepl=namepl, form=form, values=kw)

    @validate(form=form)
    @error_handler(new)
    @expose()
    def create(self, archivo, ejercicio, **kw):
        """Save or create record to model"""
        archivo = archivo.file.read()
        try:
            zfile = ZipFile(StringIO(archivo), 'r')
        except BadZipfile:
            flash(_(u'El archivo ZIP no es válido'))
            raise redirect('list')
        if zfile.testzip() is not None:
            flash(_(u'El archivo ZIP tiene errores de CRC'))
            raise redirect('list')

        # por defecto el entregador es el user loggeado
        entregador = AlumnoInscripto.selectByAlumno(identity.current.user)

        ejercicio = Ejercicio.get(int(ejercicio))
        if ejercicio.grupal:
            # Como es grupal, tengo que hacer que la entrega la haga
            # mi grupo y no yo personalmente. Busco el grupo
            # activo.

            # Con esto obtengo todos los grupos a los que pertenece el Alumno
            # y que estan activos
            try:
                # TODO : Falta filtrar por curso!!
                m = Miembro.select(
                    AND(
                        Miembro.q.alumnoID == AlumnoInscripto.q.id,
                        AlumnoInscripto.q.alumnoID == identity.current.user.id,
                        Miembro.q.baja == None
                    )
                ).getOne()
            except:
                flash(_(u'No puedes realizar la entrega ya que el ejercicio es Grupal y no perteneces a ningún grupo.'))
                raise redirect('list')

            entregador = m.grupo
        kw['archivos'] = archivo
        kw['entregador'] = entregador
        validate_new(kw)
        flash(_(u'Se creó una nueva %s.') % name)
        raise redirect('list')

    @expose(template='kid:%s.templates.corrida' % __name__)
    def corrida(self, entregaid):
        e = validate_get(entregaid)
        return dict(entrega=e)

    @expose()
    def get_archivo(self, entregaid):
        r = validate_get(entregaid)
        cherrypy.response.headers["Content-Type"] = "application/zip"
        content_disp = "attachment;filename=Ej_%s-Entrega_%s-%s.zip" % (
                r.instancia.ejercicio.numero, r.instancia.numero,
                r.entregador.nombre)
        cherrypy.response.headers["Content-disposition"] = content_disp
        return r.archivos

    @expose()
    def get_pdf(self, entregaid):
        r = validate_get(entregaid)
        # TODO: config de tmp dir y cache de PDFs
        basename = os.path.join('/tmp', 'pdf-%d-%s'
                % (r.id, datetime.now().isoformat()))
        os.mkdir(basename) # TODO: capturar excepciones
        unzip(r.archivos, basename) # TODO: capturar excepciones
        # TODO: hacer find con python con patrones configurables
        cmd = "cd '%s'; find -regextype posix-egrep -type f -regex " \
                "'.*\.(h|c|cpp)' | sort -r | xargs -- a2ps -q -2 -Av --toc " \
                "--line-numbers=1 --header='[75.42] Taller de Programacion' " \
                "--left-footer='%%D{%%c}' --footer='Padron %s (curso %d.%d) " \
                "   Ejercicio %d.%d (entrega %s)' -g -o '%s'.pdf" \
                % (basename, r.entregador.nombre, 2008, 1,
                        r.instancia.ejercicio.numero, r.instancia.numero,
                        r.fecha.isoformat(), basename)
        subprocess.check_call(cmd, shell=True) # TODO: capturar excepciones
        pdffile = file('%s.pdf' % basename)
        pdf = pdffile.read()
        pdffile.close()
        shutil.rmtree(basename) # TODO: capturar excepciones
        os.unlink('%s.pdf' % basename) # TODO: capturar excepciones
        cherrypy.response.headers["Content-Type"] = "text/plain"
        cherrypy.response.headers["Content-Type"] = "application/pdf"
        content_disp = "attachment;filename=%s-ej%d.%d.%s.pdf" % (
                r.entregador.nombre, r.instancia.ejercicio.numero,
                r.instancia.numero, r.fecha.isoformat())
        cherrypy.response.headers["Content-disposition"] = content_disp
        return pdf

    @expose()
    def file(self, id):
        r = ComandoEjecutado.get(id)
        cherrypy.response.headers["Content-Type"] = "application/zip"
        content_disp = "attachment;filename=comando_ejecutado_%d.zip" % (r.id)
        cherrypy.response.headers["Content-disposition"] = content_disp
        return r.archivos

    @expose()
    def diff(self, id):
        r = ComandoEjecutado.get(id)
        cherrypy.response.headers["Content-Type"] = "application/zip"
        content_disp = "attachment;filename=diferencias_%d.zip" % (r.id)
        cherrypy.response.headers["Content-disposition"] = content_disp
        return r.diferencias

    @expose(template='kid:%s.templates.diff' % __name__)
    def verdiff(self, id):
        r = ComandoEjecutado.get(id)
        zip = ZipFile(StringIO(r.diferencias), 'r')
        return dict(zip=zip)

    @expose('json')
    def instancias(self, ejercicio_id):
        instancias = InstanciaDeEntrega.select(AND(
                InstanciaDeEntrega.q.ejercicioID == ejercicio_id,
                InstanciaDeEntrega.q.activo == True,
                InstanciaDeEntrega.q.inicio <= DateTimeCol.now(),
                InstanciaDeEntrega.q.fin >= DateTimeCol.now()))
        return dict(instancias=instancias)
#}}}

