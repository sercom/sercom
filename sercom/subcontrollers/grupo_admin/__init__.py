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
from sercom.model import Curso, AlumnoInscripto, Docente, Grupo, Alumno, Miembro
from sqlobject import *
from sqlobject.dberrors import *
from sercom.widgets import *
import logging

log = logging.getLogger('sercom.tester')

#}}}
""" Administrador de grupos, mezclar, juntar, dividir"""
#{{{ Configuración
cls = Grupo
name = 'grupo'
namepl = 'grupos'

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

def validate_del(id):
    return val.validate_del(cls, name, id)
#}}}

#{{{ Formulario
def get_docentes():
    return [(fk1.id, fk1.shortrepr()) for fk1 in Docente.select()]

def get_cursos():
    return [(0, u'---')] + [(fk1.id, fk1.shortrepr()) for fk1 in Curso.select()]

def get_gruposA():
    return [(0, u'---')] + [(g.id, g.shortrepr()) for g in Grupo.select()]

def get_gruposB():
    return [(0, u'Nuevo Grupo')] + [(g.id, g.shortrepr()) for g in Grupo.select()]

ajax = u"""
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

    function onsubmit()
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
        var result = loadJSONDoc('/grupo/get_alumnos?grupoid='+id);
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
def get_docentes():
    return [(fk1.id, fk1.shortrepr()) for fk1 in Docente.select()]

class GrupoAdminForm(W.TableForm):
    class Fields(W.WidgetsList):
        listaGrupoA = W.SingleSelectField(label=_(u'Grupo A'), options = get_gruposA, attrs = dict(onChange='onListaAChange()'), validator = V.Int(not_empty=True))
        listaGrupoB = W.SingleSelectField(label=_(u'Grupo B'), options = get_gruposB, attrs = dict(onChange='onListaBChange()'), validator = V.Int(not_empty=True))
        grupos = AjaxDosListasSelect(label=_(u'Grupos'),title_from="Grupo A", title_to="Grupo B", validator=V.Int(not_empty=True))
        responsableA = W.SingleSelectField(label=_(u'Responsable A'), validator = V.Int())
        responsableB = W.SingleSelectField(label=_(u'Responsable B'), validator = V.Int())
        tutoresA = W.MultipleSelectField(label=_(u'Tutores A'), options = get_docentes, validator = V.Int(not_empty=True))
        tutoresB = W.MultipleSelectField(label=_(u'Tutores B'), options = get_docentes, validator = V.Int(not_empty=True))

    fields = Fields()
    javascript = [W.JSSource("MochiKit.DOM.focusOnLoad('curso');"), W.JSSource(ajax)]
    form_attrs = dict(onsubmit='return onsubmit()')

form = GrupoAdminForm()

#}}}

#{{{ Controlador
class GrupoAdminController(controllers.Controller, identity.SecureResource):
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
    def new(self, cursoId, **kw):
        """Create new records in model"""
        #form.fields[7].attrs['value'] = cursoId
        return dict(name=name, namepl=namepl, form=form, values=kw, cursoId=int(cursoId))

    @validate(form=form)
    @error_handler(list)
    @expose()
    def update(self, cursoid, **kw):
        """Save or create record to model"""

        log.debug(kw)
        grupoAId = kw['listaGrupoA']
        grupoBId = kw['listaGrupoB']
        miembrosA = kw.get('grupos_from', [])
        miembrosB = kw.get('grupos_to', [])
        responsableA = kw['responsableA']
        responsableB = kw['responsableB']
        tutoresA = kw.get('tutoresA', [])
        tutoresB = kw.get('tutoresB', [])

        log.debug(miembrosA)
        log.debug(miembrosB)
        """ levanto los grupos originales """
        grupoAorig = validate_get(int(grupoAId))

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
            flash(_(u'Error A %s.' % e))
            raise redirect('/grupo/list')
        # seteo el reponsable del grupo
        if int(responsableA) != 0:
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
                nuevosTutores.append(Docente.get(t))
            #Creo el nuevo grupo
            Grupo(miembros = nuevosMiembros, tutores = nuevosTutores, cursoID=cursoid, nombre='NuevoGrupo'+str(cursoid))
        else:
            grupoBorig = validate_get(int(grupoBId))
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
                flash(_(u'Error B %s.' % e))
                raise redirect('/grupo/list')
            # seteo el reponsable del grupo
            if int(responsableB) != 0:
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
        raise redirect('/grupo/list')

    @expose(template='kid:%s.templates.show' % __name__)
    def show(self,id, **kw):
        """Show record in model"""
        r = validate_get(id)
        return dict(name=name, namepl=namepl, record=r)

    @expose()
    def delete(self, id):
        raise redirect('../grupo/list')
#}}}

