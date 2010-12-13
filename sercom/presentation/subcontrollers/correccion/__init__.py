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
from sercom.model import InstanciaExaminacion,InstanciaDeEntrega, AlumnoInscripto, DocenteInscripto, Entregador, Alumno
from sercom.domain.notas import CalculadorPromedioEjerciciosConConcepto
from sercom.domain.exceptions import AlumnoSinEntregas
from sqlobject import *
from sercom.presentation.controllers import BaseController
from zipfile import ZipFile, ZipInfo, BadZipfile
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

class ResumenEntregasFiltro(W.TableForm):
    class Fields(W.WidgetsList):
        instanciaID = W.SingleSelectField(label=_(u'Instancia Examinación'), validator=V.Int(not_empty=True))
        desertoresFLAG = W.CheckBox(label=_(u"Mostrar Alumnos sin entrega") )
        soloMiasFLAG = W.CheckBox(label=_(u"Mostrar sólo mis asignados") )
    form_attrs={'class':"filter"}
    fields = Fields()

filtro_resumen_entregas = ResumenEntregasFiltro()

class CalculoCorreccionesForm(W.TableForm):
    class Fields(W.WidgetsList):
        inst_destino_id = W.SingleSelectField(label=_(u'Destino de Nota'), help_text=_(u'Las notas calculadas se grabarán para esta instancia.'), validator=V.Int(not_empty=True))
        inst_concepto_id = W.SingleSelectField(label=_(u'Nota de Concepto'), help_text=_(u'Será tomada como nota de concepto para modificar el promedio calculado.'), validator=V.Int(not_empty=True))
    fields = Fields()

