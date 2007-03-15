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
from sercom.model import Curso, AlumnoInscripto, Docente, DocenteInscripto, Grupo, Alumno, Miembro
from sqlobject import *

from sercom.widgets import *

#}}}

#{{{ Configuración
cls = Grupo
name = 'grupo'
namepl = 'grupos'
#}}}

#{{{ Validación
def validate_get(id):
    return val.validate_get(cls, name, id)

def validate_set(id, data):
    return val.validate_set(cls, name, id, data)

def validate_new(data):
    return val.validate_new(cls, name, data)

def validate_del(id):
    return val.validate_del(cls, name, id)
#}}}

#{{{ Formulario
def get_docentes():
    return [(fk1.id, fk1.shortrepr()) for fk1 in Docente.select()]

def get_docentes_inscriptos(id):
    return [(fk1.id, fk1.shortrepr()) for fk1 in DocenteInscripto.select(DocenteInscripto.q.cursoID==id)]

ajax = u"""
    function alumnos_agregar_a_la_lista(texto, lista)
    {
        t = MochiKit.DOM.getElement(texto);

        curso = MochiKit.DOM.getElement('form_cursoID');
        if (!curso) {
            alert("No deberias ver esto, y quiere decir que tu form esta roto.\\nTe falta un combo de curso");
            return;
        }
        if (curso.value <= 0) {
            alert('Debes seleccionar un curso primero');
            return;
        }
        url = "/curso/grupo/get_inscripto?cursoid="+curso.value+"&padron="+t.value;
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
        /* Obtengo el padron ingresado */
        p = MochiKit.DOM.getElement('form_responsable');
        padron = p.value;
        if (padron == '') {
            return;
        }
        /* Obtengo el curso */
        l = MochiKit.DOM.getElement('form_cursoID');
        cursoid = l.value;
        if (cursoid <= 0) {
            alert('Debe seleccionar un curso');
            return;
        }
        url = "/curso/grupo/get_inscripto?cursoid="+cursoid+'&padron='+padron;
        var d = loadJSONDoc(url);
        d.addCallbacks(procesar, err);
    }

    function prepare()
    {
        connect('form_responsable', 'onblur', buscar_alumno);
    }

    function doSubmit()
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

class GrupoForm(W.TableForm):
    class Fields(W.WidgetsList):
        cursoID = W.HiddenField()
        nombre = W.TextField(label=_(u'Nombre'), validator=V.UnicodeString(not_empty=True,strip=True))
        responsable = CustomTextField(label=_(u'Responsable'), validator=V.UnicodeString(), attrs=dict(size='8'))
        miembros = AjaxMultiSelect(label=_(u'Miembros'), validator=V.Int(), on_add="alumnos_agregar_a_la_lista")
        tutores = W.MultipleSelectField(label=_(u'Tutores'), validator=V.Int())

    fields = Fields()
    javascript = [W.JSSource("MochiKit.DOM.focusOnLoad('form_nombre');"), W.JSSource(ajax)]
    form_attrs = dict(onsubmit='return doSubmit()')

form = GrupoForm()

def get_gruposA(cursoID):
    return [(0, u'---')] + [(g.id, g.shortrepr()) for g in Grupo.select(Grupo.q.cursoID==cursoID)]

def get_gruposB(cursoID):
    return [(0, u'Nuevo Grupo')] + [(g.id, g.shortrepr()) for g in Grupo.select(Grupo.q.cursoID==cursoID)]

ajaxadmin = u"""
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

    function doSubmit()
    {
        /* TODO : Validar datos y evitar el submit si no esta completo */

        /* Selecciono todos los miembros si no, no llegan al controllere*/
        l = MochiKit.DOM.getElement('form_grupos_to');
        for (i=0; i<l.options.length; i++) {
            l.options[i].selected = true;
        }
        /* Selecciono todos los miembros si no, no llegan al controllere*/
        l = MochiKit.DOM.getElement('form_grupos_from');
        for (i=0; i<l.options.length; i++) {
            l.options[i].selected = true;
        }

        return true; // Dejo hacer el submit
    }

    function initWidgets(disabled) {
        if ( disabled ) {
            MochiKit.DOM.getElement('form_listaGrupoA').selectedIndex = 0;
        }
        MochiKit.DOM.getElement('form_listaGrupoB').selectedIndex = 0;
        MochiKit.DOM.getElement('form_grupos_to').options.length = 0;
        MochiKit.DOM.getElement('form_grupos_from').options.length = 0;
        MochiKit.DOM.getElement('form_listaGrupoB').disabled = disabled;
        MochiKit.DOM.getElement('form_grupos_to').disabled = disabled;
        MochiKit.DOM.getElement('form_grupos_from').disabled = disabled;
    }

    function onListaAChange() {
        lista = MochiKit.DOM.getElement('form_listaGrupoA');
        if ( lista.selectedIndex != '0' ) {
            initWidgets(false);
        } else {
            initWidgets(true);
            return;
        }
        // carga el grupo en el multiple select
        grupoA = MochiKit.DOM.getElement('form_grupos_from');
        id = lista.options[lista.selectedIndex].value
        cargarGrupo(id, grupoA);
        //carga la lista para seleccionar un responsable
        responsableA = MochiKit.DOM.getElement('form_responsableA');
        responsableA.options.length = 0;
        MochiKit.DOM.appendChildNodes(responsableA, OPTION({"value":0}, "---"));
        cargarGrupo(id, responsableA);
    }

    function onListaBChange() {
        lista = MochiKit.DOM.getElement('form_listaGrupoB');
        listaA =  MochiKit.DOM.getElement('form_listaGrupoA');
        MochiKit.DOM.getElement('form_grupos_to').options.length = 0;
        if ( lista.selectedIndex == 0 ) {
            return;
        }
        if ( lista.selectedIndex != '0' ) {
            if ( lista.selectedIndex == listaA.selectedIndex ) {
                window.alert('Debe seleccionar 2 grupos distintos');
                MochiKit.DOM.getElement('form_grupos_to').options.length = 0;
                return;
            }
            grupoB = MochiKit.DOM.getElement('form_grupos_to');
            id = lista.options[lista.selectedIndex].value
            cargarGrupo(id, grupoB);

            //carga la lista para seleccionar un responsable
            responsableB = MochiKit.DOM.getElement('form_responsableB');
            responsableB.options.length = 0;
            MochiKit.DOM.appendChildNodes(responsableB, OPTION({"value":0}, "---"));
            cargarGrupo(id, responsableB);
        }
    }

    function cargarGrupo(grupoid, lista) {
        //url = "/grupo/get_inscripto?cursoid="+cursoid+'&padron='+padron
        var result = loadJSONDoc('/curso/grupo/get_alumnos?grupoid='+id);
        result.addCallbacks(partial(cargarLista, lista), err)
    }

    function err (err)
    {
        alert("The metadata for MochiKit.Async could not be fetched :(");
    }

    function cargarLista(lista, result) {
        var alumnos = result.msg;
        if (result.error) {
            window.alert(result.msg);
            return;
        }
        for (i in alumnos) {
            id = alumnos[i].id;
            label = alumnos[i].label;
            MochiKit.DOM.appendChildNodes(lista, OPTION({"value":id}, label))
        }
    }

