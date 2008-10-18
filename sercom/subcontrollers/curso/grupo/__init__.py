# vim: set et sw=4 sts=4 encoding=utf-8 foldmethod=marker :

#{{{ Imports
import cherrypy
from turbogears import controllers, expose, redirect
from turbogears import validate, flash, error_handler
from turbogears import validators as V
from turbogears import widgets as W
from turbogears import identity
from turbogears import paginate, url
from docutils.core import publish_parts
from sercom.subcontrollers import validate as val
from sercom.model import Curso, AlumnoInscripto, Docente, DocenteInscripto, Grupo, Alumno, Miembro
from sqlobject import *
from sqlobject.dberrors import *

from sercom.widgets import *

import logging

log = logging.getLogger('sercom.curso.grupo.admin')

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
    return [(d.id, d) for d in Docente.select()]

def get_docentes_inscriptos(id):
    return [(di.id, di) for di in DocenteInscripto.select(DocenteInscripto.q.cursoID==id)]

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
        cursoID = W.HiddenField(validator=V.Int)
        nombre = W.TextField(label=_(u'Nombre'), validator=V.UnicodeString(not_empty=True,strip=True))
        responsable = CustomTextField(label=_(u'Responsable'), validator=V.UnicodeString(), attrs=dict(size='8'))
        miembros = AjaxMultiSelect(label=_(u'Miembros'), validator=V.Int(), on_add="alumnos_agregar_a_la_lista")
        tutores = W.MultipleSelectField(label=_(u'Tutores'), validator=V.Int)

    fields = Fields()
    javascript = [W.JSSource("MochiKit.DOM.focusOnLoad('form_nombre');"), W.JSSource(ajax)]
    form_attrs = dict(onsubmit='return doSubmit()')

form = GrupoForm()

def get_gruposA(cursoID):
    return [(0, u'---')] + [(g.id, g) for g in Grupo.select(Grupo.q.cursoID==cursoID)]

def get_gruposB(cursoID):
    return [(0, u'Nuevo Grupo')] + [(g.id, g) for g in Grupo.select(Grupo.q.cursoID==cursoID)]

ajaxadmin = u"""
    function err (err)
    {
        alert("The metadata for MochiKit.Async could not be fetched :(");
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
        MochiKit.DOM.getElement('form_tutoresA').disabled = true;
        MochiKit.DOM.getElement('form_tutoresB').disabled = true;
        MochiKit.DOM.getElement('form_responsableA').disabled = true;
        MochiKit.DOM.getElement('form_responsableB').disabled = true;
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
        }
    }
    
    function makeOption(option) {
        return OPTION({"value": option.value}, option.text);
    }

    function cargarGrupo(grupoid, lista) {
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
        ActualizarResponsables();
    }

    function ActualizarResponsables()
    {
        replaceChildNodes('form_responsableA', '');
        replaceChildNodes('form_responsableB', '');
        appendChildNodes('form_responsableA', map(makeOption, $('form_grupos_from').options));
        appendChildNodes('form_responsableB', map(makeOption, $('form_grupos_to').options));

        if (getElement('form_grupos_from').options.length == 0) {
            getElement('form_tutoresA').disabled = true;
            getElement('form_responsableA').disabled = true;
        } else {
            getElement('form_tutoresA').disabled = false;
            getElement('form_responsableA').disabled = false;
        }
        if (getElement('form_grupos_to').options.length == 0) {
            getElement('form_tutoresB').disabled = true;
            getElement('form_responsableB').disabled = true;
        } else {
            getElement('form_tutoresB').disabled = false;
            getElement('form_responsableB').disabled = false;
        }
    }
"""

