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
from sercom.model import Correccion, Curso, Ejercicio
from sercom.model import InstanciaDeEntrega, DocenteInscripto
from sqlobject import *

#}}}

#{{{ Configuración
cls = Correccion
name = 'correccion'
namepl = name + 'es'
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
class CorreccionForm(W.TableForm):
    class Fields(W.WidgetsList):
        linstancia = W.Label(label=_(u'Instancia de Entrega'))
        lentregador = W.Label(label=_(u'Entregador'))
        lentrega = W.Label(label=_(u'Entrega'))
        lcorrector = W.Label(label=_(u'Corrector'))
        nota = W.TextField(label=_(u'Nota'), validator=V.Number(not_empty=True, strip=True))
        observaciones = W.TextArea(label=_(u'Observaciones'), validator=V.UnicodeString(not_empty=False, strip=True))
    fields = Fields()
    javascript = [W.JSSource("MochiKit.DOM.focusOnLoad('form_instancia');")]

class CorreccionFiltros(W.TableForm):
    class Fields(W.WidgetsList):
        cursoID = W.SingleSelectField(label=_(u'Curso'), validator=V.Int(not_empty=True))
    form_attrs={'class':"filter"}
    fields = Fields()

filtro = CorreccionFiltros()
form = CorreccionForm()
#}}}

#{{{ Controlador
class CorreccionController(controllers.Controller, identity.SecureResource):
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
    @validate(validators=dict(cursoID=V.Int))
    @paginate('records')
    def list(self, cursoID=None):
        """List records in model"""
        vfilter = dict(cursoID=cursoID)
        r = []
        if cursoID:
            r = cls.select(
                AND(
                    cls.q.correctorID == DocenteInscripto.pk.get(
                        cursoID=cursoID, docenteID=identity.current.user.id).id,
                    Ejercicio.q.id == InstanciaDeEntrega.q.ejercicioID,
                    InstanciaDeEntrega.q.id == Correccion.q.instanciaID,
                    Ejercicio.q.cursoID == cursoID
                )
            )
        cursos = [(i.curso.id, i.curso.shortrepr())
            for i in identity.current.user.inscripciones]
        return dict(records=r, name=name, namepl=namepl, form=filtro,
            vfilter=vfilter, options=dict(cursoID=cursos))

    @expose(template='kid:%s.templates.edit' % __name__)
    def edit(self, id, **kw):
        """Edit record in model"""
        r = validate_get(id)
        r.linstancia = r.instancia.shortrepr()
        r.lentregador = r.entregador.shortrepr()
        r.lentrega = r.entrega.shortrepr()
        r.lcorrector = r.corrector.shortrepr()
        return dict(name=name, namepl=namepl, record=r, form=form)

    @validate(form=form)
    @error_handler(edit)
    @expose()
    def update(self, id, **kw):
        """Save or create record to model"""
        from sqlobject import DateTimeCol
        r = Correccion.get(id)
        r.nota = kw['nota']
        r.observaciones = kw['observaciones']
        r.corregido = DateTimeCol.now()
        flash(_(u'El %s fue actualizado.') % name)
        raise redirect('../list')

    @expose(template='kid:%s.templates.show' % __name__)
    def show(self,id, **kw):
        """Show record in model"""
        r = validate_get(id)
        return dict(name=name, namepl=namepl, record=r)

    @expose(template='kid:%s.templates.entregas' % __name__)
    @paginate('records')
    def entregas(self, id):
        r = validate_get(id)
        return dict(records=r.entregas, correccion = r)
        
#}}}

