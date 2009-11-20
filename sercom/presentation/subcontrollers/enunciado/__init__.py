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
from sercom.model import Enunciado, Docente, Curso, Tarea, TareaFuente, TareaPrueba, Lenguaje
from cherrypy import request, response
from sercom.widgets import *
from caso_de_prueba import CasoDePruebaController
#}}}

#{{{ Configuración
cls = Enunciado
name = 'enunciado'
namepl = name + 's'

fkcls = Docente
fkname = 'autor'
fknamepl = fkname + 'es'

lgcls = Lenguaje
lgname = 'lenguaje'
lgnamepl = fkname + 's'
#}}}

ajax = u"""
    function doSubmit()
    {
        /* TODO : Validar datos y evitar el submit si no esta completo */

        /* Selecciono todos los miembros si no, no llegan al controllere*/
        l = MochiKit.DOM.getElement('form_tareas_fuente_to');
        for (i=0; i<l.options.length; i++) {
            l.options[i].selected = true;
        }
        l = MochiKit.DOM.getElement('form_tareas_prueba_to');
        for (i=0; i<l.options.length; i++) {
            l.options[i].selected = true;
        }
        return true; // Dejo hacer el submit
    }
"""

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
    return [(0, _(u'--'))] + [(fk.id, fk) for fk in fkcls.select()]

def get_lang_options():
    return [(fk.id, fk) for fk in lgcls.select()]

def get_tareas_fuente():
    return [(tf.id, tf) for tf in TareaFuente.select()]

def get_tareas_prueba():
    return [(tp.id, tp) for tp in TareaPrueba.select()]

class EnunciadoForm(W.TableForm):
    class Fields(W.WidgetsList):
        anio = W.TextField(label=_(u'Año'),
            help_text=_(u'Requerido.'),
            validator=V.Number(min=4, max=4, strip=True))
        cuatrimestre = W.TextField(label=_(u'Cuatrimestre'),
            help_text=_(u'Requerido.'),
            validator=V.Number(min=1, max=1, strip=True))
        nombre = W.TextField(label=_(u'Nombre'),
            help_text=_(u'Requerido y Único.'),
            validator=V.UnicodeString(min=5, max=60, strip=True))
        fk = W.SingleSelectField(name=fkname+'ID', label=_(fkname.capitalize()),
            options=get_options, validator=V.Int(not_empty=False))
        descripcion = W.TextField(label=_(u'Descripción'),
            validator=V.UnicodeString(not_empty=False, max=255, strip=True))
        el_archivo = W.FileField(label=_(u'Archivo'))
        lenguaje = W.SingleSelectField(name=lgname+'ID', label=_(lgname.capitalize()),
            options=get_lang_options, validator=V.Int(not_empty=False))
        tareas_fuente = AjaxDosListasSelect(label=_(u'Tareas Fuente'),
            title_from=u'Disponibles',
            title_to=u'Asignadas',
            options=get_tareas_fuente,
            validator=V.Int(not_empty=True))
        tareas_prueba = AjaxDosListasSelect(label=_(u'Tareas Prueba'),
            title_from=u'Disponibles',
            title_to=u'Asignadas',
            options=get_tareas_prueba,
            validator=V.Int(not_empty=True))
    fields = Fields()
    form_attrs = dict(onsubmit='return doSubmit();')
    javascript = [W.JSSource("MochiKit.DOM.focusOnLoad('form_nombre');"), W.JSSource(ajax)]

form = EnunciadoForm()
#}}}

