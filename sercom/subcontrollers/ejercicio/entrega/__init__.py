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
from sercom.model import Ejercicio, Curso, Enunciado, InstanciaDeEntrega
from cherrypy import request, response
#}}}

#{{{ Configuración
cls = InstanciaDeEntrega
name = 'instancia de entrega'
namepl = 'instancias de entrega'

fkcls = Ejercicio
fkname = 'ejercicio'
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
#}}}

#{{{ Formulario
def get_options():
    return [(0, _(u'--'))] + [(fk.id, fk.shortrepr()) for fk in fkcls.select()]

class EntregaForm(W.TableForm):
    class Fields(W.WidgetsList):
        numero = W.TextField(name="numero",label=_(u'Nro'), help_text=_(u'Requerido.'),
            validator=V.Int(not_empty=True))
        inicio = W.CalendarDateTimePicker(label=_(u"Inicio"))
        fin = W.CalendarDateTimePicker(label=_(u"Fin"))
        procesada = W.CheckBox(label=_(u"Procesada?"))
        activo = W.CheckBox(label=_(u"Activo?"))
        observaciones = W.TextArea(rows="5", cols="40")
        ejercicio_id= W.HiddenField()
    fields = Fields()
    javascript = [W.JSSource("MochiKit.DOM.focusOnLoad('form_nombre');")]

form = EntregaForm()
#}}}

#{{{ Controlador
class EntregaController(controllers.Controller, identity.SecureResource):
    """Basic model admin interface"""
    require = identity.has_permission('admin')

    @expose(template='kid:%s.templates.list' % __name__)
    @validate(validators=dict(ejercicio_id=V.Int))
    @paginate('records')
    def default(self, ejercicio_id):
        e = Ejercicio.get(ejercicio_id)
        r = e.instancias
        return dict(records=r, name=name, namepl=namepl, parcial=str(ejercicio_id))

    @expose(template='kid:%s.templates.new' % __name__)
    def new(self, ejercicio_id, **kw):
        """Create new records in model"""
        form.fields[6].attrs['value'] = ejercicio_id
        return dict(name=name, namepl=namepl, form=form, values=kw, partial=str(ejercicio_id))

    @validate(form=form)
    @error_handler(new)
    @expose()
    def create(self, ejercicio_id, **kw):
        """Save or create record to model"""
        e = Ejercicio.get(ejercicio_id)
        e.add_instancia(**kw)
        flash(_(u'Se creó un nuevo %s.') % name)
        raise redirect('/ejercicio/entrega/'+str(e.id))

    @expose()
    def delete(self, id):
        """Destroy record in model"""
        r = validate_get(id)
        r.destroySelf()
        flash(_(u'El %s fue eliminado permanentemente.') % name)
        raise redirect('../list')

#}}}

