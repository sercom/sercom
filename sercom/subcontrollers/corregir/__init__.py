# vim: set et sw=4 sts=4 encoding=utf-8 foldmethod=marker :

#{{{ Imports
#import cherrypy
from turbogears import controllers, expose, redirect
from turbogears import validate, flash, error_handler, url
from turbogears import validators as V
from turbogears import widgets as W
from turbogears import identity
from sercom.model import InstanciaDeEntrega, Entrega, Correccion, \
        Alumno, AlumnoInscripto, Curso, DateTimeCol
from sqlobject import SQLObjectNotFound
from sercom.domain.exceptions import AlumnoSinEntregas
#}}}

class InstanciaValidator(V.Int):
    def validate_python(self, value, state):
        if value not in [i.id for i in InstanciaDeEntrega.activas()]:
            raise V.Invalid(_(u'ID de instancia de entrega incorrecto'),
                    value, state)

class EntregadorValidator(V.Int):
    def validate_python(self, value, state):
        try:
            Entregador.get(value)
        except SQLObjectNotFound:
            raise V.Invalid(_(u'ID de entregador incorrecto'),
                    value, state)

class PadronValidator(V.UnicodeString):
    def validate_python(self, value, state):
        for c in Curso.activos():
            if value not in [ai.alumno.padron for ai in c.alumnos]:
                raise V.Invalid(_(u'No existe un alumno con padrón %s '
                        u'inscripto en el curso %s') % (value, c),
                        value, state)

class CorregirForm(W.TableForm):
    class Fields(W.WidgetsList):
        instanciaID = W.SingleSelectField(label=_(u'Ejercicio'),
                validator=InstanciaValidator)
        padron = W.TextField(label=_(u'Padrón'),
                validator=PadronValidator)
    fields = Fields()
    submit_text = _(u'Corregir')
    # TODO: crear chained validator para verificar que el alumno este inscripto
    # en el curso al que pertenece la instancia de entrega
corregir_form = CorregirForm()

class CorreccionForm(W.TableForm):
    class Fields(W.WidgetsList):
        entregaID = W.SingleSelectField(label=_(u'Entrega'),
                validator=V.Int) # TODO
        correctorID = W.SingleSelectField(label=_(u'Corrige'),
                validator=V.Int) # TODO
        asignado = W.CalendarDateTimePicker(label=_(u'Fecha de asignación'))
        corregido = W.CalendarDateTimePicker(label=_(u'Fecha de corrección'))
        nota = W.TextField(label=_(u'Nota'),
                validator=V.Number(not_empty=True, strip=True))
        observaciones = W.TextArea(label=_(u'Observaciones'),
                validator=V.UnicodeString(not_empty=False, strip=True))
    fields = Fields()
    submit_text = _(u'Corregir')
    # TODO: crear chained validator para verificar que exista una correccion
    # con esa instanciaID y entregadorID
correccion_form = CorreccionForm()

#{{{ Controlador
class CorregirController(controllers.Controller, identity.SecureResource):
    """Basic model admin interface"""
    require = identity.has_permission('corregir')

    @expose(template='%s.templates.index' % __name__)
    def index(self, **form_data):
        # TODO: soportar entregas grupales
        cursos = [di.curso for di in identity.current.user.inscripciones_activas]
        instancias_opts = [(i.id, u'Curso: %s - Ejer: %s.%s (%s)' % (i.ejercicio.curso,
                                                i.ejercicio.numero, i.numero, i.ejercicio.enunciado))
                    for i in InstanciaDeEntrega.activas(cursos)]
        options = dict(instanciaID=instancias_opts)
        return dict(corregir_form=corregir_form, form_data=form_data,
                options=options, action='new')

    @validate(form=corregir_form)
    @error_handler(index)
    @expose()
    def new(self, instanciaID, padron):
        instancia = InstanciaDeEntrega.get(instanciaID)
        alumno=Alumno.by_padron(padron)
	docente = identity.current.user
        try:
            correccion = docente.corregir(alumno, instancia)
            raise redirect('edit/%d' % correccion.id)
        except AlumnoSinEntregas:
            flash(_(u'El alumno %s no realizó ninguna entrega para la '
                u'instancia %s') % (alumno, instancia))
            raise redirect('index', instanciaID=instanciaID, padron=padron)

    @expose(template='%s.templates.edit' % __name__)
    def edit(self, correccionID, **form_data):
        correccion = Correccion.get(correccionID)
        entregas_opts = [(e.id, e.fecha) for e in correccion.entregas]
        corrector_opts = [(di.id, unicode(di.docente))
                for di in correccion.instancia.ejercicio.curso.docentes]
        options = dict(entregaID=entregas_opts, correctorID=corrector_opts)
        return dict(correccion=correccion,
                correccion_form=correccion_form, options=options,
                action='../save/%d' % correccion.id)

    @validate(form=correccion_form)
    @error_handler(edit)
    @expose()
    def save(self, correccionID, **form_data):
        correccion = Correccion.get(correccionID)
        correccion.set(**form_data)
        raise redirect('../')

#}}}

