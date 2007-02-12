# vim: set et sw=4 sts=4 encoding=utf-8 :

from turbogears import controllers, expose, redirect
from turbogears import validate, validators, flash, error_handler
from turbogears.widgets import *
from turbogears import identity
from turbogears import paginate
from docutils.core import publish_parts
from sercom.subcontrollers import validate as val
from sercom.model import Docente

cls = Docente
name = 'docente'
namepl = name + 's'

def validate_get(id): return val.validate_get(cls, name, id)
def validate_set(id, data): return val.validate_set(cls, name, id, data)
def validate_new(data): return val.validate_new(cls, name, data)

form = TableForm(fields=[
    TextField(name='usuario', label=_(u'Usuario'),
        help_text=_(u'Requerido y único.'),
        validator=validators.UnicodeString(min=3, max=10, strip=True)),
    TextField(name='nombre', label=_(u'Nombre'),
        help_text=_(u'Requerido.'),
        validator=validators.UnicodeString(min=10, max=255, strip=True)),
    TextField(name='email', label=_(u'E-Mail'),
        #help_text=_(u'Dirección de e-mail.'),
        validator=validators.All(
            validators.Email(not_empty=False, resolve_domain=True),
            validators.UnicodeString(not_empty=False, max=255, strip=True))),
    TextField(name='telefono', label=_(u'Teléfono'),
        #help_text=_(u'Texto libre para teléfono, se puede incluir horarios o varias entradas.'),
        validator=validators.UnicodeString(not_empty=False, min=7, max=255, strip=True)),
    TextArea(name='observaciones', label=_(u'Observaciones'),
        #help_text=_(u'Observaciones.'),
        validator=validators.UnicodeString(not_empty=False, strip=True)),
    CheckBox(name='nombrado', label=_(u'Nombrado'), default=1,
        #help_text=_(u'Indica si tiene cargo.'),
        validator=validators.Bool(if_empty=1)),
    CheckBox(name='activo', label=_(u'Activo'), default=1,
        #help_text=_(u'Si no está activo no puede ingresar al sistema.'),
        validator=validators.Bool(if_empty=1)),
])

class DocenteController(controllers.Controller, identity.SecureResource):
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
    def list(self, **kw):
        """List records in model"""
        f = kw.get('tg_flash', None)
        r = cls.select()
        return dict(records=r, name=name, namepl=namepl, tg_flash=f)

    @expose()
    def activate(self, id, activo):
        """Save or create record to model"""
        r = validate_get(id)
        try:
            r.activo = bool(int(activo))
        except ValueError, e:
            raise redirect('../list', tg_flash=_(u'Acción inválida.'))
        raise redirect('../list')

    @expose(template='kid:%s.templates.new' % __name__)
    def new(self, **kw):
        """Create new records in model"""
        f = kw.get('tg_flash', None)
        return dict(name=name, namepl=namepl, form=form, tg_flash=f, values=kw)

    @validate(form=form)
    @error_handler(new)
    @expose()
    def create(self, **kw):
        """Save or create record to model"""
        validate_new(kw)
        raise redirect('list', tg_flash=_(u'Se creó un nuevo %s.') % name)

    @expose(template='kid:%s.templates.edit' % __name__)
    def edit(self, id, **kw):
        """Edit record in model"""
        r = validate_get(id)
        return dict(name=name, namepl=namepl, record=r, form=form,
            tg_flash=kw.get('tg_flash', None))

    @validate(form=form)
    @error_handler(edit)
    @expose()
    def update(self, id, **kw):
        """Save or create record to model"""
        r = validate_set(id, kw)
        raise redirect('../list',
            tg_flash=_(u'El %s fue actualizado.') % name)

    @expose(template='kid:%s.templates.show' % __name__)
    def show(self,id, **kw):
        """Show record in model"""
        r = validate_get(id)
        if r.observaciones is None:
            r.obs = ''
        else:
            r.obs = publish_parts(r.observaciones, writer_name='html')['html_body']
        return dict(name=name, namepl=namepl, record=r)

    @expose()
    def delete(self, id):
        """Destroy record in model"""
        r = validate_get(id)
        r.destroySelf()
        raise redirect('../list',
            tg_flash=_(u'El %s fue eliminado permanentemente.') % name)

