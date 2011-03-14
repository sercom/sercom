# vim: set et sw=4 sts=4 encoding=utf-8 foldmethod=marker :

#{{{ Imports
import string
import cherrypy
from turbogears import controllers, expose, redirect
from turbogears import validate, flash, error_handler
from turbogears import validators as V
from turbogears import widgets as W
from turbogears import identity
from turbogears import paginate
from turbogears import config
from docutils.core import publish_parts
from sercom.domain.notas import ResumenNotas
from sercom.presentation.subcontrollers import validate as val
from sercom.presentation.utils.downloader import *
from sercom.model import Curso, Correccion, Ejercicio, Alumno, Docente, Grupo, DocenteInscripto, Rol
from curso_alumno import *
from sqlobject import *
from sqlobject.dberrors import *
from sercom.widgets import *
from alumno import AlumnoInscriptoController
from grupo import GrupoController
from ejercicio import EjercicioController
from docente import DocenteInscriptoController
from instancia_evaluacion_alumno import InstanciaEvaluacionAlumnoController
#}}}

#{{{ Configuración
cls = Curso
name = 'curso'
namepl = name + 's'
#}}}

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

    function doSubmit()
    {
        /* TODO : Validar datos y evitar el submit si no esta completo */

        /* Selecciono todos los miembros si no, no llegan al controllere*/
        l = MochiKit.DOM.getElement('form_alumnos');
        for (i=0; i<l.options.length; i++) {
            l.options[i].selected = true;
        }
        /* Selecciono todos los miembros si no, no llegan al controllere*/
        l = MochiKit.DOM.getElement('form_docentes_to');
        for (i=0; i<l.options.length; i++) {
            l.options[i].selected = true;
        }
        return true; // Dejo hacer el submit
    }
