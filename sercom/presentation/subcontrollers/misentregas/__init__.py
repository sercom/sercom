# vim: set et sw=4 sts=4 encoding=utf-8 foldmethod=marker :

#{{{ Imports
import cherrypy
from turbogears import expose, redirect, url
from turbogears import validate, flash, error_handler
from turbogears import validators as V
from turbogears import widgets as W
from turbogears import identity
from turbogears import paginate
from docutils.core import publish_parts
from sercom.presentation.subcontrollers import validate as val
from sercom.model import ComandoEjecutado, ComandoPruebaEjecutado, Entrega, Correccion, Curso, Ejercicio, InstanciaDeEntrega, Grupo, Miembro, AlumnoInscripto, Alumno
from sercom.ziputil import unzip
from sqlobject import *
from zipfile import ZipFile, BadZipfile
from cStringIO import StringIO
from datetime import datetime
from sercom.presentation.utils.downloader import *
from sercom.presentation.controllers import BaseController
import os, shutil, subprocess
from sercom.widgets import FocusJSSource, LoadEventJSSource
#}}}

#{{{ Configuración
cls = Entrega
name = 'Entrega'
namepl = name + 's'
#}}}

#{{{ Validación
def validate_get_entrega(id):
    e = val.validate_get(cls, name, id)
    e.validar_acceso(identity.current.user)
    return e

def validate_get_comando_ejecutado(id):
    c = ComandoEjecutado.get(id)
    c.validar_acceso(identity.current.user)
    return c

def validate_new(data):
    return val.validate_new(cls, name, data)
#}}}

ajax = """
    function clearCombo(cmbId)
    {
        l = MochiKit.DOM.getElement(cmbId);
        l.options.length = 0;
        l.disabled = true;
    }

    function checkEnableStatus(cmbId)
    {
        l = MochiKit.DOM.getElement(cmbId);
        if (l.options.length > 0)
            l.disabled = false;
    }


    function clearInstanciasYGrupos ()
    {
        clearCombo('form_instancia');
        clearCombo('form_grupo');
    } 

    function mostrarInstanciasYGrupos(res)
    {
        for(i=0; i < res.instancias.length; i++) {
            id = res.instancias[i].id;
            label = res.instancias[i].numero;
            MochiKit.DOM.appendChildNodes('form_instancia', OPTION({'value':id}, label))
        }
        for(i=0; i < res.grupos.length; i++) {
            id = res.grupos[i].id;
            label = res.grupos[i].nombre;
            MochiKit.DOM.appendChildNodes('form_grupo', OPTION({'value':id}, label))
        }
        checkEnableStatus('form_instancia');
        checkEnableStatus('form_grupo');
    }

    function err (err)
    {
        alert("The metadata for MochiKit.Async could not be fetched :(");
    }

    function actualizar_instancias ()
    {
        clearInstanciasYGrupos();
        l = MochiKit.DOM.getElement('form_ejercicio');
        id = l.options[l.selectedIndex].value;
        if (id != 0) {
            url = "/mis_entregas/get_instancias_y_grupos?ejercicio_id="+id;
            var d = loadJSONDoc(url);
            d.addCallbacks(mostrarInstanciasYGrupos, err);
        }
    }
"""
#{{{ Formulario
class EntregaForm(W.TableForm):
    class Fields(W.WidgetsList):
        ejercicio = W.SingleSelectField(name='ejercicio',label=_(u'Ejercicio'),attrs=dict(onchange='actualizar_instancias()'),
             validator=V.Int(not_empty=True))
        instancia = W.SingleSelectField(label=_(u'Instancia de Entrega'), validator=V.Int(not_empty=True))
        grupo = W.SingleSelectField(label=_(u'Grupo'), validator=V.Int())
        archivo = W.FileField(label=_(u'Archivo'), help_text=_(u'Archivo en formato ZIP con tu entrega'),
            validator=V.FieldStorageUploadConverter(not_empty=True, accept_iterator=True))
    fields = Fields()
    javascript = [FocusJSSource('form_ejercicio'), W.JSSource(ajax), LoadEventJSSource('clearInstanciasYGrupos')]

form = EntregaForm()

#}}}

