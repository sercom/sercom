# vim: set et sw=4 sts=4 encoding=utf-8 foldmethod=marker 

#{{{ Imports
import cherrypy
from turbogears import config
from turbogears import expose, redirect, url
from turbogears import validate, flash, error_handler
from turbogears import validators as V
from turbogears import widgets as W
from turbogears import identity
from turbogears import paginate
from docutils.core import publish_parts
from sercom.presentation.subcontrollers import validate as val
from sercom.model import Entrega, Correccion, InstanciaDeEntrega, AlumnoInscripto, Grupo
from sercom.ziputil import unzip
from sqlobject import *
from string import Template
from zipfile import ZipFile, BadZipfile
from cStringIO import StringIO
from datetime import datetime
from sercom.presentation.utils.downloader import *
from sercom.presentation.controllers import BaseController
import os, shutil, subprocess
from subprocess import Popen
from subprocess import PIPE
#}}}

#{{{ Configuración
cls = Entrega
name = 'entrega'
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
    return val.create_record(cls, name, data, '/', '/entregas/force_new')
#}}}

#{{{ Ajax

ajax = """
    function mostrarEntregadores(res)
    {
        for(i=0; i < res.entregadores.length; i++) {
            id = res.entregadores[i].id;
            label = res.entregadores[i].descripcion;
            MochiKit.DOM.appendChildNodes('form_entregador', OPTION({'value':id}, label))
        }
    }

    function err (err)
    {
        alert("The metadata for MochiKit.Async could not be fetched :(");
    }

    function actualizar_entregadores ()
    {
        MochiKit.DOM.getElement('form_entregador').options.length = 0;
        var cmb = MochiKit.DOM.getElement('form_instancia');
        var id = cmb.options[cmb.selectedIndex].value;
        if (id != 0) {
            url = "/entregas/get_entregadores_para_instancia?instancia_id="+id;
            var d = loadJSONDoc(url);
            d.addCallbacks(mostrarEntregadores, err);
        }
    }
    MochiKit.DOM.focusOnLoad('form_instancia');
"""

#}}}

#{{{ Formulario
class ForceEntregaForm(W.TableForm):
    class Fields(W.WidgetsList):
        instancia = W.SingleSelectField(label=_(u'Instancia'),attrs=dict(onchange='actualizar_entregadores()'),
             validator=V.Int(not_empty=True))
        entregador = W.SingleSelectField(label=_(u'Entregador'), validator=V.Int(not_empty=True))
        archivo = W.FileField(label=_(u'Archivo'), help_text=_(u'Archivo en formato ZIP con la entrega'))
    fields = Fields()
    javascript = [W.JSSource(ajax)]

form = ForceEntregaForm()

#}}}

#{{{ Controlador
class EntregasController(BaseController, identity.SecureResource):
    """Basic model admin interface"""
    require = identity.has_any_permission('entregar', 'corregir')
    menu_require = identity.has_permission('corregir')

    @expose()
    def default(self, tg_errors=None):
        """handle non exist urls"""
        raise redirect('statistics')

    @expose()
    def list(self):
        raise redirect('statistics')

    @expose()
    def index(self):
        raise redirect('statistics')

    @expose(template='kid:%s.templates.statistics' % __name__)
    @identity.require(identity.has_permission('corregir'))
    def statistics(self, **kw):
        """Crea el formulario de estadisticas sobre entregas"""
        curso = self.get_curso_actual()
        cant_entregas = []
        for e in curso.ejercicios:
            cant_entregas += [(i.shortrepr(), len(i.entregas)) for i in e.instancias]
        return dict(cant_entregas=cant_entregas)

    @expose(template='kid:%s.templates.force_new' % __name__)
    @identity.require(identity.has_permission('corregir'))
    def force_new(self, **kw):
        """Crea el formulario para subir una entrega en lugar de un alumno"""
        curso = self.get_curso_actual()
        instancia_options = [(0, 'Seleccionar')]
        for e in curso.ejercicios:
            instancia_options += [(i.id, i.longrepr()) for i in e.instancias]
        return dict(name=name, namepl=namepl, form=form, values=kw, options=dict(instancia=instancia_options))

    @validate(form=form)
