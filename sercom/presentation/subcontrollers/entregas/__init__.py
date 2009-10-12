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
from sercom.model import Entrega, Correccion
from sercom.ziputil import unzip
from sqlobject import *
from zipfile import ZipFile, BadZipfile
from cStringIO import StringIO
from datetime import datetime
from sercom.presentation.utils.downloader import *
from sercom.presentation.controllers import BaseController
import os, shutil, subprocess
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
    return val.validate_new(cls, name, data)
#}}}

ajax = """
    function mostrarArchivo(res) {
        var lbl = MochiKit.DOM.getElement('lblArchivo');
        lbl.innerText = res.toString();
    }

    function err (err)
    {
        alert("The metadata for MochiKit.Async could not be fetched :(");
    }

    function actualizar_ejercicios()
    {
        clearCombo('form_ejercicio');
        l = MochiKit.DOM.getElement('form_ejercicio');
        url = "/mis_entregas/get_ejercicios";
        var d = loadJSONDoc(url);
        d.addCallbacks(mostrarEjercicios, err);
    }

    function cambiarArchivo(entrega_id, nombre)
    {
        url = "/entregas/get_archivo?entrega_id="+entrega_id+"&nombre="+nombre;
        var d = loadJSONDoc(url);
        d.addCallbacks(mostrarArchivo, err);
    }

"""

#{{{ Controlador
class EntregasController(BaseController, identity.SecureResource):
    """Basic model admin interface"""
    require = identity.has_any_permission('entregar', 'corregir')
    menu_require = identity.has_permission('corregir')

    @expose()
    def default(self, tg_errors=None):
        """handle non exist urls"""
        raise redirect('list')

    @expose()
    def list(self):
        flash('Funcionalidad no implementada')
        raise redirect('/')

    @expose()
    def index(self):
        raise redirect('list')

    @expose('json')
    def get_archivo(self, entrega_id, nombre):
        r = validate_get_entrega(entrega_id)
        download = Downloader(cherrypy.response)
        return download.download_zip_content(r.archivos, nombre)

    @expose()
    def get_pdf(self, entregaid):
        r = validate_get_entrega(entregaid)
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
                "   Ejercicio %d.%d (entrega %s)' -g -o - | ps2pdf - '%s'.pdf" \
                % (basename, r.entregador.nombre, 2009, 1,
                        r.instancia.ejercicio.numero, r.instancia.numero,
                        r.fecha.isoformat(), basename)
        subprocess.check_call(cmd, shell=True) # TODO: capturar excepciones
        pdffile = file('%s.pdf' % basename)
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