#{{{ Controlador
class MisEntregasController(BaseController, identity.SecureResource):
    """Basic model admin interface"""
    require = identity.has_any_permission('entregar', 'corregir')
    menu_require = identity.has_permission('entregar')

    @expose()
    def default(self, tg_errors=None):
        """handle non exist urls"""
        raise redirect('list')

    @expose()
    def index(self):
        raise redirect('list')

    @expose(template='kid:%s.templates.list' % __name__)
    @paginate('records', dynamic_limit='limit_to')
    @identity.require(identity.has_permission('entregar'))
    def list(self):
        """List records in model"""
        # Grupos en los que el usuario formo parte
        curso = self.get_curso_actual()
        entregadores = identity.current.user.get_entregadores(curso)
        r = cls.select(IN(cls.q.entregador, entregadores), orderBy=-Entrega.q.fecha)
        return dict(records=r, name=name, namepl=namepl, limit_to=identity.current.user.paginador)

    @expose(template='kid:%s.templates.new' % __name__)
    @identity.require(identity.has_permission('entregar'))
    def new(self, **kw):
        """Create new records in model"""
        curso = self.get_curso_actual()
        ejercicios = curso.ejercicios_activos
        q_score = Entrega.selectBy(inicio=None, fin=None, entregador=identity.current.user.get_inscripcion(curso)).count()
        if len(ejercicios) == 0:
            flash(_(u'Al momento, no hay ningún ejercicio con instancias de entrega abiertas.'))
        if q_score > 0:
            flash(_(u'Usted tiene un ejercicio en espera de ser aceptado. No envíe otro hasta tener la respuesta del primero.'))
        ejercicio_options = [(0, 'Seleccionar')] + [(e.id, e.shortrepr()) for e in ejercicios]
        return dict(name=name, namepl=namepl, form=form, values=kw, options=dict(ejercicio=ejercicio_options))

    @validate(form=form)
    @error_handler(new)
    @expose()
    @identity.require(identity.has_permission('entregar'))
    def create(self, archivo, ejercicio, **kw):
        """Save or create record to model"""
        curso = self.get_curso_actual()
        q_score = Entrega.selectBy(inicio=None, fin=None, entregador=identity.current.user.get_inscripcion(curso)).count()
        if q_score > 0:
            flash(_(u'No se acepta una nueva entrega si la anterior no fue procesada.'))
            raise redirect('list')
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
        curso = self.get_curso_actual()
        entregador = identity.current.user.get_inscripcion(curso)

        grupo_id = kw['grupo']
        del kw['grupo']
        ejercicio = Ejercicio.get(int(ejercicio))
        if ejercicio.grupal:
            # Como es grupal, tengo que hacer que la entrega la haga el grupo
            if not grupo_id:
                flash(_(u'No se puede realizar una entrega de un ejercicio grupal sin elegir el grupo.'))
                raise redirect('list')
            else:
                entregador = Grupo.get(int(grupo_id))

        kw['archivos'] = archivo
        kw['entregador'] = entregador
        validate_new(kw)
        flash(_(u'Se creó una nueva %s.') % name)
        raise redirect('list')

    @expose(template='kid:%s.templates.corrida' % __name__)
    def corrida(self, entregaid):
        e = validate_get_entrega(entregaid)
        return dict(entrega=e)

    @expose()
    @identity.require(identity.has_permission('admin'))
    def anular(self, entregaid):
        e = validate_get_entrega(entregaid)
        e.inicio = e.fin = datetime.now()
        e.exito = 0
        e.observaciones = u'La entrega fue anulada por %s' % identity.current.user.shortrepr()
        flash(_(u'Se anuló la entrega %s' % e.shortrepr()))
        raise redirect('/entregas/statistics')

    @expose()
    def get_archivo(self, entregaid):
        r = validate_get_entrega(entregaid)
        download = Downloader(cherrypy.response)
        nombre = "Ej_%s-Entrega_%s-%s.zip" % (r.instancia.ejercicio.numero, r.instancia.numero, r.entregador.nombre)
        return download.download_zip(r.archivos, nombre)

    @expose()
    def file(self, id, nombre_arch_interno=None):
        r = validate_get_comando_ejecutado(id)
        download = Downloader(cherrypy.response)

        if nombre_arch_interno:
            return download.download_zip_content(r.archivos,nombre_arch_interno).encode('ascii', 'replace')
        else:
            nombre_arch = "comando_ejecutado_%d.zip" % r.id
            return download.download_zip(r.archivos, nombre_arch) 

    @expose()
    def diff(self, id):
        r = validate_get_comando_ejecutado(id)
        cherrypy.response.headers["Content-Type"] = "application/zip"
        content_disp = "attachment;filename=diferencias_%d.zip" % (r.id)
        cherrypy.response.headers["Content-disposition"] = content_disp
        return r.diferencias

    @expose(template='kid:%s.templates.diff' % __name__)
    def verdiff(self, id):
        r = validate_get_comando_ejecutado(id)
        zip = ZipFile(StringIO(r.diferencias), 'r')
        return dict(zip=zip)

    @expose('json')
    def get_instancias_y_grupos(self, ejercicio_id):
        ejercicio = Ejercicio.get(ejercicio_id)
        instancias = ejercicio.instancias_a_entregar
        if ejercicio.grupal:
            grupos = identity.current.user.get_grupos_activos(ejercicio.curso)
        else:
            grupos = []
        return dict(instancias=instancias, grupos=grupos)
#}}}