calculo_correcciones_form = CalculoCorreccionesForm()
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
    @paginate('records', limit=config.get('items_por_pagina'), dynamic_limit='limit_to')
    def mis_correcciones(self):
        """List records in model"""
        curso = self.get_curso_actual()
        r = list(cls.select(cls.q.correctorID == identity.current.user.get_inscripcion(curso).id))
        r.sort(lambda c1,c2:cmp(c1.instancia,c2.instancia), reverse=True)
        return dict(records=r, name=name, namepl=namepl, limit_to=identity.current.user.paginador)

    @expose(template='kid:%s.templates.show' % __name__)
    def show(self,id, **kw):
        """Show record in model"""
        r = validate_get(id)
        return dict(name=name, namepl=namepl, record=r, limit_to=identity.current.user.paginador)

    @expose(template='kid:%s.templates.entregas' % __name__)
    @paginate('records', limit=config.get('items_por_pagina'), dynamic_limit='limit_to')
    def entregas(self, id):
        r = validate_get(id)
        return dict(records=r.entregas, correccion = r, limit_to=identity.current.user.paginador)

    @expose(template='kid:%s.templates.resumen_por_alumno' % __name__)
    @paginate('records', limit=config.get('items_por_pagina'), dynamic_limit='limit_to')
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
            vfilter=vfilter, options=options, docenteActual=identity.current.user.id, limit_to=identity.current.user.paginador)

    @expose(template='kid:%s.templates.resumen_entregas' % __name__)
    @paginate('records', limit=config.get('items_por_pagina'), dynamic_limit='limit_to')
    def resumen_entregas(self,instanciaID=None, desertoresFLAG=None, soloMiasFLAG=None, csv=None):
        """Lista un resumen de los alumnos, sus entregas y correcciones para una instancia dada"""
        instancia_anterior = None
        if instanciaID:
            instancia = InstanciaExaminacion.get(instanciaID)
            if not desertoresFLAG:
              r = [x for x in instancia.get_resumen_entregas() if x.tiene_entregas]
            else:
              r = instancia.get_resumen_entregas()
            if soloMiasFLAG is not None:
                r = [x for x in r if x.correccion is not None and x.correccion.corrector.docente.id == identity.current.user.id]
            for i in r:
                i.corrector_anterior = None
                i.nota_anterior = None
                i.instancia_anterior = None 
            instancia_anterior = instancia
            while instancia_anterior.get_instancia_anterior() is not None:
                instancia_anterior = instancia_anterior.get_instancia_anterior()
                resumen = dict([(c.entregador, c) for c in instancia_anterior.correcciones])
                for i in r:
                    if i.entregador in resumen and i.corrector_anterior is None:
                        i.corrector_anterior = resumen[i.entregador].corrector.docente.usuario
                        i.nota_anterior = resumen[i.entregador].nota
                        i.instancia_anterior = instancia_anterior
        else:
            r = []
        instancias_opts = [(i.id,i.longrepr()) for i in self.get_curso_actual().instancias_examinacion_a_corregir]
        options = dict(instanciaID=instancias_opts)
        vfilter = dict(instanciaID=instanciaID, desertoresFLAG = desertoresFLAG, soloMiasFLAG=soloMiasFLAG)
        # Este método puede retornar un archivo csv
        if csv is not None:
            header = u'Padrón,Alumno,Corrector,Nota,Observaciones\n'
            lines = [('%s,"%s","%s",%f,"%s"' % (  i.entregador.alumno.padron, i.entregador.alumno.nombre, i.correccion.corrector,
                                                        i.correccion.nota if i.correccion.nota is not None else -1.0, i.correccion.observaciones))
                                                                     for i in r if i.correccion is not None]
            data = '\n'.join(lines)
            return self.enviar_csv(header+data, 'planilla.csv')
        else:
            return dict(records=r, name=name, namepl=namepl, form=filtro_resumen_entregas,
            vfilter=vfilter, options=options, instanciaID=instanciaID, desertoresFLAG=desertoresFLAG, soloMiasFLAG=soloMiasFLAG,
            docenteActual=identity.current.user.id, hayAnterior=instancia_anterior is not None, limit_to=identity.current.user.paginador)

    def enviar_csv(self, data, filename):
        download = Downloader(cherrypy.response)
        return download.download_csv(data, filename)

    @expose(template='kid:%s.templates.calculo_correcciones' % __name__)
    @paginate('records', dynamic_limit='limit_to')
    @identity.require(identity.in_any_group("JTP", "admin"))
    def calculo_correcciones(self,inst_destino_id=None, inst_concepto_id=None):
        """Simula y muestra los cálculos de correcciones para una instancia destino dada"""
        curso = self.get_curso_actual()
        if inst_destino_id and inst_concepto_id:
            inst_destino = InstanciaExaminacion.get(inst_destino_id)
            inst_concepto = InstanciaExaminacion.get(inst_concepto_id)
            calculador = CalculadorPromedioEjerciciosConConcepto(curso, inst_destino, inst_concepto)
            resultados = calculador.simular()
        else:
            resultados = []
        instancias_opts = [(i.id,i.longrepr()) for i in curso.instancias_examinacion_a_corregir]
        options = dict(inst_destino_id=instancias_opts, inst_concepto_id=instancias_opts)
        value = dict(inst_destino_id=inst_destino_id, inst_concepto_id=inst_concepto_id)
        return dict(records=resultados, name=name, namepl=namepl, form=calculo_correcciones_form,
            value=value, options=options, limit_to=identity.current.user.paginador)

    @expose()
    @identity.require(identity.in_any_group("JTP", "admin"))
    def aplicar_calculo_correcciones(self,inst_destino_id, inst_concepto_id, entregador_id = None):
        """Aplica el cálculo de correccion para una instancia destino dada"""
        curso = self.get_curso_actual()
        inst_destino = InstanciaExaminacion.get(inst_destino_id)
        inst_concepto = InstanciaExaminacion.get(inst_concepto_id)
        calculador = CalculadorPromedioEjerciciosConConcepto(curso, inst_destino, inst_concepto)
        docente = identity.current.user

        if entregador_id:
            alumno_inscripto = AlumnoInscripto.get(entregador_id)
            calculador.aplicar(docente, alumno_inscripto)
        else:
            calculador.aplicar_todas(docente)

        raise redirect('calculo_correcciones', inst_destino_id=inst_destino_id, inst_concepto_id=inst_concepto_id)

    @expose()
    def get_fuentes_instancia(self, instanciaID):
        try:
            instancia = InstanciaDeEntrega.get(instanciaID)
            r = [(instancia.find_entrega_a_corregir(x.entregador)) for x in instancia.get_resumen_entregas() if x.tiene_entregas]
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
            files = []
            for instancia in ejercicio.instancias: 
                if instancia.activo:
                    eeii = [(instancia.find_entrega_a_corregir(x.entregador)) for x in instancia.get_resumen_entregas() if x.tiene_entregas]
                    for entrega in eeii:
                        r[entrega.entregador.alumno.padron] = entrega
            for entrega in r.values():
                files.append('%s_%u/* ' % (entrega.entregador.alumno.padron.encode('ascii'), entrega.instancia.numero))
            extras = dict()
            if ejercicio.enunciado.lenguaje is not None and ejercicio.enunciado.lenguaje.mossnet_id is not None:
                extras['mossnet.sh'] = ('#!/bin/sh\nmossnet.pl -l %s -d %s' % (ejercicio.enunciado.lenguaje.mossnet_id, ''.join(files)))
            return self.enviar_zip(r.values(), ("ultimas_entregas_ej%u.zip" % instancia.ejercicio.numero), extras, ['Makefile', 'Makefile-cliente-servidor'])
        except SQLObjectNotFound:
            flash(_(u'Ejercicio inválido o inexistente.'))
            raise redirect('/')

    def enviar_zip(self, entregas, nombre, extras = None, ignoreFileNames = []):
        buffer = StringIO()
        zip = ZipFile(buffer, 'w')
        for e in entregas:
            szip = ZipFile(StringIO(e.archivos), 'r')
            for file in szip.namelist():
                if file not in ignoreFileNames:
                    zipinfo = ZipInfo('%s_%u/%s' % (e.entregador.alumno.padron.encode('ascii'), e.instancia.numero, file))
                    zipinfo.external_attr = 0664 << 16L
                    zip.writestr(zipinfo, szip.read(file))
            szip.close()
        if extras is not None:
            for exk in extras.keys():
                zipinfo = ZipInfo('%s' % exk)
                zipinfo.external_attr = 0774 << 16L
                zip.writestr(zipinfo, extras[exk])
        zip.close()
        download = Downloader(cherrypy.response)
        return download.download_zip(buffer.getvalue(), nombre)

    @error_handler(index)
    @expose()
    def new(self, instanciaID, entregadorID, justAssign=False):
        instancia = InstanciaExaminacion.get(instanciaID)
        entregador = Entregador.get(entregadorID)
	docente = identity.current.user
        try:
            correccion = docente.corregir(entregador, instancia)
            if justAssign:
                raise redirect('resumen_entregas', instanciaID=instanciaID)
            else:
                raise redirect('edit', correccionID = correccion.id)
        except AlumnoSinEntregas:
            flash(_(u'El entregador %s no realizó ninguna entrega para la '
                u'instancia %s') % (entregador, instancia))
            raise redirect('resumen_entregas', instanciaID=instanciaID)

    @error_handler(index)
    @expose()
    def delete(self, instanciaID, entregadorID, justAssign=False):
        instancia = InstanciaExaminacion.get(instanciaID)
        entregador = Entregador.get(entregadorID)
	docente = identity.current.user
        try:
            docente.eliminar_correccion(entregador, instancia)
            raise redirect('resumen_entregas', instanciaID=instanciaID)
        except AlumnoSinEntregas:
            flash(_(u'El alumno %s no realizó ninguna entrega para la '
                u'instancia %s') % (alumno, instancia))
            raise redirect('resumen_entregas', instanciaID=instanciaID)

    @expose(template='%s.templates.edit' % __name__)
    def edit(self, correccionID, **form_data):
        correccion = Correccion.get(correccionID)
        entregas_opts = [(e.id, '%s - %s' % (e.fecha, e.estadorepr())) for e in correccion.entregas]
        corrector_opts = [(di.id, unicode(di.docente))
                for di in correccion.instancia.get_posibles_correctores()]
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

