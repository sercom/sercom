# vim: set et sw=4 sts=4 encoding=utf-8 foldmethod=marker :

#{{{ Imports
import cherrypy
from turbogears import controllers, expose, redirect
from turbogears import validate, flash, error_handler
from turbogears import validators as V
from turbogears import widgets as W
from turbogears import identity
from turbogears import paginate
from docutils.core import publish_parts
from sercom.subcontrollers import validate as val
from sercom.model import TipoPregunta
from sqlobject import *
from sqlobject.main import SQLObjectIntegrityError
#}}}

#{{{ Configuración
cls = TipoPregunta
name = 'Tipo de Pregunta'
namepl = 'Tipos de Pregunta'
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
class TipoPreguntaForm(W.TableForm):
    class Fields(W.WidgetsList):
        descripcion = W.TextField(label=_(u'Descripcion'),
            help_text=_(u'Requerido.'),
            validator=V.UnicodeString( max=100, not_empty=True, strip=True))
    fields = Fields()

form = TipoPreguntaForm()
#}}}

#{{{ Controlador
class TipoPreguntaController(controllers.Controller):

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
        return dict(namepl=namepl, records=TipoPregunta.select())

    @expose(template='kid:%s.templates.new' % __name__)
    def new(self, **kw):
        """Create new records in model"""
        return dict(name=name, namepl=namepl, form=form, values=kw)

    @validate(form=form)
    @error_handler(new)
    @expose()
    def create(self, **kw):
        """Save or create record to model"""
        validate_new(kw)
        flash(_(u'Se creó un nuevo %s.') % name)
        raise redirect('list')

    @expose(template='kid:%s.templates.edit' % __name__)
    def edit(self, id, **kw):
        """Edit record in model"""
        class POD(dict):
            def __getattr__(self, attrname):
                return self[attrname]
        r = POD(validate_get(id).sqlmeta.asDict())
        return dict(name=name, namepl=namepl, record=r, form=form)

    @expose(template='kid:%s.templates.show' % __name__)
    def show(self,id, **kw):
        """Show record in model"""
        r = validate_get(id)
        return dict(name=name, namepl=namepl, record=r)

    @validate(form=form)
    @error_handler(edit)
    @expose()
    def update(self, id, **kw):
        """Save or create record to model"""
        r = validate_set(id, kw)
        flash(_(u'El %s fue actualizado.') % name)
        raise redirect('../list')

    @expose()
    def delete(self, id):
        """Destroy record in model"""
        r = validate_get(id)
        try:
		r.destroySelf()
        	flash(_(u'El %s fue eliminado permanentemente.') % name)
	except SQLObjectIntegrityError:
		flash(_(u'El %s elegido no puede ser eliminado por tener preguntas asociadas.') % name)
	raise redirect('../list')

#}}}
