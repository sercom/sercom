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
from sercom.model import Docente, Rol
#}}}

#{{{ Configuración
cls = Docente
name = 'docente'
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
class DocenteForm(W.TableForm):
    class Fields(W.WidgetsList):
        usuario = W.TextField(label=_(u'Usuario'),
            help_text=_(u'Requerido y único.'),
            validator=V.UnicodeString(min=3, max=10, strip=True))
        pwd_new = W.PasswordField(label=_(u'Contraseña'),
            help_text=_(u'Mínimo 5 caracteres).'),
            attrs=dict(maxlength=255),
            validator=V.UnicodeString(min=5, max=255, not_empty=False))
        pwd_confirm = W.PasswordField(label=_(u'Confirmar'),
            attrs=dict(maxlength=255),
            validator=V.UnicodeString(min=5, max=255, not_empty=False))
        nombre = W.TextField(label=_(u'Nombre'),
            help_text=_(u'Requerido.'),
            validator=V.UnicodeString(min=10, max=255, strip=True))
        email = W.TextField(label=_(u'E-Mail'),
            #help_text=_(u'Dirección de e-mail.'),
            validator=V.All(
                V.Email(not_empty=False, resolve_domain=True),
                V.String(not_empty=False, max=255, strip=True,
                        encoding='ascii')))
        telefono = W.TextField(label=_(u'Teléfono'),
            #help_text=_(u'Texto libre para teléfono, se puede incluir '
            #    'horarios o varias entradas.'),
            validator=V.UnicodeString(not_empty=False, min=7, max=255,
                strip=True))
        observaciones = W.TextArea(label=_(u'Observaciones'),
            #help_text=_(u'Observaciones.'),
            validator=V.UnicodeString(not_empty=False, strip=True))
        nombrado = W.CheckBox(label=_(u'Nombrado'), default=1,
            #help_text=_(u'Indica si tiene cargo.'),
            validator=V.Bool(if_empty=1))
        activo = W.CheckBox(label=_(u'Activo'), default=1,
            #help_text=_(u'Si no está activo no puede ingresar al sistema.'),
            validator=V.Bool(if_empty=1))
    fields = Fields()
    javascript = [W.JSSource("MochiKit.DOM.focusOnLoad('form_usuario');")]
    validator = V.Schema(chained_validators=[
                         V.FieldsMatch('pwd_new', 'pwd_confirm') ])

form = DocenteForm()
#}}}

#{{{ Controlador
class DocenteController(controllers.Controller, identity.SecureResource):
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
    def new(self, **kw):
        """Create new records in model"""
        return dict(name=name, namepl=namepl, form=form, values=kw)

    @validate(form=form)
    @error_handler(new)
    @expose()
    def create(self, **kw):
        """Save or create record to model"""
        if not 'pwd_new' in kw and not kw['pwd_new']:
            flash(_(u'Debe especificar un password.'))
            raise redirect('new', **kw)
        kw['password'] = kw['pwd_new']
        del kw['pwd_new']
        del kw['pwd_confirm']
        kw['roles'] = [Rol.by_nombre('admin')]
        validate_new(kw)
        flash(_(u'Se creó un nuevo %s.') % name)
        raise redirect('list')

    @expose(template='kid:%s.templates.edit' % __name__)
    def edit(self, id, **kw):
        """Edit record in model"""
        class POD(dict):
            def __getattr__(self, attrname):
                return self[attrname]
        r = POD(validate_get(id).sqlmeta.asDict())
        return dict(name=name, namepl=namepl, record=r, form=form)

    @validate(form=form)
    @error_handler(edit)
    @expose()
    def update(self, id, **kw):
        """Save or create record to model"""
        if 'pwd_new' in kw:
            if kw['pwd_new']:
                kw['password'] = kw['pwd_new']
            del kw['pwd_new']
        if 'pwd_confirm' in kw:
            del kw['pwd_confirm']
        r = validate_set(id, kw)
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

    @expose()
    def delete(self, id):
        """Destroy record in model"""
        r = validate_get(id)
        r.destroySelf()
        flash(_(u'El %s fue eliminado permanentemente.') % name)
        raise redirect('../list')
#}}}

