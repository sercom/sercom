# vim: set et sw=4 sts=4 encoding=utf-8 foldmethod=marker :

#{{{ Imports
from turbogears import controllers, expose, redirect
from turbogears import validate, flash, error_handler
from turbogears import validators as V
from turbogears import widgets as W
from turbogears import identity
from turbogears import paginate
from turbogears import config
from docutils.core import publish_parts
from sercom.presentation.subcontrollers import validate as val
from sercom.model import Ejercicio, Curso, Enunciado, InstanciaDeEntrega, Entregador
from cherrypy import request, response
from sercom.widgets import FocusJSSource
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
class InstanciaForm(W.TableForm):
    class Fields(W.WidgetsList):
        ejercicioID = W.HiddenField()
        numero = W.TextField(name="numero",label=_(u'Nro'), help_text=_(u'Requerido.'),
            validator=V.Int(not_empty=True))
        inicio = W.CalendarDateTimePicker(label=_(u"Inicio"))
        fin = W.CalendarDateTimePicker(label=_(u"Fin"))
        activo = W.CheckBox(label=_(u"Activo?"), attrs=dict(checked='checked'))
        observaciones = W.TextArea(rows="5", cols="40", validator=V.UnicodeString(if_empty=u''))
    fields = Fields()
    javascript = [FocusJSSource('form_numero')]

form = InstanciaForm()
#}}}

#{{{ Controlador
class InstanciaController(controllers.Controller, identity.SecureResource):
    """Basic model admin interface"""
    require = identity.has_any_permission('entregar','enunciado_editar','enunciado_eliminar', 'corregir')

    @expose(template='kid:%s.templates.list' % __name__)
    @validate(validators=dict(ejercicio=V.Int))
    @paginate('records', limit=config.get('items_por_pagina'))
    def list(self, ejercicio):
        ejercicio = Ejercicio.get(ejercicio)
        r = cls.selectBy(ejercicio=ejercicio).orderBy(cls.q.numero)
        return dict(records=r, name=name, namepl=namepl, ejercicio=ejercicio)

    @expose(template='kid:%s.templates.new' % __name__)
    @validate(validators=dict(ejercicio=V.Int))
    @identity.require(identity.in_any_group('admin','JTP','redactor'))
    def new(self, ejercicio, **kw):
        """Create new records in model"""
        kw['ejercicioID'] = ejercicio
        return dict(name=name, namepl=namepl, form=form, values=kw)

    @validate(form=form)
    @error_handler(new)
    @expose()
    @identity.require(identity.in_any_group('admin','JTP','redactor'))
    def create(self, **kw):
        """Save or create record to model"""
        e = Ejercicio.get(kw['ejercicioID'])
        e.add_instancia(**kw)
        flash(_(u'Se creó un nuevo %s.') % name)
        raise redirect('list/%s' % e.id)

    @expose(template='kid:%s.templates.edit' % __name__)
    @identity.require(identity.in_any_group('admin','JTP','redactor'))
    def edit(self, id, **kw):
        """Edit record in model"""
        r = validate_get(id)
        return dict(name=name, namepl=namepl, record=r, form=form)

    @validate(form=form)
    @error_handler(edit)
    @expose()
    @identity.require(identity.in_any_group('admin','JTP','redactor'))
    def update(self, id, **kw):
        """Save or create record to model"""
        r = validate_set(id, kw)
        flash(_(u'El %s fue actualizado.') % name)
        raise redirect('../list/%s' % r.ejercicioID)

    @expose(template='kid:%s.templates.show' % __name__)
    def show(self,id, **kw):
        """Show record in model"""
        r = validate_get(id)
        return dict(name=name, namepl=namepl, record=r)

    @expose()
    @identity.require(identity.in_any_group('admin','JTP','redactor'))
    def delete(self, id):
        """Destroy record in model"""
        r = validate_get(id)
        ejercicio = r.ejercicioID
        r.destroySelf()
        flash(_(u'El %s fue eliminado permanentemente.') % name)
        raise redirect('../list/%s' % ejercicio)

    @expose(template='kid:%s.templates.entregas' % __name__)
    @paginate('records', limit=config.get('items_por_pagina'))
    @identity.require(identity.has_permission('corregir'))
    def entregas(self, instancia_id, entregador_id=None, **kw):
        """Show record in model"""
        instancia = validate_get(instancia_id)
        if entregador_id is None:
            entregas = instancia.entregas
        else:
            entregador = Entregador.get(int(entregador_id))
            entregas = entregador.entregas_de(instancia)
        for e in entregas:
            e.runtime = e.duracion
        return dict(name=name, namepl=namepl, records=entregas, ejercicio=instancia.ejercicio, instancia=instancia)
#}}}

