# vim: set et sw=4 sts=4 encoding=utf-8 foldmethod=marker :

#{{{ Imports
from turbogears import controllers, expose, redirect
from turbogears import validate, flash, error_handler
from turbogears import validators as V
from turbogears import widgets as W
from turbogears import identity
from turbogears import paginate
from docutils.core import publish_parts
from sercom.subcontrollers import validate as val
from sercom.model import Ejercicio, Curso, Enunciado
from cherrypy import request, response

from entrega import  *

#}}}

#{{{ Configuración
cls = Ejercicio
name = 'ejercicio'
namepl = name + 's'

fkcls = Curso
fkname = 'curso'
fknamepl = fkname + 's'

fk1cls = Enunciado
fk1name = 'enunciado'
fk1namepl = fk1name + 's'
#}}}

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

def validate_fk1(data):
    fk = data.get(fk1name + 'ID', None)
    if fk == 0: fk = None
    if fk is not None:
        try:
            fk = fk1cls.get(fk)
        except LookupError:
            flash(_(u'No se pudo crear el nuevo %s porque el %s con '
                'identificador %d no existe.' % (name, fk1name, fk)))
            raise redirect('new', **data)
    data.pop(fk1name + 'ID', None)
    data[fk1name] = fk
    return fk

def validate_get(id):
    return val.validate_get(cls, name, id)

def validate_set(id, data):
    validate_fk(data)
    validate_fk1(data)
    return val.validate_set(cls, name, id, data)

def validate_new(data):
    validate_fk(data)
    validate_fk1(data)
    return val.validate_new(cls, name, data)
#}}}

#{{{ Formulario
def get_options():
    return [(0, _(u'--'))] + [(fk.id, fk.shortrepr()) for fk in fkcls.select()]

# Un poco de ajax para llenar los cursos
ajax = """
    function clearEnunciados ()
    {
        l = MochiKit.DOM.getElement('form_enunciadoID');
        l.options.length = 0;
    }

    function mostrarEnunciados (res)
    {
        clearEnunciados();
        for(i in res.enunciados) {
            id = res.enunciados[i].id;
            label = res.enunciados[i].nombre;
            MochiKit.DOM.appendChildNodes("form_enunciadoID", OPTION({"value":id}, label))
        }
    }

    function err (err)
    {
        alert("The metadata for MochiKit.Async could not be fetched :(");
    }

    function actualizar_enunciados ()
    {
        l = MochiKit.DOM.getElement('form_cursoID');
        id = l.options[l.selectedIndex].value;
        if (id == 0) {
            clearEnunciados();
            return;
        }

        url = "/enunciado/de_curso?curso_id="+id;
        var d = loadJSONDoc(url);
        d.addCallbacks(mostrarEnunciados, err);
    }

    function prepare()
    {
        connect('form_cursoID', 'onchange', actualizar_enunciados);
    }

    MochiKit.DOM.addLoadEvent(prepare)
"""

class EjercicioForm(W.TableForm):
    class Fields(W.WidgetsList):
        fk = W.SingleSelectField(name=fkname+'ID', label=_(fkname.capitalize()),
            options=get_options, validator=V.Int(not_empty=True))
        numero = W.TextField(name="numero",label=_(u'Nro'),
            help_text=_(u'Requerido.'),
            validator=V.Int(not_empty=True))
        fk1 = W.SingleSelectField(name=fk1name+'ID', label=_(fk1name.capitalize()),
            validator=V.Int(not_empty=True))
        grupal = W.CheckBox(name='grupal', label=_(u"Grupal?"))
    fields = Fields()
    javascript = [W.JSSource("MochiKit.DOM.focusOnLoad('form_nombre');"), W.JSSource(ajax)]

form = EjercicioForm()
#}}}

#{{{ Controlador
class EjercicioController(controllers.Controller, identity.SecureResource):
    """Basic model admin interface"""
    require = identity.has_permission('admin')

    entrega = EntregaController()

    @expose()
    def default(self, tg_errors=None):
        """handle non exist urls"""
        raise redirect('list')

    @expose()
    def index(self):
        raise redirect('list')

    @expose(template='kid:%s.templates.list' % __name__)
    @validate(validators=dict(autor=V.Int))
    @paginate('records')
    def list(self, autor=None):
        """List records in model"""
        r = cls.select()
        return dict(records=r, name=name, namepl=namepl, parcial=autor)

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

    @expose()
    def files(self, id):
        r = validate_get(id)
        response.headers["Content-Type"] = r.archivo_type
        response.headers["Content-disposition"] = "attachment;filename=%s" % (r.archivo_name)
        flash(_(u'El %s fue eliminado permanentemente.') % name)
        return r.archivo
#}}}

