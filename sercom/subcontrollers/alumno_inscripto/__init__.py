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

def validate_new(data):
    return val.validate_new(cls, name, data)
#}}}

#{{{ Formulario
class AlumnoInscriptoForm(W.TableForm):
    class Fields(W.WidgetsList):
        linstancia = W.Label(label=_(u'Instancia de Entrega'))
        lentregador = W.Label(label=_(u'Entregador'))
        lentrega = W.Label(label=_(u'Entrega'))
        lcorrector = W.Label(label=_(u'Corrector'))
        nota = W.TextField(label=_(u'Nota'), validator=V.Number(not_empty=True, strip=True))
        observaciones = W.TextArea(label=_(u'Observaciones'), validator=V.UnicodeString(not_empty=False, strip=True))
    fields = Fields()
    javascript = [W.JSSource("MochiKit.DOM.focusOnLoad('form_instancia');")]

def get_cursos():
    return [(0, u'---')] + [(fk1.id, fk1.shortrepr()) for fk1 in Curso.select()]

class AlumnoInscriptoFiltros(W.TableForm):
    class Fields(W.WidgetsList):
        cursoID = W.SingleSelectField(label=_(u'Curso'), options = get_cursos, validator = V.Int(not_empty=True))
    fields = Fields()

filtro = AlumnoInscriptoFiltros()
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
    @paginate('records')
    def list(self, cursoID = 0):
        """List records in model"""
        vfilter = dict(cursoID = cursoID)
        if int(cursoID) == 0:
            r = cls.select()
        else:
            r = cls.select(cls.q.cursoID == cursoID)
        return dict(records=r, name=name, namepl=namepl, form=filtro, vfilter=vfilter)

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
        if r.observaciones is None:
            r.obs = ''
        else:
            r.obs = publish_parts(r.observaciones, writer_name='html')['html_body']
        return dict(name=name, namepl=namepl, record=r)

    @expose(template='kid:%s.templates.entregas' % __name__)
    @paginate('records')
    def entregas(self, id):
        r = validate_get(id)
        return dict(records=r.entregas, correccion = id)
        
#}}}

