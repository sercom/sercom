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
from sercom.model import Curso, Entregador, InstanciaDeEvaluacionAlumno
from cherrypy import request, response
#}}}

#{{{ Configuración
cls = InstanciaDeEvaluacionAlumno
name = u'instancia de evaluación alumno'
namepl = u'instancias de evaluación alumnos'
#}}}

#{{{ Validación
def check_curso(data):
    c = Curso.get(data['cursoID'])
    del data['cursoID']
    data['curso'] = c
    return c

def validate_get(id):
    return val.validate_get(cls, name, id)

def validate_set(id, data):
    c = check_curso(data)
    val.update_record(cls, name, id, data, '../list/%s' % c.id, '../edit/%s' % id)

def validate_new(data):
    c = check_curso(data)
    val.create_record(cls, name, data, '../list/%s' % c.id, '../edit/%s' % id)
#}}}

#{{{ Formulario
class InstanciaEvaluacionAlumnoForm(W.TableForm):
    class Fields(W.WidgetsList):
        cursoID = W.HiddenField()
        tipo = W.TextField(validator=V.UnicodeString(not_empty=True))
        inicio = W.CalendarDateTimePicker(label=_(u"Inicio"))
        fin = W.CalendarDateTimePicker(label=_(u"Fin"))
        activo = W.CheckBox(label=_(u"Activo?"), attrs=dict(checked='checked'))
        observaciones = W.TextArea(rows="5", cols="40", validator=V.UnicodeString(if_empty=u''))
    fields = Fields()
    javascript = [W.JSSource("MochiKit.DOM.focusOnLoad('form_numero');")]

form = InstanciaEvaluacionAlumnoForm()
#}}}

#{{{ Controlador
class InstanciaEvaluacionAlumnoController(controllers.Controller, identity.SecureResource):
    """Basic model admin interface"""
    require = identity.has_any_permission('entregar','enunciado_editar','enunciado_eliminar', 'corregir')

    @expose(template='kid:%s.templates.list' % __name__)
    @validate(validators=dict(cursoID=V.Int))
    @paginate('records', limit=config.get('items_por_pagina'))
    def list(self, cursoID):
        curso = Curso.get(cursoID)
        r = cls.selectBy(curso=curso)
        return dict(records=r, name=name, namepl=namepl, curso=curso)

    @expose(template='kid:%s.templates.new' % __name__)
    @validate(validators=dict(cursoID=V.Int))
    @identity.require(identity.in_any_group('admin','JTP','redactor'))
    def new(self, cursoID, **kw):
        """Create new records in model"""
        kw['cursoID'] = cursoID
        return dict(name=name, namepl=namepl, form=form, values=kw)

    @validate(form=form)
    @error_handler(new)
    @expose()
    @identity.require(identity.in_any_group('admin','JTP','redactor'))
    def create(self, **kw):
        """Save or create record to model"""
        validate_new(kw)

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
        validate_set(id, kw)

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
        curso_id = r.cursoID
        r.destroySelf()
        flash(_(u'El %s fue eliminado permanentemente.') % name)
        raise redirect('../list/%s' % curso_id)
#}}}

