# vim: set et sw=4 sts=4 encoding=utf-8 foldmethod=marker :

#{{{ Imports
import cherrypy
from turbogears import controllers, expose, redirect
from turbogears import validate, flash, error_handler
from turbogears import validators as V
from turbogears import widgets as W
from turbogears import identity
from turbogears import paginate
from docutils.core import publish_parts
from sercom.subcontrollers import validate as val
from sercom.model import PreguntaExamen, TemaPregunta, TipoPregunta
from sercom.subcontrollers.examenes import custom_selects as CS
from sqlobject import *
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
            validator=V.UnicodeString( max=500, not_empty=True, strip=True))
    fields = Fields()

class PreguntaExamenFiltros(W.TableForm):
    class Fields(W.WidgetsList):
        tipoID = CS.TipoSelectField()
        temaID = CS.TemaSelectField()
    form_attrs={'class':"filter"}
    fields = Fields()

filtro = PreguntaExamenFiltros()
form = PreguntaExamenForm()

#}}}

#{{{ Controlador
class PreguntaExamenController(controllers.Controller):

    @expose()
    def default(self, tg_errors=None):
        """handle non exist urls"""
        raise redirect('find')

    @expose(template='kid:%s.templates.new' % __name__)
    def new(self, **kw):
        """Create new records in model"""
        return dict(name=name, namepl=namepl, form=form, values=kw)

    @validate(form=form)
    @error_handler(new)
    @expose()
    def create(self, **kw):
        """Save or create record to model"""
        validate_new(kw)
        flash(_(u'Se creó un nuevo %s.') % name)
        raise redirect('list')

    @expose(template='kid:%s.templates.edit' % __name__)
    def edit(self, id, **kw):
        """Edit record in model"""
        class POD(dict):
            def __getattr__(self, attrname):
                return self[attrname]
        record_object = validate_get(id)
	r = POD(record_object.sqlmeta.asDict())
	r['fecha_examen'] = record_object.examen.fecha
	return dict(name=name, namepl=namepl, record=r, form=form)

    @expose(template='kid:%s.templates.show' % __name__)
    def show(self,id, **kw):
        """Show record in model"""
        r = validate_get(id)
        return dict(name=name, namepl=namepl, record=r)

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
    @paginate('records')
    def find(self, tipoID=None, temaID=None):
        """Find records in model"""
        vfilter = dict(tipoID=tipoID, temaID=temaID)

        r = PreguntaExamen.selectBy(tipoID=tipoID,temaID=temaID)
        
        return dict(records=r, name=name, namepl=namepl, form=filtro,
            vfilter=vfilter)


#}}}