#{{{ Controlador
class EnunciadoController(controllers.Controller, identity.SecureResource):
    """Basic model admin interface"""
    require = identity.in_any_group('JTP', 'admin','docente','alumno','redactor')

    caso_de_prueba = CasoDePruebaController()

    @expose()
    def default(self, tg_errors=None):
        """handle non exist urls"""
        raise redirect('list')

    @expose()
    def index(self):
        raise redirect('list')

    @expose(template='kid:%s.templates.list' % __name__)
    @validate(validators=dict(autor=V.Int))
    @paginate('records', limit=config.get('items_por_pagina'))
    def list(self, autor=None):
        """List records in model"""
        if autor is None:
            r = cls.select(orderBy='anio desc, cuatrimestre desc')
        else:
            r = cls.selectBy(autorID=autor, orderBy='anio desc, cuatrimestre desc')
        return dict(records=r, name=name, namepl=namepl, parcial=autor)

    @expose(template='kid:%s.templates.new' % __name__)
    @identity.require(identity.in_any_group('admin','jtp','redactor'))
    def new(self, **kw):
        """Create new records in model"""
        return dict(name=name, namepl=namepl, form=form, values=kw)

    @validate(form=form)
    @error_handler(new)
    @expose()
    @identity.require(identity.in_any_group('admin','jtp','redactor'))
    def create(self, el_archivo, **kw):
        """Save or create record to model"""
        if el_archivo.filename:
            kw['archivos'] = el_archivo.file.read() # TODO verificar que es ZIP
        if 'tareas_fuente_to' in kw.keys() and 'tareas_prueba_to' in kw.keys():
            kw['tareas'] = list(kw['tareas_fuente_to']) + list(kw['tareas_prueba_to'])
            del(kw['tareas_fuente_to'])
            del(kw['tareas_prueba_to'])
        elif 'tareas_fuente_to' in kw.keys():
            kw['tareas'] = list(kw['tareas_fuente_to'])
            del(kw['tareas_fuente_to'])
        elif 'tareas_prueba_to' in kw.keys():
            kw['tareas'] = list(kw['tareas_prueba_to'])
            del(kw['tareas_prueba_to'])
        else:
            kw['tareas'] = []
        del(kw['tareas_prueba'])
        del(kw['tareas_fuente'])
        validate_new(kw)
        flash(_(u'Se creó un nuevo %s.') % name)
        raise redirect('list')

    @expose(template='kid:%s.templates.edit' % __name__)
    @identity.require(identity.in_any_group('admin','jtp','redactor'))
    def edit(self, id, **kw):
        """Edit record in model"""
        r = validate_get(id)
        r.tareas_fuente = [{"id":t.id, "label":t} for t in r.tareas if isinstance(t, TareaFuente)]
        r.tareas_prueba = [{"id":t.id, "label":t} for t in r.tareas if isinstance(t, TareaPrueba)]
        return dict(name=name, namepl=namepl, record=r, form=form)

    @validate(form=form)
    @error_handler(edit)
    @expose()
    @identity.require(identity.in_any_group('admin','jtp','redactor'))
    def update(self, id, el_archivo, **kw):
        """Save or create record to model"""
        if el_archivo.filename:
            kw['archivos'] = el_archivo.file.read()
        if 'tareas_fuente_to' in kw.keys() and 'tareas_prueba_to' in kw.keys():
            kw['tareas'] = list(kw['tareas_fuente_to']) + list(kw['tareas_prueba_to'])
            del(kw['tareas_fuente_to'])
            del(kw['tareas_prueba_to'])
        elif 'tareas_fuente_to' in kw.keys():
            kw['tareas'] = list(kw['tareas_fuente_to'])
            del(kw['tareas_fuente_to'])
        elif 'tareas_prueba_to' in kw.keys():
            kw['tareas'] = list(kw['tareas_prueba_to'])
            del(kw['tareas_prueba_to'])
        else:
            kw['tareas'] = []
        del(kw['tareas_prueba'])
        del(kw['tareas_fuente'])
        r = validate_set(id, kw)
        flash(_(u'El %s fue actualizado.') % name)
        raise redirect('../list')

    @expose(template='kid:%s.templates.show' % __name__)
    def show(self,id, **kw):
        """Show record in model"""
        r = validate_get(id)
        if r.descripcion is None:
            r.desc = ''
        else:
            r.desc = publish_parts(r.descripcion, writer_name='html')['html_body']
        return dict(name=name, namepl=namepl, record=r)

    @expose()
    @identity.require(identity.in_any_group('admin','jtp','redactor'))
    def delete(self, id):
        """Destroy record in model"""
        r = validate_get(id)
        r.destroySelf()
        flash(_(u'El %s fue eliminado permanentemente.') % name)
        raise redirect('../list')

    @expose()
    def files(self, id):
        r = validate_get(id)
        if r.archivos is None:
            flash(_(u'El ejercicio %s no tiene archivos asociados' % r))
            raise redirect('../list')
        response.headers["Content-Type"] = 'application/zip'
        response.headers["Content-disposition"] = 'attachment;filename=enunciado.zip'
        return r.archivos

    @expose('json')
    @identity.require(identity.in_any_group('admin','jtp','redactor'))
    def de_curso(self, curso_id):
        c = Curso.get(curso_id)
        e = Enunciado.selectByCurso(c)
        return dict(enunciados=e)
#}}}

