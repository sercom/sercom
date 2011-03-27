# vim: set et sw=4 sts=4 encoding=utf-8 foldmethod=marker :

#{{{ Imports
import cherrypy
from turbogears import controllers, expose, redirect
from turbogears import validate, flash, error_handler
from turbogears import validators as V
from turbogears import widgets as W
from turbogears import identity
from turbogears import paginate
from turbogears import config
from docutils.core import publish_parts
from sercom.presentation.subcontrollers import validate as val
from sercom.model import TareaPrueba, ComandoPrueba, Comando
from sqlobject import *
from sercom.widgets import FocusJSSource
#}}}

#{{{ Configuración
cls = ComandoPrueba
name = 'comando prueba'
namepl = 'comandos prueba'
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
class ComandoPruebaForm(W.TableForm):
    class Fields(W.WidgetsList):
        tareaID = W.HiddenField()
        orden = W.TextField(label=_(u'Orden'), validator=V.Int(not_empty=True))
        comando = W.TextField(label=_(u'Comando'), validator=V.UnicodeString(max=255, strip=True))
        descripcion = W.TextField(label=_(u'Descripcion'), validator=V.UnicodeString(min=5, max=255, strip=True))
        retorno = W.TextField(label=_(u'Retorno'), help_text=u"Codigo de retorno esperado",validator=V.Int(if_empty=ComandoPrueba.RET_PRUEBA))
        max_tiempo_cpu = W.TextField(label=_(u'CPU'), help_text=u"Maximo tiempo de CPU que puede utilizar [seg]",validator=V.Int())
        max_memoria = W.TextField(label=_(u'Memoria'), help_text=u"Maximo cantidad de memoria que puede utilizar [MB]",validator=V.Int())
        max_tam_archivo = W.TextField(label=_(u'Tam. Archivo'), help_text=u"Maximo tamanio de archivo a crear [MB]",validator=V.Int())
        max_cant_archivos = W.TextField(label=_(u'Archivos'),validator=V.Int())
        max_cant_procesos = W.TextField(label=_(u'Procesos'),validator=V.Int())
        max_locks_memoria = W.TextField(label=_(u'Mem. Locks'),validator=V.Int())
        terminar_si_falla = W.CheckBox(label=_(u'Terminar si falla?'), default=1, validator=V.Bool(if_empty=1))
        rechazar_si_falla = W.CheckBox(label=_(u'Rechazar si falla?'), default=1, validator=V.Bool(if_empty=1))
        publico = W.CheckBox(label=_(u'Es público?'), default=1, validator=V.Bool(if_empty=1))
        los_archivos_entrada = W.FileField(label=_(u'Archivos Entrada'))
        los_archivos_a_comparar = W.FileField(label=_(u'Archivos a Comparar'))
        archivos_guardar = W.TextField(label=_(u'Archivos a Guardar'))
        activo = W.CheckBox(label=_(u'Activo'), default=1, validator=V.Bool(if_empty=1))
    fields = Fields()
    javascript = [FocusJSSource('form_orden')]

form = ComandoPruebaForm()
#}}}

#{{{ Controlador
class ComandoPruebaController(controllers.Controller, identity.SecureResource):
    """Basic model admin interface"""
    require = identity.in_any_group('admin','JTP','redactor','alumno')

    @expose(template='kid:%s.templates.list' % __name__)
    @paginate('records', limit=config.get('items_por_pagina'))
    @identity.require(identity.has_permission('admin'))
    def list(self, tareaID):
        """List records in model"""
        r = cls.select(cls.q.tareaID == tareaID)
        return dict(records=r, name=name, tareaID=int(tareaID),namepl=namepl)

    @expose(template='kid:%s.templates.new' % __name__)
    @identity.require(identity.has_permission('admin'))
    def new(self, tareaID,**kw):
        """Create new records in model"""
        form.fields[0].attrs['value'] = tareaID
        return dict(name=name, namepl=namepl, form=form, values=kw)

    @validate(form=form)
    @error_handler(new)
    @expose()
    @identity.require(identity.has_permission('admin'))
    def create(self, **kw):
        """Save or create record to model"""
        t = TareaPrueba.get(kw['tareaID'])
        orden = kw['orden']
        del kw['orden']
        del kw['tareaID']
        if kw['los_archivos_entrada'].filename:
            kw['archivos_entrada'] = kw['los_archivos_entrada'].file.read()
        del kw['los_archivos_entrada']
        if kw['los_archivos_a_comparar'].filename:
            kw['archivos_a_comparar'] = kw['los_archivos_a_comparar'].file.read()
        del kw['los_archivos_a_comparar']
        # TODO : Hacer ventanita mas amigable para cargar esto.
        try:
            kw['archivos_a_guardar'] = tuple(kw['archivos_guardar'].split(','))
        except AttributeError:
            pass
        del kw['archivos_guardar']
        t.add_comando(orden, **kw)
        flash(_(u'Se creó un nuevo %s.') % name)
        raise redirect('list/%d' % t.id)

    @expose(template='kid:%s.templates.edit' % __name__)
    @identity.require(identity.has_permission('admin'))
    def edit(self, id, **kw):
        """Edit record in model"""
        r = validate_get(id)
        r.archivos_guardar = ",".join(r.archivos_a_guardar)
        return dict(name=name, namepl=namepl, record=r, form=form)

    @validate(form=form)
    @error_handler(edit)
    @expose()
    @identity.require(identity.has_permission('admin'))
    def update(self, id, **kw):
        """Save or create record to model"""
        orden = kw['orden']
        del kw['orden']
        del kw['tareaID']
        if kw['los_archivos_entrada'].filename:
            kw['archivos_entrada'] = kw['los_archivos_entrada'].file.read()
        del kw['los_archivos_entrada']
        if kw['los_archivos_a_comparar'].filename:
            kw['archivos_a_comparar'] = kw['los_archivos_a_comparar'].file.read()
        del kw['los_archivos_a_comparar']
        # TODO : Hacer ventanita mas amigable para cargar esto.
        try:
            kw['archivos_a_guardar'] = tuple(kw['archivos_guardar'].split(','))
        except AttributeError:
            pass
        del kw['archivos_guardar']
        r = validate_set(id, kw)
        flash(_(u'El %s fue actualizado.') % name)
        raise redirect('../list/%d' % r.tarea.id)

    @expose(template='kid:%s.templates.show' % __name__)
    def show(self,id, **kw):
        """Show record in model"""
        r = validate_get(id)
        return dict(name=name, namepl=namepl, record=r)

    @expose()
    @identity.require(identity.has_permission('admin'))
    def delete(self, id):
        """Destroy record in model"""
        r = validate_get(id)
        tareaID = r.tarea.id
        r.destroySelf()
        flash(_(u'El %s fue eliminado permanentemente.') % name)
        raise redirect('../list/%d' % tareaID)

    @expose()
    def file(self, name, id):
        from cherrypy import request, response
        r = validate_get(id)
        response.headers["Content-Type"] = "application/zip"
        response.headers["Content-disposition"] = "attachment;filename=%s_%d.zip" % (name, r.id)
        if name == "archivos_entrada":
            ret = r.archivos_entrada
        elif name == "archivos_a_comparar":
            ret = r.archivos_a_comparar
        else:
            raise NotFound
        return ret
#}}}

