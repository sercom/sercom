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
from sercom.model import Curso, AlumnoInscripto, Docente, Grupo, Alumno
from sqlobject import *

from sercom.widgets import *

#}}}

#{{{ Configuración
cls = Grupo
name = 'grupo'
namepl = 'grupos'

fkcls = Curso
fkname = 'curso'
fknamepl = fkname + 's'
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
def get_docentes():
    return [(fk1.id, fk1.shortrepr()) for fk1 in Docente.select()]

def get_cursos():
    return [(0, u'---')] + [(fk1.id, fk1.shortrepr()) for fk1 in Curso.select()]

ajax = u"""
    function alumnos_agregar_a_la_lista(texto, lista)
    {
        t = MochiKit.DOM.getElement(texto);

        curso = MochiKit.DOM.getElement('form_cursoID');
        if (!curso) {
            alert("No deberias ver esto, y quiere decir que tu form esta roto.\\nTe falta un combo de curso");
            return;
        }
        if (curso.options[curso.selectedIndex].value <= 0) {
            alert('Debes seleccionar un curso primero');
            return;
        }
        url = "/grupo/get_inscripto?cursoid="+curso.options[curso.selectedIndex].value+"&padron="+t.value;
        t.value = "";
        return url;
    }

    function err (err)
    {
        alert("The metadata for MochiKit.Async could not be fetched :(");
    }

    function procesar(result)
    {
        l = MochiKit.DOM.getElement('form_responsable_info');
        if (result.error)
            l.innerHTML = result.msg;
        else
            l.innerHTML = result.msg.value;
    }

    function buscar_alumno()
    {
        /* Obtengo el curso */
        l = MochiKit.DOM.getElement('form_cursoID');
        cursoid = l.options[l.selectedIndex].value;
        if (cursoid <= 0) {
            alert('Debe seleccionar un curso');
            return;
        }
        /* Obtengo el padron ingresado */
        p = MochiKit.DOM.getElement('form_responsable');
        padron = p.value;
        if (padron == '') {
            alert('Debe ingresar el padrón del alumno responsable');
            return;
        }
        url = "/grupo/get_inscripto?cursoid="+cursoid+'&padron='+padron;
        var d = loadJSONDoc(url);
        d.addCallbacks(procesar, err);
    }

    function prepare()
    {
        connect('form_responsable', 'onblur', buscar_alumno);
    }

    MochiKit.DOM.addLoadEvent(prepare)

"""

class GrupoForm(W.TableForm):
    class Fields(W.WidgetsList):
        curso = W.SingleSelectField(name='cursoID', label=_(u'Curso'), options = get_cursos,
        validator = V.Int(not_empty=True))
        nombre = W.TextField(label=_(u'Nombre'), validator=V.UnicodeString(not_empty=True,strip=True))
        responsable = CustomTextField(label=_(u'Responsable'), validator=V.UnicodeString(not_empty=True), attrs=dict(size='8'))
        alumnos = AjaxMultiSelect(name='alumnos', label=_(u'Integrantes'), validator=V.Int(), on_add="alumnos_agregar_a_la_lista")

    fields = Fields()
    javascript = [W.JSSource("MochiKit.DOM.focusOnLoad('curso');"), W.JSSource(ajax)]

form = GrupoForm()

#}}}

#{{{ Controlador
class GrupoController(controllers.Controller, identity.SecureResource):
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
        responsable = kw['responsable']
        curso = kw['cursoID']
        resp = None
        try:
            # Busco el alumno inscripto
            resp = AlumnoInscripto.select(AND(Curso.q.id==curso, Alumno.q.usuario==responsable))
            if resp.count() > 0:
                resp = resp[0]
            else:
                raise Exception
        except Exception, (inst):
            flash(_(u'El responsable %s no existe') % responsable)
            raise redirect('list')

        kw['responsable'] = resp

        # Busco los alumnos
        alumnos = []
        for alumnoid in kw['alumnos']:
            alumnos.append(Alumno.get(alumnoid))
        if alumnos == []:
            flash(_(u'No se pudo crear el grupo. No se han agregado integrantes.'))
            raise redirect('list')

        del(kw['alumnos'])

        r = validate_new(kw)
        for a in alumnos:
            r.add_miembro(a)
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
        responsable = kw['responsable']
        curso = kw['cursoID']
        alumno = None
        try:
            # Busco el alumno inscripto
            alumno = AlumnoInscripto.select(AND(Curso.q.id==curso, Alumno.q.usuario==responsable))
            if alumno.count() > 0:
                alumno = alumno[0]
            else:
                raise Exception
        except Exception, (inst):
            flash(_(u'El responsable %s no existe') % responsable)
            raise redirect('../list')

        r = validate_set(id, kw)
        r.responsable = alumno
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

    @expose('json')
    def get_inscripto(self, cursoid, padron):
        msg = u''
        error=False
        try:
            # Busco el alumno inscripto
            alumno = AlumnoInscripto.selectBy(curso=cursoid, alumno=Alumno.byUsuario(padron)).getOne()
            msg = {}
            msg['id'] = alumno.id
            msg['value'] = alumno.alumno.nombre
        except SQLObjectNotFound:
            msg = 'No existe el alumno %s en el curso seleccionado.' % padron
            error=True
        except Exception, (inst):
            msg = u"""Se ha producido un error inesperado al buscar el registro:\n      %s""" % str(inst)
            error = True
        return dict(msg=msg, error=error)
#}}}

