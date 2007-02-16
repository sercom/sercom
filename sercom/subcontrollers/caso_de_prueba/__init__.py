# vim: set et sw=4 sts=4 encoding=utf-8 :

from turbogears import controllers, expose, redirect
from turbogears import validate, validators, flash, error_handler
from turbogears.widgets import *
from turbogears import identity
from turbogears import paginate
from docutils.core import publish_parts
from sercom.subcontrollers import validate as val
from sercom.model import CasoDePrueba, Enunciado

cls = CasoDePrueba
name = 'caso de prueba'
namepl = 'casos de prueba'

fkcls = Enunciado
fkname = 'enunciado'
fknamepl = fkname + 's'

def validate_fk(data):
    fk = data.get(fkname + 'ID', None)
    if fk == 0: fk = None
    if fk is not None:
        try:
            fk = fkcls.get(fk)
        except LookupError:
            raise redirect('new', tg_flash=_(u'No se pudo crear el nuevo ' \
                '%s porque el %s con identificador %d no existe.'
                    % (name, fkname, fk)), **data)
    data.pop(fkname + 'ID', None)
    data[fkname] = fk
    return fk

def validate_get(id):
    return val.validate_get(cls, name, id)

def validate_set(id, data):
    validate_fk(data)
    return val.validate_set(cls, name, id, data)

def validate_new(data):
    validate_fk(data)
    return val.validate_new(cls, name, data)

def get_options():
    return [(0, _(u'<<General>>'))] + [(fk.id, fk.shortrepr())
        for fk in fkcls.select()]

form = TableForm(fields=[
    TextField(name='nombre', label=_(u'Nombre'),
        help_text=_(u'Requerido y único.'),
        validator=validators.UnicodeString(min=5, max=60, strip=True)),
    SingleSelectField(name=fkname+'ID', label=_(fkname.capitalize()),
        options=get_options, validator=validators.Int(not_empty=False)),
    TextField(name='descripcion', label=_(u'Descripción'),
        validator=validators.UnicodeString(not_empty=False, max=255, strip=True)),
    TextField(name='retorno', label=_(u'Código de retorno'),
        validator=validators.Int(not_empty=False, strip=True)),
    TextField(name='tiempo_cpu', label=_(u'Tiempo de CPU'),
        validator=validators.Number(not_empty=False, strip=True)),
])

class CasoDePruebaController(controllers.Controller, identity.SecureResource):
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
    @validate(validators=dict(enunciado=validators.Int))
    @paginate('records')
    def list(self, enunciado=None, tg_flash=None):
        """List records in model"""
        if enunciado is None:
            r = cls.select()
        else:
            r = cls.selectBy(enunciadoID=enunciado)
        return dict(records=r, name=name, namepl=namepl, tg_flash=tg_flash)

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
    def show(self, id, **kw):
        """Show record in model"""
        r = validate_get(id)
        if r.descripcion is None:
            r.desc = ''
        else:
            r.desc = publish_parts(r.descripcion, writer_name='html')['html_body']
        return dict(name=name, namepl=namepl, record=r)

    @expose()
    def delete(self, id):
        """Destroy record in model"""
        r = validate_get(id)
        r.destroySelf()
        raise redirect('../list',
            tg_flash=_(u'El %s fue eliminado permanentemente.') % name)

