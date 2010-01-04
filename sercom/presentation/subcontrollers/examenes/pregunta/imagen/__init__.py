# vim: set et sw=4 sts=4 encoding=utf-8 foldmethod=marker :

#{{{ Imports
import cherrypy
from turbogears import controllers, expose, redirect
from turbogears import validate, flash, error_handler
from turbogears import validators as V
from turbogears import widgets as W
from turbogears import identity
from turbogears import paginate
from turbogears import config
from docutils.core import publish_parts
from sercom.presentation.controllers import BaseController
from sercom.presentation.utils.downloader import *
from sercom.presentation.subcontrollers import validate as val
from sercom.model import PreguntaExamen, TemaPregunta, TipoPregunta, Imagen, Permiso
from sqlobject import *
from datetime import datetime
#}}}

#{{{ Configuración
cls = Imagen
name = 'Imagen'
namepl = name + 'es'
#}}}

#{{{ Validación
def validate_get(id):
    return val.validate_get(cls, name, id)

def validate_set(id, data):
    return val.validate_set(cls, name, id, data)

def validate_new(data):
    return val.validate_new(cls, name, data)
#}}}


#{{{ Formulario
class ImagenForm(W.TableForm):
    class Fields(W.WidgetsList):
	nombre = W.TextField(validator=V.UnicodeString(max=200, strip=True))
	archivo = W.FileField()
    fields = Fields()

form = ImagenForm()

#}}}

#{{{ Controlador
class ImagenController(BaseController):

    @expose()
    def default(self, tg_errors=None):
        """handle non exist urls"""
        raise redirect('list')

    @identity.require(identity.has_permission(Permiso.examen.editar))
    @expose(template='kid:%s.templates.new' % __name__)
    def new(self, **kw):
        """Create new records in model"""
        return dict(name=name, namepl=namepl, form=form, values=kw)

    @expose(template='kid:%s.templates.list' % __name__)
    @paginate('records', dynamic_limit='limit_to')
    def list(self):
        """List records in model"""
        r = cls.select()
        return dict(records=r, name=name, namepl=namepl, limit_to=self.get_limite_paginado())

    @identity.require(identity.has_permission(Permiso.examen.editar))
    @validate(form=form)
    @error_handler(new)
    @expose()
    def create(self, archivo, **kw):
        """Save or create record to model"""
        contenido = archivo.file.read()
        kw['tamanio'] = len(contenido)
        kw['contenido'] = contenido
        kw['tipo_de_contenido'] = archivo.type
        kw['nombre_archivo'] = archivo.filename
        validate_new(kw)
        flash(_(u'Se creó una nueva %s.') % name)
        raise redirect('list')

    @expose(template='kid:%s.templates.show' % __name__)
    def show(self,id, **kw):
        """Show record in model"""
        r = validate_get(id)
        download = Downloader(cherrypy.response)
        return download.download_image(r.contenido, r.tipo_de_contenido, r.nombre_archivo)

#}}}

