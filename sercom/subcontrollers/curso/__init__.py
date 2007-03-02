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
from sercom.model import Curso, Ejercicio, Alumno, Docente, Grupo, DocenteInscripto
from curso_alumno import *
from sqlobject import *
from sercom.widgets import *
#}}}

#{{{ Configuración
cls = Curso
name = 'curso'
namepl = name + 's'
#}}}

ajax = u""" 
    function makeOption(option) {
        return OPTION({"value": option.value}, option.text);
    }
                   
    function moveOption( fromSelect, toSelect) {
        // add 'selected' nodes toSelect
        appendChildNodes(toSelect,
        map( makeOption,ifilter(itemgetter('selected'), $(fromSelect).options)));
        // remove the 'selected' fromSelect
        replaceChildNodes(fromSelect,
            list(ifilterfalse(itemgetter('selected'), $(fromSelect).options))
        );
    }

    function alumnos_agregar_a_la_lista(texto, lista)
    {
        t = MochiKit.DOM.getElement(texto);

        url = "/alumno/get_alumno?padron="+t.value;
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

    function onsubmit()
    {
        /* TODO : Validar datos y evitar el submit si no esta completo */

        /* Selecciono todos los miembros si no, no llegan al controllere*/
        l = MochiKit.DOM.getElement('form_miembros');
        for (i=0; i<l.options.length; i++) { 
            l.options[i].selected = true; 
        }
        return true; // Dejo hacer el submit
    }

    MochiKit.DOM.addLoadEvent(prepare)

"""



#{{{ Validación
def validate_get(id):
    return val.validate_get(cls, name, id)

def validate_set(id, data):
    return val.validate_set(cls, name, id, data)

def validate_new(data):
    return val.validate_new(cls, name, data)
#}}}

def get_ejercicios():
    return [(fk1.id, fk1.shortrepr()) for fk1 in Ejercicio.select()]

def get_docentes():
    return [(fk1.id, fk1.shortrepr()) for fk1 in Docente.select()]

def get_alumnos():
    return [(fk1.id, fk1.shortrepr()) for fk1 in Alumno.select()]

def get_grupos():
    return [(fk1.id, fk1.shortrepr()) for fk1 in Grupo.select()]

#{{{ Formulario
class CursoForm(W.TableForm):
    class Fields(W.WidgetsList):
        anio = W.TextField(label=_(u'Anio'),
            help_text=_(u'Requerido y único.'),
            validator=V.Number(min=4, max=4, strip=True))
        cuatrimestre = W.TextField(label=_(u'Cuatrimestre'),
            help_text=_(u'Requerido.'),
            validator=V.Number(min=1, max=1, strip=True))
        numero = W.TextField(label=_(u'Numero'),
            help_text=_(u'Requerido'),
            validator=V.Number(min=1, max=2, strip=True))
        descripcion = W.TextArea(name='descripcion', label=_(u'Descripcion'),
            help_text=_(u'Descripcion.'),
            validator=V.UnicodeString(not_empty=False, strip=True))
        
        docentes = W.MultipleSelectField(name="docentes",
            label=_(u'Docentes'),
            attrs=dict(style='width:300px'),
            options=get_docentes,
            validator=V.Int(not_empty=True))
        addDocente = W.Button(default='Asignar', label='',
            attrs=dict( onclick='moveOption("form_docentes","form_docentes_curso")'))
        remDocente = W.Button(default='Remover', label='',
            attrs=dict( onclick='moveOption("form_docentes_curso","form_docentes")'))
        docentes_curso = W.MultipleSelectField(name="docentes_curso",
            label=_(u'Docentes del curso'),
            attrs=dict(style='width:300px'),
#            options=get_docentes_curso,
            validator=V.Int(not_empty=True))

        alumnos = AjaxMultiSelect(label=_(u'Alumnos'),
                validator=V.Int(),
                on_add="alumnos_agregar_a_la_lista")

    fields = Fields()
    javascript = [W.JSSource("MochiKit.DOM.focusOnLoad('anio');"),
                  W.JSSource(ajax)]
    form_attrs = dict(onsubmit='return onsubmit()')
form = CursoForm()
#}}}

#{{{ Controlador
class CursoController(controllers.Controller, identity.SecureResource):
    """Basic model admin interface"""
    require = identity.has_permission('admin')
    curso_alumno = CursoAlumnoController()

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
        params = dict([(k,v) for (k,v) in kw.iteritems() if k in Curso.sqlmeta.columns.keys()])
        return dict(name=name, namepl=namepl, form=form, values=params)

    @validate(form=form)
    @error_handler(new)
    @expose()
    def create(self, **kw):
        """Save or create record to model"""
        docentes = kw.get('docentes_curso', [])
        alumnos = kw.get('alumnos', [])
        del(kw['remDocente'])
        del(kw['addDocente'])
        del(kw['docentes_curso'])
        del(kw['alumnos'])
        r = validate_new(kw)
        """ Elimino todos los docentes asignados al curso y los agrego nuevamente""" 
        for d in DocenteInscripto.selectBy(curso=r):
            d.destroySelf()
        """ Agrego la nueva seleccion """ 
        for d in docentes:
            r.add_docente(Docente(d))
        """ El curso es nuevo, por ende no hay alumnos inscriptos """
        for a in alumnos:
            r.add_alumno(Alumno(a))
        flash(_(u'Se creó un nuevo %s.') % name)
        raise redirect('list')
    
    @expose(template='kid:%s.templates.edit' % __name__)
    def edit(self, id, **kw):
        """Edit record in model"""
        r = validate_get(id)
        docentes = kw.get('docentes_curso', [])
        alumnos = kw.get('alumnos', [])
        """ Elimino todos los docentes asignados al curso y los agrego nuevamente""" 
        for d in DocenteInscripto.selectBy(curso=r):
            d.destroySelf()
        """ Agrego la nueva seleccion """ 
        for d in docentes:
            r.add_docente(Docente(d))
        """ Verifico que los alumnos no esten ya inscriptos  """
       
        try:
            for a in alumnos:
                r.add_alumno(Alumno(a))
        except DuplicateEntryError:
            flash(_(u'El alumno con padron %s ya esta inscripto.') % Alumno(a).padron)
            raise redirect('create')
        flash(_(u'Se creó un nuevo %s.') % name)
        
        return dict(name=name, namepl=namepl, record=r, form=form)

    @validate(form=form)
    @error_handler(edit)
    @expose()
    def update(self, id, **kw):
        """Save or create record to model"""
        params = dict([(k,v) for (k,v) in kw.iteritems() if k in Curso.sqlmeta.columns.keys()])
        r = validate_set(id, params)
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
#}}}

