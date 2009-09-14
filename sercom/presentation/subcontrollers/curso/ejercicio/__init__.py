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
from sercom.presentation.controllers import BaseController
from sercom.presentation.subcontrollers import validate as val
from sercom.model import Ejercicio, Curso, Enunciado
from cherrypy import request, response
from instancia import InstanciaController
#}}}

#{{{ Configuración
cls = Ejercicio
name = 'ejercicio'
namepl = name + 's'

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
class EjercicioForm(W.TableForm):
    class Fields(W.WidgetsList):
        cursoID = W.HiddenField(validator=V.Int)
        numero = W.TextField(name="numero",label=_(u'Nro'),
            help_text=_(u'Requerido.'),
            validator=V.Int(not_empty=True))
        fk = W.SingleSelectField(name=fkname+'ID', label=_(fkname.capitalize()),
            validator=V.Int(not_empty=True))
        grupal = W.CheckBox(name='grupal', label=_(u"Grupal?"), validator=V.Bool(if_empty=0), default=0)
    fields = Fields()
    javascript = [W.JSSource("MochiKit.DOM.focusOnLoad('form_numero');")]

form = EjercicioForm()
#}}}

#{{{ Controlador
class EjercicioController(BaseController, identity.SecureResource):
    """Basic model admin interface"""
    require = identity.has_any_permission('entregar','enunciado_editar','enunciado_eliminar')

    instancia = InstanciaController()

    @expose(template='kid:%s.templates.list' % __name__)
    @validate(validators=dict(curso_id=V.Int))
    @paginate('records', limit=config.get('items_por_pagina'))
    def list(self, curso_id=None):
        """List records in model"""
        if curso_id:
            curso = Curso.get(curso_id)
        else:
            curso = self.get_curso_actual()

        r = cls.selectBy(cursoID=curso.id).orderBy(cls.q.numero)
        return dict(records=r, name=name, namepl=namepl, curso=curso)

    @expose(template='kid:%s.templates.new' % __name__)
    @validate(validators=dict(curso=V.Int))
    @identity.require(identity.in_any_group('admin','JTP','redactor'))
    def new(self, curso, **kw):
        """Create new records in model"""
        kw['cursoID'] = curso
        curso = Curso.get(curso)
        options = { fkname+'ID': [(e.id, e) for e in
            Enunciado.selectBy(anio=curso.anio,
                cuatrimestre=curso.cuatrimestre)] }
        return dict(name=name, namepl=namepl, form=form, values=kw, options=options)

    @validate(form=form)
    @error_handler(new)
    @identity.require(identity.in_any_group('admin','JTP','redactor'))
    @expose()
    def create(self, **kw):
        """Save or create record to model"""
        validate_new(kw)
        flash(_(u'Se creó un nuevo %s.') % name)
        raise redirect('list/%s' % kw['cursoID'])

    @expose(template='kid:%s.templates.edit' % __name__)
    @identity.require(identity.in_any_group('admin','JTP','redactor'))
    def edit(self, id, **kw):
        """Edit record in model"""
        r = validate_get(id)
        curso = Curso.get(r.cursoID)
        options = { fkname+'ID': [(e.id, e) for e in
            Enunciado.selectBy(anio=curso.anio,
                cuatrimestre=curso.cuatrimestre)] }
        return dict(name=name, namepl=namepl, record=r, form=form, options=options)

    @validate(form=form)
    @error_handler(edit)
    @expose()
    @identity.require(identity.in_any_group('admin','JTP','redactor'))
    def update(self, id, **kw):
        """Save or create record to model"""
        r = validate_set(id, kw)
        flash(_(u'El %s fue actualizado.') % name)
        raise redirect('../list/%s' % r.cursoID)

    @expose(template='kid:%s.templates.show' % __name__)
    def show(self,id, **kw):
        """Show record in model"""
        r = validate_get(id)
        return dict(name=name, namepl=namepl, record=r)

    @expose()
    @identity.require(identity.in_any_group('admin','JTP','redactor'))
    def delete(self, id):
        """Destroy record in model"""
        validate_del(id)
        flash(_(u'El %s fue eliminado permanentemente.') % name)
        raise redirect('../list')
#}}}