class GrupoAdminForm(W.TableForm):
    class Fields(W.WidgetsList):
        cursoID = W.HiddenField()
        listaGrupoA = W.SingleSelectField(label=_(u'Grupo A'), attrs = dict(onChange='onListaAChange()'), validator = V.Int(not_empty=True))
        listaGrupoB = W.SingleSelectField(label=_(u'Grupo B'), attrs = dict(onChange='onListaBChange()'), validator = V.Int(not_empty=True))
        grupos = AjaxDosListasSelect(label=_(u'Grupos'),title_from=u"Grupo A", size=8, move_signal="ActualizarResponsables();", title_to=u"Grupo B", validator=V.Int(not_empty=True))
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
    @validate(validators=dict(curso=V.Int))
    @paginate('records')
    def list(self, curso):
        """List records in model"""
        r = cls.selectBy(cursoID=curso)
        return dict(records=r, name=name, namepl=namepl.capitalize(), curso=Curso.get(curso))

    @expose(template='kid:%s.templates.new' % __name__)
    @validate(validators=dict(curso=V.Int))
    def new(self, curso, **kw):
        """Create new records in model"""
        kw['cursoID'] = curso # FIXME esto está roto porque los widgets son stateless
        options = dict(tutores=get_docentes_inscriptos(curso))
        return dict(name=name, namepl=namepl, form=form, options=options, values=kw)

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
                msg['label'] = alumnoInscripto
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
        kw['cursoID'] = cursoID
        return dict(name=name, namepl=namepl, options=options, form=formadmin, values=kw, cursoID=int(cursoID))

    @validate(form=formadmin)
    @error_handler(admin)
    @expose()
    def adminupdate(self, **kw):
        """Save or create record to model"""
        cursoID = int(kw['cursoID'])
        log.debug(kw)
        grupoAId = kw['listaGrupoA']
        grupoBId = kw['listaGrupoB']
        miembrosA = kw.get('grupos_from', [])
        miembrosB = kw.get('grupos_to', [])
        responsableA = kw['responsableA']
        responsableB = kw['responsableB']
        tutoresA = kw.get('tutoresA', [])
        tutoresB = kw.get('tutoresB', [])

        # por las dudas de que no sea una lista
        if not isinstance(miembrosA, list):
            miembrosA = [miembrosA]
        if not isinstance(miembrosB, list):
            miembrosB = [miembrosB]
        if not isinstance(tutoresA, list):
            tutoresA = [tutoresA]
        if not isinstance(tutoresB, list):
            tutoresB = [tutoresB]


        """ levanto los grupos originales """
        grupoAorig = validate_get(int(grupoAId))
        log.debug(miembrosA)
        log.debug(Miembro.selectBy(grupo=grupoAorig, baja=None))
        """ Si el grupo A quedo vacio deberia eliminarlo (primero
            genero los otros para que no elimine los alumnos)"""
        for mA in Miembro.selectBy(grupo=grupoAorig, baja=None):
            if str(mA.alumno.id) not in miembrosA:
                grupoAorig.remove_miembro(mA.alumno.id)

        try:
            grupoA = validate_get(grupoAId)
            for a in miembrosA:
                try:
                    grupoA.add_miembro(a, baja=None)
                except DuplicateEntryError:
                    continue
        except Exception, e:
            log.debug(e)
            flash(_(u'Error A %s.' % e))
            raise redirect(url('/curso/grupo/list' % int(cursoID)))
        # seteo el reponsable del grupo
        if responsableA and int(responsableA) != 0:
            grupoA.responsable = AlumnoInscripto.get(int(responsableA))

        for t in tutoresA:
            try:
                grupoA.add_tutor(int(t))
            except:
                #TODO ver por que no anda el duplicate error, por ahora cacheo silencioso
                pass


        #Elimino el grupo si quedo vacio
        if len(miembrosA) == 0:
            try:
                validate_del(grupoAId)
            except:
                pass

        # si se selecciono un grupo nuevo
        if int(grupoBId) == 0:
            # creo un grupo nuevo
            nuevosMiembros = []
            for m in miembrosB:
                nuevosMiembros.append(AlumnoInscripto.get(int(m)))
            nuevosTutores = []
            for t in tutoresB:
                nuevosTutores.append(DocenteInscripto.get(t))
            #Creo el nuevo grupo
            Grupo(miembros = nuevosMiembros, tutores = nuevosTutores, cursoID=cursoID, nombre='NuevoGrupo'+str(cursoID))
        else:
            grupoBorig = validate_get(int(grupoBId))
            log.debug(miembrosB)
            b = list(Miembro.selectBy(grupo=grupoBorig, baja=None))
            log.debug(b)
            #borro todos y los vuelvo a agregar
            for mB in Miembro.selectBy(grupo=grupoBorig, baja=None):
                if str(mB.alumno.id) not in miembrosB:
                    grupoBorig.remove_miembro(mB.alumno.id)
            try:
                grupoB = validate_get(grupoBId)
                for b in miembrosB:
                    try:
                        grupoB.add_miembro(b, baja=None)
                    except DuplicateEntryError:
                        continue
            except Exception, e:
                log.debug(e)
                flash(_(u'Error B %s.' % e))
                raise redirect(url('/curso/grupo/list/%d' % int(cursoID)))
            # seteo el reponsable del grupo
            if responsableB and int(responsableB) != 0:
                grupoB.responsable = AlumnoInscripto.get(int(responsableB))

            #Elimino el grupo si quedo vacio
            if len(miembrosB) == 0:
                try:
                    validate_del(grupoBId)
                except:
                    pass

            for t in tutoresB:
                try:
                    grupoB.add_tutor(int(t))
                except:
                    #TODO ver por que no anda el duplicate error, por ahora cahceo silencioso
                    pass
        flash(_(u'Los grupos fueron actualizado.'))
        raise redirect(url('/curso/grupo/list/%d' % int(cursoID)))
#}}}

