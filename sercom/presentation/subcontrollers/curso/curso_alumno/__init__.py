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
from sercom.model import Curso, Ejercicio, Alumno, Docente, Grupo, DocenteInscripto, AlumnoInscripto
from sercom.widgets import FocusJSSource
#}}}

#{{{ Configuración
cls = Curso
name = 'Alumno del curso'
namepl = 'Alumnos del curso'
#}}}

#{{{ Validación
def validate_get(id):
    return val.validate_get(cls, name, id)

def validate_set(id, data):
    return val.validate_set(cls, name, id, data)

def validate_new(data):
    return val.validate_new(cls, name, data)
#}}}

def get_ejercicios():
    return [(e.id, e) for e in Ejercicio.select()]

def get_docentes():
    return [(d.id, d) for d in Docente.select()]

def get_alumnos_inscriptos(curso):
    return [(ai.id, ai) for ai in AlumnoInscripto.selectBy(curso)]

def get_alumnos():
    return [(a.id, a) for a in Alumno.select()]

def get_grupos():
    return [(g.id, g) for g in Grupo.select()]

ajax = u""" 
function makeOption(option) {
    return OPTION({"value": option.value}, option.text);
}
                   
function moveOption( fromSelect, toSelect) {
    // add 'selected' nodes toSelect
    appendChildNodes(toSelect,
    map( makeOption,ifilter(itemgetter('selected'), $(fromSelect).options)));
    // remove the 'selected' fromSelect
    replaceChildNodes(fromSelect,
        list(ifilterfalse(itemgetter('selected'), $(fromSelect).options))
    );
}
"""

#{{{ Formulario
class CursoAlumnoForm(W.TableForm):
    class Fields(W.WidgetsList):
        alumnos = W.MultipleSelectField(label=_(u'Alumnos'),
            attrs=dict( style='width:250px'),
            options=get_alumnos,
            validator = V.Int(not_empty=False))
        inscribir = W.Button(default='Inscribir', label='',
            attrs=dict( onclick='moveOption("form_alumnos","form_inscriptos")'))
        desinscribir = W.Button(default='Desinscribir', label='',
            attrs=dict( onclick='moveOption("form_inscriptos","form_alumnos")'))
        inscriptos = W.MultipleSelectField(label=_(u'Alumnos Inscriptos'),
            attrs=dict( style='width:250px'),
            options=get_alumnos,
            validator = V.Int(not_empty=False))
    fields = Fields()
    javascript = [FocusJSSource('form_alumnos'),
                  W.JSSource(ajax)]
form = CursoAlumnoForm()
#}}}

#{{{ Controlador
class CursoAlumnoController(controllers.Controller, identity.SecureResource):
    """Basic model admin interface"""
    require = identity.has_permission('admin')

    @expose()
    def default(self, curso_id):
        """handle non exist urls"""
        return dict(records=r, name=name, namepl=namepl, alumnos=alumnos)
    
    @expose()
    def index(self):
        raise redirect('/curso/list')

    @expose(template='kid:%s.templates.list' % __name__)
    @paginate('records', limit=config.get('items_por_pagina'))
    def list(self):
        """List records in model"""
        r = cls.select()
        return dict(records=r, name=name, namepl=namepl)

    @expose()
    def activate(self, id, activo):
        """Save or create record to model"""
        r = validate_get(id)
        try:
            r.activo = bool(int(activo))
        except ValueError:
            raise cherrypy.NotFound
        raise redirect('../../list')

    @expose(template='kid:%s.templates.new' % __name__)
    def new(self,curso_id, **kw):
        """Create new records in model"""
        return dict(name=name, namepl=namepl, form=form, values=kw)

    @validate(form=form)
    @error_handler(new)
    @expose()
    def create(self, **kw):
        """Save or create record to model"""
        r = validate_new(kw)
        docentes = kw.get('docentes', [])
        alumnos = kw.get('alumnos', [])
        """ Elimino todos los docentes asignados al curso y los agrego nuevamente""" 
        for d in DocenteInscripto.selectBy(curso=r):
            d.destroySelf()
        """ Agrego la nueva seleccion """ 
        for d in docentes:
            r.add_docente(Docente(d))
        """ Elimino a los alumnos y los vuelvo a agregar """
        for a in AlumnoInscripto.selectBy(curso=r):
            d.destroySelf()
        for a in alumnos:
            r.add_alumno(Alumno(a))
        flash(_(u'Se creó un nuevo %s.') % name)
        raise redirect('list')
    
    @expose(template='kid:%s.templates.edit' % __name__)
    def edit(self, id, **kw):
        """Edit record in model"""
        r = validate_get(id)
        return dict(name=name, namepl=namepl, record=r, form=form)

    @validate(form=form)
    @error_handler(edit)
    @expose()
    def update(self, id, **kw):
        """Save or create record to model"""
        r = validate_set(id, kw)
        flash(_(u'El %s fue actualizado.') % name)
        raise redirect('../list')

    @expose(template='kid:%s.templates.show' % __name__)
    def show(self,id, **kw):
        """Show record in model"""
        r = validate_get(id)
        return dict(name=name, namepl=namepl, record=r)

    @expose()
    def delete(self, id):
        """Destroy record in model"""
        r = validate_get(id)
        r.destroySelf()
        flash(_(u'El %s fue eliminado permanentemente.') % name)
        raise redirect('../list')
#}}}
