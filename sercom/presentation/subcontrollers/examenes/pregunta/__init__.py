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
from sercom.presentation.controllers import BaseController
from sercom.presentation.subcontrollers import validate as val
from sercom.widgets import SeparatorField
from sercom.model import PreguntaExamen, TemaPregunta, TipoPregunta, Respuesta
from sercom.model import Permiso
from sercom.presentation.subcontrollers.examenes import custom_selects as CS
from sqlobject import *
from imagen import ImagenController
#}}}

#{{{ Configuración
cls = PreguntaExamen
name = 'Pregunta'
namepl = name + 's'
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
class PreguntaExamenForm(W.TableForm):
    class Fields(W.WidgetsList):
	fecha_examen = W.Label(label=_(u'Examen'))
	numero = W.Label()
	tipoID = CS.TipoSelectField()
	temaID = CS.TemaSelectField() 
        texto = W.TextArea(label=_(u'Texto'),
            help_text=_(u'Requerido.'),
            validator=V.UnicodeString( max=5000, not_empty=True, strip=True))
         
    fields = Fields()

class PreguntaExamenFiltros(W.TableForm):
    class Fields(W.WidgetsList):
        tipoID = CS.TipoSelectField()
        temaID = CS.TemaSelectField()
        tipoID.add_default(u'Todos')
        temaID.add_default(u'Todos')
    form_attrs={'class':"filter"}
    fields = Fields()

filtro = PreguntaExamenFiltros()
form = PreguntaExamenForm()

#}}}

#{{{ Controlador
class PreguntaExamenController(BaseController):

    @expose()
    def default(self, tg_errors=None):
        """handle non exist urls"""
        raise redirect('find')

    @identity.require(identity.has_permission(Permiso.examen.editar))
    @expose(template='kid:%s.templates.new' % __name__)
    def new(self, **kw):
        """Create new records in model"""
        return dict(name=name, namepl=namepl, form=form, values=kw)

    @identity.require(identity.has_permission(Permiso.examen.editar))
    @validate(form=form)
    @error_handler(new)
    @expose()
    def create(self, **kw):
        """Save or create record to model"""
        r = validate_new(kw)
        flash(_(u'Se creó un nuevo %s.') % name)
        raise redirect('list')

    @identity.require(identity.has_permission(Permiso.examen.editar))
    @expose(template='kid:%s.templates.edit' % __name__)
    def edit(self, id):
        """Edit record in model"""
        pregunta = validate_get(id)
	pregunta.fecha_examen = pregunta.examen.fecha
	return dict(name=name, namepl=namepl, record=pregunta, form=form)

    @expose(template='kid:%s.templates.show' % __name__)
    def show(self,id):
        """Show record in model"""
        r = validate_get(id)
        return dict(name=name, namepl=namepl, record=r)

    @identity.require(identity.has_permission(Permiso.examen.editar))
    @validate(form=form)
    @error_handler(edit)
    @expose()
    def update(self, id, **kw):
        """Save or create record to model"""
 	del kw['numero']
	del kw['fecha_examen']
	r = validate_set(id, kw)
        flash(_(u'El %s fue actualizado.') % name)
        raise redirect('../show/%d' % r.id)

    @expose(template='kid:%s.templates.find' % __name__)
    @paginate('records', dynamic_limit='limit_to')
    def find(self, tipoID=None, temaID=None):
        """Find records in model"""
        vfilter = dict(tipoID=tipoID, temaID=temaID)

	expression = '1=1'
	#flash(str(tipoID))
	if tipoID and tipoID != '':
		expression = AND(expression,PreguntaExamen.q.tipoID == tipoID)
	if temaID and temaID != '':
		expression = AND(expression,PreguntaExamen.q.temaID == temaID)
	r = PreguntaExamen.select(expression).orderBy([PreguntaExamen.q.examen,PreguntaExamen.q.numero])
	        
        return dict(records=r, name=name, namepl=namepl, form=filtro,
            vfilter=vfilter, limit_to=self.get_limite_paginado())

    imagen = ImagenController()
#}}}

