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
from sercom.subcontrollers import validate as val
from sercom.model import AlumnoInscripto, Correccion, Curso, Ejercicio, InstanciaDeEntrega
from sqlobject import *

#}}}

#{{{ Configuración
cls = AlumnoInscripto
name = 'alumno inscripto'
namepl = 'alumnos inscriptos'
#}}}

#{{{ Validación
def validate_get(id):
    return val.validate_get(cls, name, id)

def validate_set(id, data):
    return val.validate_set(cls, name, id, data)

#}}}

#{{{ Formulario
class AlumnoInscriptoForm(W.TableForm):
    class Fields(W.WidgetsList):
        nota_practica = W.TextField(label=_(u'Nota Práctica'), validator=V.Number(not_empty=True, strip=True))
        nota_final = W.TextField(label=_(u'Nota Final'), validator=V.Number(not_empty=True, strip=True))
        nota_libreta = W.TextField(label=_(u'Nota Libreta'), validator=V.Number(not_empty=True, strip=True))
    fields = Fields()
    javascript = [W.JSSource("MochiKit.DOM.focusOnLoad('form_nota_practica');")]

def get_cursos():
    return [(0, u'---')] + [(c.id, c) for c in Curso.select()]

form = AlumnoInscriptoForm()
#}}}

#{{{ Controlador
class AlumnoInscriptoController(controllers.Controller, identity.SecureResource):
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
    @paginate('records', limit=config.get('items_por_pagina'))
    def list(self, cursoID = 0):
        """List records in model"""
        cursoID = int(cursoID)
        if cursoID == 0:
            raise redirect('..')
        else:
            r = cls.select(cls.q.cursoID == cursoID)
        curso = Curso.get(cursoID)
        return dict(records=r, name=name, namepl=namepl, curso=curso)

    @expose(template='kid:%s.templates.notas' % __name__)
    def notas(self, id, cursoID, **kw):
        """Edit record in model"""
        cursoID = int(cursoID)
        r = validate_get(id)
        return dict(name=name, namepl=namepl, record=r, form=form, cursoid=cursoID)

    @validate(form=form)
    @error_handler(notas)
    @expose()
    def update(self, id, cursoID, **kw):
        """Save or create record to model"""
        cursoID = int(cursoID)
        r = validate_set(id, kw)
        flash(_(u'El %s fue actualizado.') % name)
        raise redirect('../../list/%d' % cursoID)

    @expose(template='kid:%s.templates.show' % __name__)
    def show(self,id, **kw):
        """Show record in model"""
        r = validate_get(id)
        return dict(name=name, namepl=namepl, record=r)

#}}}

