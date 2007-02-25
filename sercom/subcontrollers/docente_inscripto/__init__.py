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
from sercom.model import DocenteInscripto
#}}}

#{{{ Configuración
cls = DocenteInscripto
name = 'Docente Inscripto'
namepl = 'Docentes Inscriptos'
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
class DocenteInscriptoForm(W.TableForm):
    class Fields(W.WidgetsList):
       curso = W.SingleSelectField(label=_(u'Curso'),
            help_text=_(u'Requerido'),
       docente = W.SingleSelectField(label=_(u'Docente'),
            help_text=_(u'Requerido'),
       corrige = W.CheckBoxField(label=_(u'Corrige'), options=[(1='Corrige')],
            help_text=_(u'Requerido.'),
            validator=V.Number(min=1, max=1, strip=True))
       observaciones = W.TextArea(name='observaciones', label=_(u'Observaciones'),
            help_text=_(u'Observaciones'),
            validator=V.UnicodeString(not_empty=False, strip=True))
       #alumnos = W.MultipleSelectField(name="alumnos", label=_(u'Alumnos'),
       #    help_text=_(u'Alumnos del DocenteInscripto'),
       #    validator=V.UnicodeString(not_empty=True))
    fields = Fields()
    javascript = [W.JSSource("MochiKit.DOM.focusOnLoad('curso');")]
form = DocenteInscriptoForm()
#}}}

#{{{ Controlador
class DocenteInscriptoController(controllers.Controller, identity.SecureResource):
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

