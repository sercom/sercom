# vim: set et sw=4 sts=4 encoding=utf-8 foldmethod=marker :

#{{{ Imports
import cherrypy
from turbogears import controllers, expose, redirect
from turbogears import validate, flash, error_handler, url
from turbogears import validators as V
from turbogears import widgets as W
from turbogears import identity
from turbogears import paginate
from turbogears import config
from docutils.core import publish_parts
from sercom.presentation.subcontrollers import validate as val
from sercom.model import Correccion, Curso, Ejercicio
from sercom.model import InstanciaDeEntrega, DocenteInscripto, Entregador, Alumno
from sercom.domain.exceptions import AlumnoSinEntregas
from sqlobject import *
from sercom.presentation.controllers import BaseController
from zipfile import ZipFile, BadZipfile
from sercom.presentation.utils.downloader import *
from cStringIO import StringIO

#}}}

#{{{ Configuración
cls = Correccion
name = 'correccion'
namepl = name + 'es'
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

class CorreccionForm(W.TableForm):
    class Fields(W.WidgetsList):
        entregaID = W.SingleSelectField(label=_(u'Entrega'),
                validator=V.Int) # TODO
        correctorID = W.SingleSelectField(label=_(u'Corrige'),
                validator=V.Int) # TODO
        asignado = W.CalendarDateTimePicker(label=_(u'Fecha de asignación'))
        corregido = W.CalendarDateTimePicker(label=_(u'Fecha de corrección'))
        nota = W.TextField(label=_(u'Nota'),
                validator=V.Number(strip=True))
        observaciones = W.TextArea(label=_(u'Observaciones'),
                validator=V.UnicodeString(not_empty=False, strip=True))
    fields = Fields()
    submit_text = _(u'Corregir')
    # TODO: crear chained validator para verificar que exista una correccion
    # con esa instanciaID y entregadorID
correccion_form = CorreccionForm()

class ResumenPorAlumnoFiltro(W.TableForm):
    class Fields(W.WidgetsList):
        alumno_id = W.SingleSelectField(label=_(u'Alumno'), validator=V.Int(not_empty=True))
    form_attrs={'class':"filter"}
    fields = Fields()

filtro_resumen_por_alumno = ResumenPorAlumnoFiltro()
#
class ResumenEntregasFiltro(W.TableForm):
    class Fields(W.WidgetsList):
        instanciaID = W.SingleSelectField(label=_(u'Ejercicio'), validator=V.Int(not_empty=True))
        desertoresFLAG = W.CheckBox(label=_(u"Mostrar Alumnos sin entrega?") )
    form_attrs={'class':"filter"}
    fields = Fields()

filtro_resumen_entregas = ResumenEntregasFiltro()
#}}}


