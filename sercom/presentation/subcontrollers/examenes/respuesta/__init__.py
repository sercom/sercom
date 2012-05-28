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
from sercom.widgets import SeparatorField, LiteralField
from sercom.model import PreguntaExamen, TemaPregunta, TipoPregunta, Respuesta
from sercom.model import Permiso
from sercom.presentation.subcontrollers.examenes import custom_selects as CS
from sqlobject import *
import kid
#}}}

#{{{ Configuración
cls = Respuesta
name = 'Respuesta'
namepl = name + 's'

cls_pregunta = PreguntaExamen
name_pregunta = 'Pregunta Examen'
#}}}

#{{{ Validación
def validate_get_pregunta(id):
    return val.validate_get(cls_pregunta, name_pregunta, id)

def validate_get(id):
    return val.validate_get(cls, name, id)

def validate_get_for_edit(id):
    respuesta = val.validate_get(cls, name, id)
    respuesta.validar_acceso(identity.current.user)
    return respuesta

def validate_set(id, data):
    return val.validate_set(cls, name, id, data)

def validate_new(data):
    return val.validate_new(cls, name, data)
#}}}


#{{{ Formulario
class RespuestaForm(W.TableForm):
    class Fields(W.WidgetsList):
        examen_texto = W.Label(label=_(u'Examen'))
        pregunta_texto = LiteralField(label=_(u'Pregunta'), convert=True)
        texto = W.TextArea(label=_(u'Texto'),
            validator=V.UnicodeString( max=5000, strip=True))
        revisada = W.CheckBox(label=_(u'Revisada')) 
    fields = Fields()

form = RespuestaForm()

#}}}

#{{{ Controlador
class RespuestaController(BaseController):

    @expose()
    def default(self, tg_errors=None):
        """handle non exist urls"""
        raise redirect('/')

    @identity.require(identity.has_permission(Permiso.examen.respuesta.proponer))
    @expose(template='kid:%s.templates.new' % __name__)
    def new(self,pregunta_id, **kw):
        """Create new records in model"""
        return dict(name=name, namepl=namepl, form=form, pregunta_id = pregunta_id, values=kw)

    @identity.require(identity.has_permission(Permiso.examen.respuesta.proponer))
    @validate(form=form)
    @error_handler(new)
    @expose()
    def create(self,pregunta_id, **kw):
        """Save or create record to model"""
        pregunta = validate_get_pregunta(pregunta_id)
        texto = kw['texto']
        pregunta.add_respuesta(texto, identity.current.user)
        flash(_(u'La nueva respuesta fue agregada y se encuentra pendiente de revisión.'))
        raise redirect('/examenes/pregunta/show/%s' % pregunta_id)

    @identity.require(identity.has_any_permission(str(Permiso.examen.respuesta.proponer), str(Permiso.examen.respuesta.revisar)))
    @expose(template='kid:%s.templates.edit' % __name__)
    def edit(self, id):
        """Edit record in model"""
        respuesta = validate_get_for_edit(id)
        respuesta.examen_texto = str(respuesta.pregunta.examen)
        respuesta.pregunta_texto = '%d)<br/>%s' % (respuesta.pregunta.numero, respuesta.pregunta.texto)
        attrs = dict()
        if not identity.current.user.has_any_permiso(Permiso.examen.respuesta.revisar):
            attrs = dict(revisada={'disabled':'disabled'})
	return dict(name=name, namepl=namepl, record=respuesta, form=form, attrs = attrs)

    @expose(template='kid:%s.templates.show' % __name__)
    def show(self, id):
        """Show record in model"""
        r = validate_get(id)
        return dict(name=name, namepl=namepl, record=r)

    @identity.require(identity.has_any_permission(str(Permiso.examen.respuesta.proponer), str(Permiso.examen.respuesta.revisar)))
    @validate(form=form)
    @error_handler(edit)
    @expose()
    def update(self,  id, **kw):
        """Save or create record to model"""
        texto = kw['texto']
        r = validate_get_for_edit(id)
        r.change_texto(texto, identity.current.user)
        if identity.has_permission(Permiso.examen.respuesta.revisar):
            revisado = bool(kw['revisada'])
            r.revisar(revisado)
            flash(_(u'La %s actualizada.') % name)
        else:
            flash(_(u'La %s fue actualizada y se encuentra pendiente de revisión.') % name)
        raise redirect('/examenes/pregunta/show/%d' % r.preguntaID)

#}}}