#    @error_handler(force_new)
    @expose()
    @identity.require(identity.has_permission('corregir'))
    def force_create(self, archivo, instancia, entregador, **kw):
        """Sube una entrega en lugar de un alumno"""
        archivo = archivo.file.read()
        try:
            zfile = ZipFile(StringIO(archivo), 'r')
        except BadZipfile:
            flash(_(u'El archivo ZIP no es válido'))
            raise redirect('force_new', kw)
        if zfile.testzip() is not None:
            flash(_(u'El archivo ZIP tiene errores de CRC'))
            raise redirect('force_new',kw)

        entregador_id = int(entregador)
        instancia = InstanciaDeEntrega.get(int(instancia))
        if instancia.ejercicio.grupal:
            entregador = Grupo.get(entregador_id)
        else:
            entregador = AlumnoInscripto.get(entregador_id)

        kw['instancia'] = instancia
        kw['archivos'] = archivo
        kw['entregador'] = entregador
        kw['observaciones'] = 'Entrega realizada manualmente por el docente %s' % identity.current.user.shortrepr()
        Entrega(**kw)
        flash('Se creo una nueva entrega')
        raise redirect('list')

    @expose(template='kid:%s.templates.corrida' % __name__)
    def corrida(self, entregaid):
        e = validate_get_entrega(entregaid)
        return dict(entrega=e)


    @expose(template='kid:%s.templates.browse_files' % __name__)
    def browse_files(self, entrega_id):
        e = validate_get_entrega(entrega_id)
        return dict(entrega=e)

    @expose('json')
    def get_entregadores_para_instancia(self, instancia_id):
        curso = self.get_curso_actual()
        instancia = InstanciaDeEntrega.get(instancia_id)
        if instancia.ejercicio.grupal:
            entregadores = [dict(id=g.id, descripcion=g.shortrepr()) for g in curso.grupos]
        else:
            entregadores = [dict(id=ai.id, descripcion=ai.shortrepr()) for ai in curso.alumnos]
        return dict(entregadores=entregadores)

    @expose('json')
    def get_archivo(self, entrega_id, nombre):
        r = validate_get_entrega(entrega_id)
        download = Downloader(cherrypy.response)
        return dict(file_text= download.download_zip_content(r.archivos, nombre))

    @expose('json')
    def get_fuente_c_formato(self, entrega_id, nombre):
        from sercom.ziputil import *
        r = validate_get_entrega(entrega_id)
        cpp = unzip_arch_interno(r.archivos, nombre).encode('ascii', 'replace')
	p = Popen(["highlight", "-S", "cpp", "-X", "--fragment"], stdin=PIPE, stdout=PIPE)
	p.stdin.write(cpp)
	p.stdin.close()
	html = p.stdout.read()
        return dict(file_html=html)

    @expose()
    def get_pdf(self, entregaid):
        r = validate_get_entrega(entregaid)
        # TODO: config de tmp dir y cache de PDFs
        basename = os.path.join('/tmp', 'pdf-%d-%s'
                % (r.id, datetime.now().isoformat()))
        os.mkdir(basename) # TODO: capturar excepciones
        unzip(r.archivos, basename) # TODO: capturar excepciones
        pdf_filepath = '%s.pdf' % basename
        pdf_cmd_template = config.get('template_comando_creacion_pdf')
        pdf_cmd = Template(pdf_cmd_template).substitute(alumno=r.entregador.nombre, cuatrimestre = unicode(r.instancia.ejercicio.curso), ejercicio = r.instancia.ejercicio.numero, instancia = r.instancia.numero, fecha = r.fecha.isoformat(), pdf_filepath=pdf_filepath)
        cmd = "cd '%s'; %s" % (basename, pdf_cmd)




        subprocess.check_call(cmd, shell=True) # TODO: capturar excepciones
        pdffile = file(pdf_filepath)
        pdf = pdffile.read()
        pdffile.close()
        shutil.rmtree(basename) # TODO: capturar excepciones
        os.unlink('%s.pdf' % basename) # TODO: capturar excepciones
        download = Downloader(cherrypy.response)
        nombre = "%s-ej%d.%d.%s.pdf" %(
            r.entregador.nombre, r.instancia.ejercicio.numero,
            r.instancia.numero, r.fecha.strftime('%Y-%m-%d %H.%Mhs'))
        return download.download_pdf(pdf, nombre)


#}}}

