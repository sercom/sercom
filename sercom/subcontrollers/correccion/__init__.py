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
from sercom.model import Correccion
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
        nota = W.TextField(label=_(u'Nota'), validator=V.Number(not_empty=False, strip=True))
        observaciones = W.TextArea(label=_(u'Observaciones'), validator=V.UnicodeString(not_empty=False, strip=True))
    fields = Fields()
    javascript = [W.JSSource("MochiKit.DOM.focusOnLoad('form_instancia');")]

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
    @paginate('records')
    def list(self):
        """List records in model"""
        r = cls.select()
        return dict(records=r, name=name, namepl=namepl)

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
        r = Correccion.get(id)
        r.nota = kw['nota']
        r.observaciones = kw['observaciones']
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

#}}}