#{{{ Controlador
class CorreccionController(BaseController, identity.SecureResource):
    """Basic model admin interface"""
    require = identity.in_any_group('admin','JTP','docente','redactor')

    @expose()
    def default(self, tg_errors=None):
        """handle non exist urls"""
        raise redirect('mis_correcciones')

    @expose()
    def index(self):
        raise redirect('mis_correcciones')

    @expose(template='kid:%s.templates.mis_correcciones' % __name__)
    @paginate('records', limit=config.get('items_por_pagina'))
    def mis_correcciones(self):
        """List records in model"""
        curso = self.get_curso_actual()
        r = cls.select(
                  AND(cls.q.correctorID == identity.current.user.get_inscripcion(curso).id,
                      cls.q.instanciaID == InstanciaDeEntrega.q.id,
                      InstanciaDeEntrega.q.ejercicioID == Ejercicio.q.id
                     )
                  ).orderBy(Ejercicio.q.numero)
        return dict(records=r, name=name, namepl=namepl)

    @expose(template='kid:%s.templates.show' % __name__)
    def show(self,id, **kw):
        """Show record in model"""
        r = validate_get(id)
        return dict(name=name, namepl=namepl, record=r)

    @expose(template='kid:%s.templates.entregas' % __name__)
    @paginate('records', limit=config.get('items_por_pagina'))
    def entregas(self, id):
        r = validate_get(id)
        return dict(records=r.entregas, correccion = r)

    @expose(template='kid:%s.templates.resumen_por_alumno' % __name__)
    @paginate('records', limit=config.get('items_por_pagina'))
    def resumen_por_alumno(self,alumno_id=None):
        """Lista un resumen de entregas y correcciones para una alumno dado"""
        curso = self.get_curso_actual()
        if alumno_id:
            alumno = Alumno.get(alumno_id)
            r = alumno.get_resumen_entregas(curso)
        else:
            r = []

        alumnos = [(ai.alumno.id, ai.alumno) for ai in sorted(curso.alumnos)]
        options = dict(alumno_id=alumnos)
        vfilter = dict(alumno_id=alumno_id)
        return dict(records=r, name=name, namepl=namepl, form=filtro_resumen_por_alumno,
            vfilter=vfilter, options=options, docenteActual=identity.current.user.id)

    @expose(template='kid:%s.templates.resumen_entregas' % __name__)
    @paginate('records', limit=config.get('items_por_pagina'))
    def resumen_entregas(self,instanciaID=None, desertoresFLAG=None):
        """Lista un resumen de los alumnos, sus entregas y correcciones para una instancia dada"""
        if instanciaID:
            instancia = InstanciaDeEntrega.get(instanciaID)
            if not desertoresFLAG:
              r = [x for x in instancia.get_resumen_entregas() if x.tiene_entregas]
            else:
              r = instancia.get_resumen_entregas()
        else:
            r = []
        instancia_anterior = instancia.get_instancia_anterior()
        if instancia_anterior is not None:
            resumen = dict([(c.entregador, c) for c in instancia_anterior.correcciones])
            for i in r:
                if i.entregador in resumen:
                    i.corrector_anterior = resumen[i.entregador].corrector.docente.usuario
                    i.nota_anterior = resumen[i.entregador].nota
                else:
                    i.corrector_anterior = None
                    i.nota_anterior = None
        instancias_opts = [(i.id,i.shortrepr()) for i in self.get_curso_actual().instancias_a_corregir]
        options = dict(instanciaID=instancias_opts)
        vfilter = dict(instanciaID=instanciaID, desertoresFLAG = desertoresFLAG)
        print identity.in_any_group('admin','JTP')
        return dict(records=r, name=name, namepl=namepl, form=filtro_resumen_entregas,
            vfilter=vfilter, options=options, instanciaID=instanciaID, desertoresFLAG=desertoresFLAG,
            docenteActual=identity.current.user.id, hayAnterior=instancia_anterior is not None)

    @expose()
    def get_fuentes_instancia(self, instanciaID):
        try:
            instancia = InstanciaDeEntrega.get(instanciaID)
            r = [(identity.current.user.find_entrega_a_corregir(x.entregador, instancia)) for x in instancia.get_resumen_entregas() if x.tiene_entregas]
            return self.enviar_zip(r, "entregas_instancia_%u.%u.zip" % (instancia.ejercicio.numero, instancia.numero))
        except:
            flash(_(u'Instancia incorrecta.'))
            raise redirect('/')

    @expose()
    def get_mis_fuentes_instancia(self, instanciaID):
        try:
            instancia = InstanciaDeEntrega.get(instanciaID)
            docenteInscripto = DocenteInscripto.pk.get(instancia.ejercicio.curso.id, identity.current.user.id)
            if docenteInscripto is not None:
                r = [e for e in instancia.entregas if Correccion.selectBy(entrega=e, corrector=docenteInscripto).count() == 1]
                return self.enviar_zip(r, "mis_entregas_instancia_%u.%u.zip" % (instancia.ejercicio.numero, instancia.numero))
            else:
                flash(_(u'Docente no inscripto.'))
                raise redirect('/')
        except:
            flash(_(u'Instancia incorrecta.'))
            raise redirect('/')


    @expose()
    def get_fuentes_ejercicio(self, ejercicioid):
        try:
            ejercicio = Ejercicio.get(ejercicioid)
            r = dict()
            for instancia in ejercicio.instancias: 
                if instancia.activo:
                    eeii = [(identity.current.user.find_entrega_a_corregir(x.entregador, instancia)) for x in instancia.get_resumen_entregas() if x.tiene_entregas]
                    for entrega in eeii:
                        r[entrega.entregador.alumno.padron] = entrega
            return self.enviar_zip(r.values(), "ultimas_entregas_ej%u.zip" % instancia.ejercicio.numero)
        except:
            flash(_(u'Ejercicio inválido o inexistente.'))
            raise redirect('/')

    def enviar_zip(self, entregas, nombre):
        buffer = StringIO()
        zip = ZipFile(buffer, 'w')
        for e in entregas:
            szip = ZipFile(StringIO(e.archivos), 'r')
            for file in szip.namelist():
                zip.writestr('%s_%u/%s' % (e.entregador.alumno.padron.encode('ascii'), e.instancia.numero, file), szip.read(file))
            szip.close()
        zip.close()
        download = Downloader(cherrypy.response)
        return download.download_zip(buffer.getvalue(), nombre)

    @error_handler(index)
    @expose()
    def new(self, instanciaID, entregadorID, justAssign=False):
        instancia = InstanciaDeEntrega.get(instanciaID)
        entregador = Entregador.get(entregadorID)
	docente = identity.current.user
        try:
            correccion = docente.corregir(entregador, instancia)
            if justAssign:
                raise redirect('resumen_entregas', instanciaID=instanciaID)
            else:
                raise redirect('edit', correccionID = correccion.id)
        except AlumnoSinEntregas:
            flash(_(u'El alumno %s no realizó ninguna entrega para la '
                u'instancia %s') % (alumno, instancia))
            raise redirect('index', instanciaID=instanciaID)

    @error_handler(index)
    @expose()
    def delete(self, instanciaID, entregadorID, justAssign=False):
        instancia = InstanciaDeEntrega.get(instanciaID)
        entregador = Entregador.get(entregadorID)
	docente = identity.current.user
        try:
            docente.eliminar_correccion(entregador, instancia)
            raise redirect('resumen_entregas', instanciaID=instanciaID)
        except AlumnoSinEntregas:
            flash(_(u'El alumno %s no realizó ninguna entrega para la '
                u'instancia %s') % (alumno, instancia))
            raise redirect('index', instanciaID=instanciaID)

    @expose(template='%s.templates.edit' % __name__)
    def edit(self, correccionID, **form_data):
        correccion = Correccion.get(correccionID)
        entregas_opts = [(e.id, '%s - %s' % (e.fecha, e.estadorepr())) for e in correccion.entregas]
        corrector_opts = [(di.id, unicode(di.docente))
                for di in correccion.instancia.ejercicio.curso.docentes]
        options = dict(entregaID=entregas_opts, correctorID=corrector_opts)
        return dict(correccion=correccion,
                correccion_form=correccion_form, options=options,
                action=url('save', correccionID = correccion.id))

    @validate(form=correccion_form)
    @error_handler(edit)
    @expose()
    def save(self, correccionID, **form_data):
        correccion = Correccion.get(correccionID)
        correccion.set(**form_data)
        flash('La corrección fue grabada correctamente.')
        raise redirect('edit',dict(correccionID=correccionID, form_data=form_data))

#}}}