"""

class GrupoAdminForm(W.TableForm):
    class Fields(W.WidgetsList):
        cursoID = W.HiddenField()
        listaGrupoA = W.SingleSelectField(label=_(u'Grupo A'), attrs = dict(onChange='onListaAChange()'), validator = V.Int(not_empty=True))
        listaGrupoB = W.SingleSelectField(label=_(u'Grupo B'), attrs = dict(onChange='onListaBChange()'), validator = V.Int(not_empty=True))
        grupos = AjaxDosListasSelect(label=_(u'Grupos'),title_from=u"Grupo A", size=8, title_to=u"Grupo B", validator=V.Int(not_empty=True))
        responsableA = W.SingleSelectField(label=_(u'Responsable A'), validator = V.Int())
        responsableB = W.SingleSelectField(label=_(u'Responsable B'), validator = V.Int())
        tutoresA = W.MultipleSelectField(label=_(u'Tutores A'), validator = V.Int(not_empty=True))
        tutoresB = W.MultipleSelectField(label=_(u'Tutores B'), validator = V.Int(not_empty=True))

    fields = Fields()
    javascript = [W.JSSource("MochiKit.DOM.focusOnLoad('listaGrupoA');"), W.JSSource(ajaxadmin)]
    form_attrs = dict(onsubmit='return doSubmit();')

formadmin = GrupoAdminForm()

#}}}

#{{{ Controlador
class GrupoController(controllers.Controller, identity.SecureResource):
    """Basic model admin interface"""
    require = identity.has_permission('admin')

    @expose()
    def default(self, tg_errors=None):
        """handle non exist urls"""
        raise redirect(tg.url('/curso/list'))

    @expose()
    def index(self):
        raise redirect(tg.url('/curso/list'))

    @expose(template='kid:%s.templates.list' % __name__)
    @paginate('records')
    def list(self, cursoID):
        """List records in model"""
        r = cls.select(cls.q.cursoID == cursoID)
        return dict(records=r, name=name, namepl=namepl, cursoID=int(cursoID))

    @expose(template='kid:%s.templates.new' % __name__)
    def new(self, cursoID, **kw):
        """Create new records in model"""
        form.fields[0].attrs['value'] = cursoID
        options = dict(tutores=get_docentes_inscriptos(cursoID))
        return dict(name=name, namepl=namepl, cursoID=int(cursoID), form=form, options=options, values=kw)

    @validate(form=form)
    @error_handler(new)
    @expose()
    def create(self, **kw):
        """Save or create record to model"""
        resp = kw['responsable']
        try:
            # Busco el alumno inscripto
            resp = AlumnoInscripto.selectBy(cursoID=kw['cursoID'],
                alumno=Alumno.byPadron(kw['responsable'])).getOne()
        except SQLObjectNotFound:
            resp = None
        kw['responsable'] = resp

        r = validate_new(kw)
        flash(_(u'Se creó un nuevo %s.') % name)
        raise redirect('list/%d' % int(kw['cursoID']))

    @expose(template='kid:%s.templates.edit' % __name__)
    def edit(self, id, **kw):
        """Edit record in model"""
        r = validate_get(id)
        # TODO : No encontre mejor forma de pasar cosas al form
        # de manera comoda y facil de formatear segun lo que espera la UI (que
        # en este caso es super particular). Ese EmptyClass no se si hay algo estandar
        # en python que usar, puse {} y [] pero cuando quiero hacer values.id = XX explota.
        options = dict(tutores=get_docentes_inscriptos(r.curso.id))
        class EmptyClass:
            pass
        values = EmptyClass()
        values.id = r.id
        values.cursoID = r.cursoID
        values.nombre = r.nombre
        # TODO : Ver como llenar la lista primero :S
        if r.responsable:
            values.responsable = r.responsable.alumno.padron
        values.miembros = [{"id":i.alumno.id, "label":i.alumno.alumno.nombre} for i in filter(lambda x: x.baja is None, r.miembros)]
        values.tutores = [a.docenteID for a in r.tutores]
        return dict(name=name, namepl=namepl, record=values, options=options, form=form)

    @validate(form=form)
    @error_handler(edit)
    @expose()
    def update(self, id, **kw):
        """Save or create record to model"""
        responsable = kw['responsable']
        curso = kw['cursoID']
        resp = kw['responsable']
        try:
            # Busco el alumno inscripto
            resp = AlumnoInscripto.selectBy(cursoID=kw['cursoID'],
                alumno=Alumno.byPadron(kw['responsable'])).getOne()
        except SQLObjectNotFound:
            resp = None
        kw['responsable'] = resp
        r = validate_set(id, kw)
        flash(_(u'El %s fue actualizado.') % name)
        raise redirect('../list/%d' % r.curso.id)

    @expose(template='kid:%s.templates.show' % __name__)
    def show(self,id, **kw):
        """Show record in model"""
        r = validate_get(id)
        return dict(name=name, namepl=namepl, record=r)

    @expose()
    def delete(self, cursoID, id):
        """Destroy record in model"""
        validate_del(id)
        flash(_(u'El %s fue eliminado permanentemente.') % name)
        raise redirect('../../list/%d' % int(cursoID))

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

    @expose('json')
    def get_alumnos(self, grupoid):
        msg = u''
        error=False
        try:
            # Busco los alumnos del grupo
            grupo = Grupo.get(int(grupoid))
            miembros = Miembro.selectBy(baja=None, grupo=grupo)
            print miembros
            integrantes = []
            for m in miembros:
                msg = {}
                alumnoInscripto = AlumnoInscripto.get(m.alumno.id)
                msg['id'] = alumnoInscripto.id
                msg['label'] = alumnoInscripto.shortrepr()
                integrantes.append(msg)
        except Exception, (inst):
            msg = u"""Se ha producido un error inesperado al buscar el registro:\n      %s""" % str(inst)
            error = True
            integrantes = []
            integrantes.append(msg)
        return dict(msg=integrantes, error=error)

    @expose(template='kid:%s.templates.admin' % __name__)
    def admin(self, cursoID, **kw):
        """Create new records in model"""
        options = dict(
            listaGrupoA=get_gruposA(cursoID),
            listaGrupoB=get_gruposB(cursoID),
            tutoresA=get_docentes_inscriptos(cursoID),
            tutoresB=get_docentes_inscriptos(cursoID),
        )
        return dict(name=name, namepl=namepl, options=options, form=formadmin, values=kw, cursoID=int(cursoID))
#}}}

