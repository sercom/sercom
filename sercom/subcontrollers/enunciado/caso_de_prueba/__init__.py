# vim: set et sw=4 sts=4 encoding=utf-8 foldmethod=marker :

#{{{ Imports
from turbogears import controllers, expose, redirect
from turbogears import validate, flash, error_handler
from turbogears import validators as V
from turbogears import widgets as W
from turbogears import identity
from turbogears import paginate
from docutils.core import publish_parts
from sercom.subcontrollers import validate as val
from sercom.model import CasoDePrueba, Enunciado
#}}}

#{{{ Configuración
cls = CasoDePrueba
name = 'caso de prueba'
namepl = 'casos de prueba'

fkcls = Enunciado
fkname = 'enunciado'
fknamepl = fkname + 's'
#}}}

#{{{ Validación
def validate_fk(data):
    fk = data.get(fkname + 'ID', None)
    if fk == 0: fk = None
    if fk is not None:
        try:
            fk = fkcls.get(fk)
        except LookupError:
            flash(_(u'No se pudo crear el nuevo %s porque el %s con '
                'identificador %d no existe.' % (name, fkname, fk)))
            raise redirect('new', **data)
    else:
        flash(_(u'No se pudo crear el nuevo %s porque el %s con '
            'identificador %d no existe.' % (name, fkname, fk)))
        raise redirect('new', **data)
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

def validate_del(id):
    return val.validate_del(cls, name, id)
#}}}

#{{{ Formulario
class CasoDePruebaForm(W.TableForm):
    class Fields(W.WidgetsList):
        enunciadoID = W.HiddenField()
        nombre = W.TextField(label=_(u'Nombre'),
            help_text=_(u'Requerido y único.'),
            validator=V.UnicodeString(min=5, max=60, strip=True))
        descripcion = W.TextField(label=_(u'Descripción'),
            validator=V.UnicodeString(not_empty=False, max=255,
                strip=True))
        comando = W.TextField(label=_(u'Comando'),
            validator=V.UnicodeString(not_empty=False, strip=True))
        retorno = W.TextField(label=_(u'Código de retorno'),
            validator=V.Int(not_empty=False, strip=True))
        max_tiempo_cpu = W.TextField(label=_(u'Máximo tiempo de CPU'),
            validator=V.Number(not_empty=False, strip=True))
    fields = Fields()
    javascript = [W.JSSource("MochiKit.DOM.focusOnLoad('form_nombre');")]

form = CasoDePruebaForm()
#}}}

#{{{ Controlador

class CasoDePruebaController(controllers.Controller, identity.SecureResource):
    """Basic model admin interface"""
    require = identity.has_permission('admin')

    @expose(template='kid:%s.templates.list' % __name__)
    @validate(validators=dict(enunciado=V.Int))
    @paginate('records')
    def list(self, enunciado):
        """List records in model"""
        r = cls.selectBy(enunciadoID=enunciado)
        return dict(records=r, name=name, namepl=namepl, enunciado=enunciado)

    @expose(template='kid:%s.templates.new' % __name__)
    def new(self, enunciado=0, **kw):
        """Create new records in model"""
        form.fields[0].attrs['value'] = enunciado or kw['enunciadoID']
        return dict(name=name, namepl=namepl, form=form, values=kw, enunciado=int(enunciado))

    @validate(form=form)
    @error_handler(new)
    @expose()
    def create(self, **kw):
        """Save or create record to model"""
        r = validate_new(kw)
        flash(_(u'Se creó un nuevo %s.') % name)
        raise redirect('list/%d' % r.enunciado.id)

    @expose(template='kid:%s.templates.edit' % __name__)
    def edit(self, id, **kw):
        """Edit record in model"""
        r = validate_get(id)
        form.fields[0].attrs['value'] = r.enunciado.id
        return dict(name=name, namepl=namepl, record=r, form=form)

    @validate(form=form)
    @error_handler(edit)
    @expose()
    def update(self, id, **kw):
        """Save or create record to model"""
        r = validate_set(id, kw)
        flash(_(u'El %s fue actualizado.') % name)
        raise redirect('../list/%d' % r.enunciado.id)

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
    def delete(self, enunciado, id):
        """Destroy record in model"""
        validate_del(id)
        flash(_(u'El %s fue eliminado permanentemente.') % name)
        raise redirect('../../list/%d' % int(enunciado))
#}}}

