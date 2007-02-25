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
from sercom.model import Curso
#}}}

#{{{ Configuración
cls = Curso
name = 'curso'
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

#{{{ Formulario
class CursoForm(W.TableForm):
    class Fields(W.WidgetsList):
        anio = W.TextField(label=_(u'Anio'),
            help_text=_(u'Requerido y único.'),
            validator=V.Number(min=4, max=4, strip=True))
        cuatrimestre = W.TextField(label=_(u'Cuatrimestre'),
            help_text=_(u'Requerido.'),
            validator=V.Number(min=1, max=1, strip=True))
        numero = W.TextField(label=_(u'Numero'),
            help_text=_(u'Requerido'),
            validator=V.Number(min=1, max=2, strip=True))
	descripcion = W.TextArea(name='descripcion', label=_(u'Descripcion'),
            help_text=_(u'Descripcion.'),
            validator=V.UnicodeString(not_empty=False, strip=True))
	docentes = W.MultipleSelectField(name="docentes", label=_(u'Docentes'),
            help_text=_(u'Docentes asignados al curso'),
            validator=V.UnicodeString(not_empty=True))
	alumnos = W.MultipleSelectField(name="alumnos", label=_(u'Alumnos'),
            help_text=_(u'Alumnos del curso'),
            validator=V.UnicodeString(not_empty=True))
	grupos = W.MultipleSelectField(name="grupos", label=_(u'Grupos'),
            help_text=_(u'Grupos del curso'),
            validator=V.UnicodeString(not_empty=True))
	ejercicios = W.MultipleSelectField(name="ejercicios", label=_(u'Ejercicios'),
            help_text=_(u'Ejercicios'),
            validator=V.UnicodeString(not_empty=True))
    fields = Fields()
    javascript = [W.JSSource("MochiKit.DOM.focusOnLoad('anio');")]
form = CursoForm()
#}}}

#{{{ Controlador
class CursoController(controllers.Controller, identity.SecureResource):
    """Basic model admin interface"""
    require = identity.has_permission('admin')

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
        r = cls.select()
        return dict(records=r, name=name, namepl=namepl)

    @expose()
    def activate(self, id, activo):
        """Save or create record to model"""
        r = validate_get(id)
        try:
            r.activo = bool(int(activo))
        except ValueError:
            raise cherrypy.NotFound
        raise redirect('../../list')

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
        r = validate_get(id)
        return dict(name=name, namepl=namepl, record=r, form=form)

    @validate(form=form)
    @error_handler(edit)
    @expose()
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
    def delete(self, id):
        """Destroy record in model"""
        r = validate_get(id)
        r.destroySelf()
        flash(_(u'El %s fue eliminado permanentemente.') % name)
        raise redirect('../list')
#}}}

