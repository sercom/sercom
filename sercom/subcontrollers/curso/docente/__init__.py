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
from sercom.model import DocenteInscripto, Curso, Docente
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
def get_docentes():
    return [(d.id, d) for d in Docente.select()]

class DocenteInscriptoForm(W.TableForm):
    class Fields(W.WidgetsList):
       cursoID = W.HiddenField()
       docente = W.SingleSelectField(label=_(u'Docente'), options = get_docentes,
       validator = V.Int(not_empty=True))

       corrige = W.CheckBox(label=_(u'Corrige?'))

       observaciones = W.TextArea(name='observaciones', label=_(u'Observaciones'),
            validator=V.UnicodeString(not_empty=False, strip=True))

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
        raise redirect(url('/curso/list'))

    @expose()
    def index(self):
        raise redirect(url('/curso/list'))


    @expose(template='kid:%s.templates.list' % __name__)
    @paginate('records')
    def list(self, cursoID):
        """List records in model"""
        r = cls.select(cls.q.cursoID==cursoID)
        return dict(records=r, name=name, namepl=namepl, curso=Curso.get(cursoID))

    @expose(template='kid:%s.templates.new' % __name__)
    def new(self, cursoID, **kw):
        """Create new records in model"""
        form.fields[0].attrs['value'] = cursoID
        return dict(name=name, namepl=namepl, form=form, values=kw, curso=Curso.get(cursoID))

    @validate(form=form)
    @error_handler(new)
    @expose()
    def create(self, **kw):
        """Save or create record to model"""
        r = validate_new(kw)
        flash(_(u'Se creó un nuevo %s.') % name)
        raise redirect(url('/curso/docente/list/%d' % r.curso.id))

    @expose(template='kid:%s.templates.edit' % __name__)
    def edit(self, id, **kw):
        """Edit record in model"""
        r = validate_get(id)
        class EmptyClass:
            pass
        values = EmptyClass()
        values.id = r.id
        values.docente = r.docente.id
        values.corrige = r.corrige
        values.observaciones = r.observaciones
        values.curso = r.curso
        values.cursoID = r.curso.id
        return dict(name=name, namepl=namepl, record=values, form=form)

    @validate(form=form)
    @error_handler(edit)
    @expose()
    def update(self, id, **kw):
        """Save or create record to model"""
        r = validate_set(id, kw)
        flash(_(u'El %s fue actualizado.') % name)
        raise redirect(url('/curso/docente/list/%d' % r.curso.id))

    @expose(template='kid:%s.templates.show' % __name__)
    def show(self,id, **kw):
        """Show record in model"""
        r = validate_get(id)
        return dict(name=name, namepl=namepl, record=r)

    @expose()
    def delete(self, cursoID, id):
        """Destroy record in model"""
        r = validate_get(id)
        r.destroySelf()
        flash(_(u'El %s fue eliminado permanentemente.') % name)
        raise redirect(url('/curso/docente/list/%s' % cursoID))
#}}}

