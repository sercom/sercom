# vim: set et sw=4 sts=4 encoding=utf-8 :

from turbogears import controllers, expose, redirect
from turbogears import validate, validators, flash, error_handler
from sercom.model import Enunciado, Docente
from turbogears.widgets import *
from turbogears import identity
from turbogears import paginate
from docutils.core import publish_parts
from sercom.subcontrollers import validate as val

cls = Enunciado
name = 'enunciado'
namepl = name + 's'

def validate_autor(data):
    autor = data.get('autorID', None)
    if autor == 0: autor = None
    if autor is not None:
        try:
            autor = Docente.get(autor)
        except LookupError:
            raise redirect('new', tg_flash=_(u'No se pudo crear el nuevo ' \
                '%s porque el autor con identificador %d no existe.'
                    % (name, autor)), **data)
    data.pop('autorID', None)
    data['autor'] = autor

def validate_get(id):
    return val.validate_get(cls, name, id)

def validate_set(id, data):
    validate_autor(data)
    return val.validate_set(cls, name, id, data)

def validate_new(data):
    validate_autor(data)
    return val.validate_new(cls, name, data)

def get_options():
    return [(0, _(u'--'))] + [(a.id, a.shortrepr()) for a in Docente.select()]

form = TableForm(fields=[
    TextField(name='nombre', label=_(u'Nombre'),
        help_text=_(u'Requerido y único.'),
        validator=validators.UnicodeString(min=5, max=60, strip=True)),
    SingleSelectField(name='autorID', label=_(u'Autor'),
        options=get_options, validator=validators.Int(not_empty=False)),
    TextField(name='descripcion', label=_(u'Descripción'),
        validator=validators.UnicodeString(not_empty=False, max=255, strip=True)),
])

class EnunciadoController(controllers.Controller, identity.SecureResource):
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
        f = kw.get('tg_flash', None)
        return dict(name=name, namepl=namepl, form=form, tg_flash=f, values=kw)

    @validate(form=form)
    @error_handler(new)
    @expose()
    def create(self, **kw):
        """Save or create record to model"""
        validate_new(kw)
        raise redirect('list', tg_flash=_(u'Se creó un nuevo %s.') % name)

    @expose(template='kid:sercom.subcontrollers.%s.templates.edit' % name)
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

    @expose(template='kid:sercom.subcontrollers.%s.templates.show' % name)
    def show(self,id, **kw):
        """Show record in model"""
        r = validate_get(id)
        r.desc = publish_parts(r.descripcion, writer_name='html')['html_body']
        return dict(name=name, namepl=namepl, record=r)

    @expose()
    def delete(self, id):
        """Destroy record in model"""
        r = validate_get(id)
        r.destroySelf()
        raise redirect('../list',
            tg_flash=_(u'El %s fue eliminado permanentemente.') % name)