"""



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

def get_docentes():
    return [(d.id, d) for d in Docente.selectBy(activo=True)]


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
        descripcion = W.TextField(label=_(u'Descripción'),
            help_text=_(u'Descripción.'),
            validator=V.UnicodeString(not_empty=False, strip=True))

        #docentes = W.MultipleSelectField(name="docentes",
        #    label=_(u'Docentes'),
        #    attrs=dict(style='width:300px'),
        #    options=get_docentes,
        #    validator=V.Int(not_empty=True))
        #addDocente = W.Button(default='Asignar', label='',
        #    attrs=dict( onclick='mover("form_docentes","form_docentes_curso")'))
        #remDocente = W.Button(default='Remover', label='',
        #    attrs=dict( onclick='remover("form_docentes_curso","form_docentes")'))
        #docentes_curso = W.MultipleSelectField(name="docentes_curso",
        #    label=_(u'Docentes del curso'),
        #    attrs=dict(style='width:300px'),
#       #     options=get_docentes_curso,
        #    validator=V.Int(not_empty=True))
        docentes = AjaxDosListasSelect(label=_(u'Docentes'),
            title_from="Docentes",
            title_to="Docentes del Curso",
            options=get_docentes,
            validator=V.Int(not_empty=True))

        alumnos = AjaxMultiSelect(label=_(u'Alumnos'),
                validator=V.Int(),
                attrs = dict(size='20'),
                on_add="alumnos_agregar_a_la_lista")

    fields = Fields()
    javascript = [W.JSSource(ajax)]
    form_attrs = dict(onsubmit='return doSubmit();')
form = CursoForm()
#}}}

#{{{ Controlador
class CursoController(controllers.Controller, identity.SecureResource):
    """Basic model admin interface"""

    require = identity.in_any_group('JTP', 'admin', 'redactor')
    curso_alumno = CursoAlumnoController()
    alumno = AlumnoInscriptoController()
    grupo = GrupoController()
    ejercicio = EjercicioController()
    docente = DocenteInscriptoController()
    instancia_evaluacion_alumno = InstanciaEvaluacionAlumnoController()

    @expose()
    def default(self, tg_errors=None):
        """handle non exist urls"""
        raise redirect('list')

    @expose()
    def index(self):
        raise redirect('list')

    @expose(template='kid:%s.templates.list' % __name__)
    @paginate('records', limit=config.get('items_por_pagina'))
    def list(self):
        """List records in model"""
        r = cls.select().orderBy((-cls.q.anio, -cls.q.cuatrimestre, cls.q.numero))
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
        print "--KW--"
        docentes = kw.get('docentes_to', [])
        alumnos = kw.get('alumnos', [])
        del(kw['docentes_to'])
        del(kw['alumnos'])
        kw['docentes'] = list();
        kw['alumnos'] = list();
        """ Agrego la nueva seleccion de docentes """
        for d in docentes:
            kw['docentes'].append(d)
        """ El curso es nuevo, por ende no hay alumnos inscriptos """
        for a in alumnos:
            kw['alumnos'].append(a)
        validate_new(kw)
        flash(_(u'Se creó un nuevo %s.') % name)
        raise redirect('list')

    @expose(template='kid:%s.templates.edit' % __name__)
    def edit(self, id, **kw):
        """Edit record in model"""
        r = validate_get(id)
        # cargo la lista con los docentes asignados al curso (FIXME)
        r.docentes_to = [{"id":d.docente.id, "label":unicode(d.docente).replace("'", "\\'")} for d in r.docentes]
        r.alumnos_inscriptos = [{"id":a.alumno.id, "label":unicode(a.alumno).replace("'", "\\'")} for a in r.alumnos]
        return dict(name=name, namepl=namepl, record=r, form=form)

    @validate(form=form)
    @error_handler(edit)
    @expose()
    def update(self, id, **kw):
        """Save or create record to model"""
        params = dict([(k,v) for (k,v) in kw.iteritems() if k in Curso.sqlmeta.columns.keys()])
        r = validate_set(id, params)

        docentes = [a for a in kw.get('docentes_to', [])]
        alumnos = [a for a in kw.get('alumnos', [])]
        alumnos_inscriptos = AlumnoInscripto.selectBy(curso=id)
        """ levanto los doncentes del curso para ver cuales tengo que agregar """
        docentes_inscriptos = DocenteInscripto.selectBy(curso=id)

        """ elimino a los docentes que no fueron seleccionados """
        for di in docentes_inscriptos:
            if di.id not in docentes:
                r.remove_docente(di.docente)

        """ Agrego la nueva seleccion """
        for d in docentes:
            try:
                r.add_docente(d)
            except:
                pass

        """ Verifico que los alumnos no esten ya inscriptos """
        for a in alumnos_inscriptos:
            if (a.id not in alumnos):
                try:
                    r.remove_alumno(a.alumno)
                except:
                    pass
        for a in alumnos:
            try:
                r.add_alumno(a)
            except:
                pass
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
        validate_del(id)
        flash(_(u'El %s fue eliminado permanentemente.') % name)
        raise redirect('../list')

    @expose(template='kid:%s.templates.from_file' % __name__)
    def from_file(self, id):
        return dict(cursoID=int(id))

    @expose(template='kid:%s.templates.import_results' % __name__)
    def from_file_add(self, id, archivo):
        """ Se espera :
             padron,nombre,email,telefono
        """
        import csv
        lines = archivo.file.read().split('\n')
        ok = []
        fail = []
        curso = Curso.get(int(id))
        for line in lines:
            for row in csv.reader([line]):
                if row == []:
                    continue
                try:
                    u = Alumno(row[0], nombre=row[1], roles=[Rol.by_nombre('alumno')])
                except:
                    u = Alumno.byPadron(row[0])
                try:
                    u.email = row[2]
                    u.telefono = row[3]
                    u.password = row[0]
                    u.activo = True
                    curso.add_alumno(u)
                    ok.append(row)
                except Exception, e:
                    row.append(str(e))
                    fail.append(row)
        return dict(ok=ok, fail=fail)

    @expose(template='kid:%s.templates.notas' % __name__)
    def notas(self, cursoid):
        curso = validate_get(cursoid)
        resumen = ResumenNotas()
        resumen.calcular(curso)
        return dict(curso=curso, resumen=resumen)

    @expose()
    def notascsv(self, cursoid):
        curso = validate_get(cursoid)
        resumen = ResumenNotas()
        resumen.calcular(curso)
 
        str_notas = u','.join([u'Padrón', u'Nombre', u'Grupos'] + [inst_nota.shortrepr() for inst_nota in resumen.instancias_nota]) + u'\n'
        for notas in resumen.notas_alumnos:
            valores = [notas.padron, notas.nombre, notas.grupos]
            for inst_nota in resumen.instancias_nota:
                valores.append(notas[inst_nota])
            str_notas  += u','.join(valores) + u'\n'
        downloader = Downloader(cherrypy.response)
        return downloader.download_csv(str_notas, "notas.csv")
        
#}}}

