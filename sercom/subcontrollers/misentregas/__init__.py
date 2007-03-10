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
from sercom.model import Entrega, Correccion, Curso, Ejercicio, InstanciaDeEntrega
from sqlobject import *

#}}}

#{{{ Configuración
cls = Entrega
name = 'entrega'
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

def get_ejercicios_activos():
    # TODO : Mostrar solo los ejercicios con instancias de entrega activos
    return [(0, _(u'--'))] + [(fk.id, fk.shortrepr()) for fk in Ejercicio.select()]

ajax = """
    function clearInstancias ()
    {
        l = MochiKit.DOM.getElement('form_instancia');
        l.options.length = 0;
        l.disabled = true;
    }

    function mostrarInstancias(res)
    {
        clearInstancias();
        for(i=0; i < res.instancias.length; i++) {
            id = res.instancias[i].id;
            label = res.instancias[i].numero;
            MochiKit.DOM.appendChildNodes("form_instancia", OPTION({"value":id}, label))
        }
        if (l.options.length > 0)
            l.disabled = false;
    }

    function err (err)
    {
        alert("The metadata for MochiKit.Async could not be fetched :(");
    }

    function actualizar_instancias ()
    {
        l = MochiKit.DOM.getElement('form_ejercicio');
        id = l.options[l.selectedIndex].value;
        if (id == 0) {
            clearInstancias();
            return;
        }

        url = "/mis_entregas/instancias?ejercicio_id="+id;
        var d = loadJSONDoc(url);
        d.addCallbacks(mostrarInstancias, err);
    }

    function prepare()
    {
        connect('form_ejercicio', 'onchange', actualizar_instancias);
        clearInstancias();
    }

    MochiKit.DOM.addLoadEvent(prepare)
"""
#{{{ Formulario
class EntregaForm(W.TableForm):
    class Fields(W.WidgetsList):
        ejercicio = W.SingleSelectField(label=_(u'Ejercicio'),
            options=get_ejercicios_activos, validator=V.Int(not_empty=True))
        instancia = W.SingleSelectField(label=_(u'Instancia de Entrega'), validator=V.Int(not_empty=True))
        archivo = W.FileField(label=_(u'Archivo'), help_text=_(u'Archivo en formaro ZIP con tu entrega'))
    fields = Fields()
    javascript = [W.JSSource("MochiKit.DOM.focusOnLoad('form_ejercicio');"), W.JSSource(ajax)]

form = EntregaForm()
#}}}

#{{{ Controlador
class MisEntregasController(controllers.Controller, identity.SecureResource):
    """Basic model admin interface"""
    require = identity.has_permission('entregar')

    @expose()
    def default(self, tg_errors=None):
        """handle non exist urls"""
        raise redirect('list')

    @expose()
    def index(self):
        raise redirect('list')

    @expose(template='kid:%s.templates.new' % __name__)
    def new(self, **kw):
        """Create new records in model"""
        return dict(name=name, namepl=namepl, form=form, values=kw)

    @expose(template='kid:%s.templates.list' % __name__)
    @paginate('records')
    def list(self):
        """List records in model"""
        r = cls.select(cls.q.entregadorID == identity.current.user.id)
        return dict(records=r, name=name, namepl=namepl)

    @expose(template='kid:%s.templates.show' % __name__)
    def show(self,id, **kw):
        """Show record in model"""
        r = validate_get(id)
        if r.observaciones is None:
            r.obs = ''
        else:
            r.obs = publish_parts(r.observaciones, writer_name='html')['html_body']
        return dict(name=name, namepl=namepl, record=r)

    @validate(form=form)
    @error_handler(new)
    @expose()
    def create(self, archivo, ejercicio, **kw):
        """Save or create record to model"""
        kw['archivos'] = archivo.file.read()
        kw['entregador'] = identity.current.user
        validate_new(kw)
        flash(_(u'Se creó una nueva %s.') % name)
        raise redirect('list')

    @expose("json")
    def instancias(self, ejercicio_id):
        c = Ejercicio.get(ejercicio_id)
        return dict(instancias=c.instancias)
#}}}

