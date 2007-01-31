# vim: set et sw=4 sts=4 encoding=utf-8 :

from turbogears import controllers, expose, redirect
from turbogears import validate, validators, flash, error_handler
from sercom.model import Docente
from turbogears.widgets import *
from turbogears import identity
from turbogears import paginate
from docutils.core import publish_parts

cls = Docente
name = 'docente'
namepl = name + 's'

form = TableForm(fields=[
    TextField(name='usuario', label=_(u'Usuario'),
        help_text=_(u'Requerido.'),
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

def minimize(text, size=15):
    if text is not None and len(text) > size:
        text = text[:size] + '...'
    return text

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

    @expose(template='kid:sercom.subcontrollers.%s.templates.list' % name)
    @paginate('records')
    def list(self, **kw):
        """List records in model"""
        f = kw.get('tg_flash', None)
        r = cls.select()

        return dict(records=r, name=name, namepl=namepl, tg_flash=f)

    @expose(template='kid:sercom.subcontrollers.%s.templates.new' % name)
    def new(self, **kw):
        """Create new records in model"""
        return dict(name=name, namepl=namepl, form=form)

    @validate(form=form)
    @error_handler(new)
    @expose()
    def create(self, **kw):
        """Save or create record to model"""
        Docente(**kw)

        raise redirect('list', tg_flash=_(u'Se creó un nuevo %s.') % name)

    @expose(template='kid:sercom.subcontrollers.%s.templates.edit' % name)
    def edit(self, id, **kw):
        """Edit record in model"""
        try:
            r = cls.get(int(id))
        except LookupError:
            flash = _('No existe el docente con identificador %d.') % id

        return dict(name=name, namepl=namepl, record=r, form=form)

    @validate(form=form)
    @error_handler(edit)
    @expose()
    def update(self, id, **kw):
        """Save or create record to model"""
        record = cls.get(int(id))
        record.set(**kw)

        raise redirect('../list',
            tg_flash=_(u'El %s fue actualizado.') % name)

    @expose(template='kid:sercom.subcontrollers.%s.templates.show' % name)
    def show(self,id, **kw):
        """Show record in model"""
        r = cls.get(int(id))
        r.obs = publish_parts(r.observaciones, writer_name='html')['html_body']

        return dict(name=name, namepl=namepl, record=r)

    @expose()
    def delete(self, id):
        """Destroy record in model"""
        cls.delete(int(id))

        raise redirect('../list',
            tg_flash=_(u'El %s fue eliminado permanentemente.') % name)

