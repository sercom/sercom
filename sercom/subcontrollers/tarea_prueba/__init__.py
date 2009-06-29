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
from sercom.subcontrollers import validate as val
from sercom.model import TareaPrueba
from sqlobject import *
from comandos import ComandoPruebaController
#}}}

#{{{ Configuración
cls = TareaPrueba
name = 'tarea prueba'
namepl = 'tareas prueba'
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
class TareaPruebaForm(W.TableForm):
    class Fields(W.WidgetsList):
        nombre = W.TextField(label=_(u'Nombre'),validator=V.UnicodeString(min=3, max=30, strip=True))
        descripcion = W.TextField(label=_(u'Descripcion'),
            validator=V.UnicodeString(not_empty=False, max=255, strip=True))
    fields = Fields()
    javascript = [W.JSSource("MochiKit.DOM.focusOnLoad('form_nombre');")]

form = TareaPruebaForm()
#}}}

#{{{ Controlador
class TareaPruebaController(controllers.Controller, identity.SecureResource):
    """Basic model admin interface"""
    require = identity.in_any_group('admin','JTP','redactor')

    comandos = ComandoPruebaController()

    hide_to_entregar = 1

    @expose()
    def default(self, tg_errors=None):
        """handle non exist urls"""
        raise redirect('list')

    @expose()
    def index(self):
        raise redirect('list')

    @expose(template='kid:%s.templates.list' % __name__)
    @paginate('records', limit=config.get('items_por_pagina'))
    @identity.require(identity.has_permission('admin'))
    def list(self):
        """List records in model"""
        r = cls.select()
        return dict(records=r, name=name, namepl=namepl)

    @expose(template='kid:%s.templates.new' % __name__)
    @identity.require(identity.has_permission('admin'))
    def new(self, **kw):
        """Create new records in model"""
        return dict(name=name, namepl=namepl, form=form, values=kw)

    @validate(form=form)
    @error_handler(new)
    @expose()
    @identity.require(identity.has_permission('admin'))
    def create(self, **kw):
        """Save or create record to model"""
        validate_new(kw)
        flash(_(u'Se creó un nuevo %s.') % name)
        raise redirect('list')

    @expose(template='kid:%s.templates.edit' % __name__)
    @identity.require(identity.has_permission('admin'))
    def edit(self, id, **kw):
        """Edit record in model"""
        r = validate_get(id)
        return dict(name=name, namepl=namepl, record=r, form=form)

    @validate(form=form)
    @error_handler(edit)
    @expose()
    @identity.require(identity.has_permission('admin'))
    def update(self, id, **kw):
        """Save or create record to model"""
        r = validate_set(id, kw)
        flash(_(u'El %s fue actualizado.') % name)
        raise redirect('../list')

    @expose(template='kid:%s.templates.show' % __name__)
    def show(self,id, **kw):
        """Show record in model"""
        r = validate_get(id)
        return dict(name=name, namepl=namepl, record=r)

    @expose()
    @identity.require(identity.has_permission('admin'))
    def delete(self, id):
        """Destroy record in model"""
        r = validate_get(id)
        r.destroySelf()
        flash(_(u'El %s fue eliminado permanentemente.') % name)
        raise redirect('../list')
#}}}

