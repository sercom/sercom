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
from sercom.model import Enunciado, Docente, Curso
from cherrypy import request, response
#}}}

#{{{ Configuración
cls = Enunciado
name = 'enunciado'
namepl = name + 's'

fkcls = Docente
fkname = 'autor'
fknamepl = fkname + 'es'
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

def validate_get(id):
    return val.validate_get(cls, name, id)

def validate_set(id, data):
    validate_fk(data)
    return val.validate_set(cls, name, id, data)

def validate_new(data):
    validate_fk(data)
    return val.validate_new(cls, name, data)
#}}}

#{{{ Formulario
def get_options():
    return [(0, _(u'--'))] + [(fk.id, fk.shortrepr()) for fk in fkcls.select()]

class EnunciadoForm(W.TableForm):
    class Fields(W.WidgetsList):
        anio = W.TextField(label=_(u'Año'),
            help_text=_(u'Requerido.'),
            validator=V.Number(min=4, max=4, strip=True))
        cuatrimestre = W.TextField(label=_(u'Cuatrimestre'),
            help_text=_(u'Requerido.'),
            validator=V.Number(min=1, max=1, strip=True))
        nombre = W.TextField(label=_(u'Nombre'),
            help_text=_(u'Requerido y único.'),
            validator=V.UnicodeString(min=5, max=60, strip=True))
        fk = W.SingleSelectField(name=fkname+'ID', label=_(fkname.capitalize()),
            options=get_options, validator=V.Int(not_empty=False))
        descripcion = W.TextField(label=_(u'Descripción'),
            validator=V.UnicodeString(not_empty=False, max=255, strip=True))
        archivo = W.FileField(label=_(u'Archivo'))
    fields = Fields()
    javascript = [W.JSSource("MochiKit.DOM.focusOnLoad('form_nombre');")]

form = EnunciadoForm()
#}}}

#{{{ Controlador
class EnunciadoController(controllers.Controller, identity.SecureResource):
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
    @validate(validators=dict(autor=V.Int))
    @paginate('records')
    def list(self, autor=None):
        """List records in model"""
        if autor is None:
            r = cls.select()
        else:
            r = cls.selectBy(autorID=autor)
        return dict(records=r, name=name, namepl=namepl, parcial=autor)

    @expose(template='kid:%s.templates.new' % __name__)
    def new(self, **kw):
        """Create new records in model"""
        return dict(name=name, namepl=namepl, form=form, values=kw)

    @validate(form=form)
    @error_handler(new)
    @expose()
    def create(self, archivo, **kw):
        """Save or create record to model"""
        kw['archivo'] = archivo.file.read()
        kw['archivo_name'] = archivo.filename
        kw['archivo_type'] = archivo.type
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
        if r.descripcion is None:
            r.desc = ''
        else:
            r.desc = publish_parts(r.descripcion, writer_name='html')['html_body']
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

    @expose("json")
    def de_curso(self, curso_id):
        c = Curso.get(curso_id)
        e = Enunciado.selectByCurso(c)
        return dict(enunciados=e)
#}}}

