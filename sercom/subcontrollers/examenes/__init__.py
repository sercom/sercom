# vim: set et sw=4 sts=4 encoding=utf-8 foldmethod=marker :

#{{{ Imports
import cherrypy
import re
from datetime import datetime
from turbogears import controllers, expose, redirect
from turbogears import validate, flash, error_handler
from turbogears import validators as V
from turbogears import widgets as W
from turbogears import identity
from turbogears import paginate
from docutils.core import publish_parts
from sercom.subcontrollers import validate as val
from sercom.model import ExamenFinal, PreguntaExamen, TemaPregunta, TipoPregunta
from sqlobject import *
from tipo import TipoPreguntaController
from tema import TemaPreguntaController
from pregunta import PreguntaExamenController

#}}}

#{{{ Configuración
cls = ExamenFinal
name = 'Final'
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
class ExamenFinalFormSchema(V.Schema):
    fecha =  V.DateTimeConverter(format="%d/%m/%Y")
    anio = V.Number(min=0, max=32767, strip=True)
    cuatrimestre = V.Number(min=1, max=2, strip=True)
    oportunidad = V.Number(min=1, max=6, strip=True)

class ExamenFinalForm(W.TableForm):
    class Fields(W.WidgetsList):
        fecha = W.CalendarDatePicker(label = _('Fecha'),
        	calendar_lang = 'es',
                validator = V.DateTimeConverter(format="%d/%m/%Y"),
        	format = '%d/%m/%Y')
        anio = W.TextField(label = _(u'Año'), validator = V.Number(min=0, max=32767, strip=True))
        cuatrimestre = W.TextField(label = _('Cuatrimestre'), validator =  V.Number(min=1, max=2, strip=True, not_empty=True))
        oportunidad = W.TextField(label = _('Oportunidad'), validator =  V.Number(min=1, max=6, strip=True))
        #for numero_pregunta in range(1, cant_preguntas + 1):
        #        self.append(W.TextArea(name="pregunta%d" % numero_pregunta, label="Pregunta %d" % numero_pregunta))

    fields = Fields()

def create_form(examen_controller = None, cant_preguntas = 10):
    fields = list(ExamenFinalForm.fields)
    for numero_pregunta in range(1, cant_preguntas + 1):
        fields.append(W.TextArea(name="pregunta%d" % numero_pregunta, label="Pregunta %d" % numero_pregunta))
    return ExamenFinalForm(fields = fields)

#}}}

#{{{ Controlador
class ExamenFinalController(controllers.Controller):
   
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
        return dict(namepl='Examenes', records=ExamenFinal.select())

    @expose(template='kid:%s.templates.new' % __name__)
    def new(self, **kw):
        """Create new records in model"""
        return dict(name=name, namepl=namepl, form=create_form(), values=kw)

    def __extract_preguntas(self, kw):
        preguntas = {}
        regex = re.compile(r'(pregunta)(\d+)(.*)')
        for key in kw.keys():
            if regex.match(key):
                numero = regex.sub(r'\2',key)
                preguntas[int(numero)] = kw[key]
                del kw[key]
        return preguntas

    @validate(form=create_form)
    @error_handler(new)
    @expose()
    def create(self,  **kw):
        preguntas = self.__extract_preguntas(kw)
        """Save or create record to model"""
        examen = validate_new(kw)
        for numero in preguntas.keys():
            u = PreguntaExamen(numero = numero, texto = preguntas[numero], examen = examen)
        flash(_(u'Se creó un nuevo %s.') % name)
        raise redirect('list')

    @expose(template='kid:%s.templates.edit' % __name__)
    def edit(self, id, **kw):
        """Edit record in model"""
        class POD(dict):
            def __getattr__(self, attrname):
                return self[attrname]
        examen = validate_get(id)
        r = POD(examen.sqlmeta.asDict())
        for pregunta in examen.preguntas:
            r["pregunta%d" % pregunta.numero] = pregunta.texto
        return dict(name=name, namepl=namepl, record=r, form=create_form())

    @validate(form=create_form)
    @error_handler(edit)
    @expose()
    def update(self, id, **kw):
        preguntas = self.__extract_preguntas(kw)
        r = validate_set(id, kw)
        for numero in preguntas.keys():
            r.set_texto_pregunta(numero, preguntas[numero])
        flash(_(u'El %s fue actualizado.') % name)
        raise redirect('../list')

    @expose(template='kid:%s.templates.show' % __name__)
    def show(self,id, **kw):
        """Show record in model"""
        r = validate_get(id)
        return dict(name=name, namepl=namepl, record=r)

    @expose(template='kid:%s.templates.from_text' % __name__)
    def from_text(self):
        return dict()

    @expose(template='kid:%s.templates.new' % __name__)
    def from_text_add(self, **kw):
        """ Se espera :
             1)texto
             2)texto
        """
        fail = []
        regex = re.compile('(\d+)(\))(.*)')
        lines = kw['final'].split('\n')
        texto_actual = []
        numero_actual = 0
        for line in lines:
            if regex.match(line):
                if len(texto_actual) > 0:
                    kw["pregunta%d" % numero_actual]= '\n'.join(texto_actual)
                texto_actual = [regex.sub(r'\3', line)]
                numero_actual = int(regex.sub(r'\1', line))
            else:
                texto_actual.append(line)
        if len(texto_actual) > 0:
             kw["pregunta%d" % numero_actual]= '\n'.join(texto_actual)

        return dict(name=name, namepl=namepl, form=create_form(), values=kw)

    @expose(template='kid:%s.templates.from_file' % __name__)
    def from_file(self):
        return dict()

    def __find_examen(self, fecha, anio, cuatrimestre, oportunidad, examenes):
        key = (anio, cuatrimestre, oportunidad)
        examen = examenes.get(key)
        if examen is None:
            examen = ExamenFinal(fecha = fecha, anio = anio, cuatrimestre = cuatrimestre, oportunidad = oportunidad)
            examenes[key] = examen
        return examen

    def __find_tipo(self,descripcion, tipos):
        tipo = tipos.get(descripcion)
        if tipo is None:
            tipo = TipoPregunta(descripcion=descripcion)
            tipos[descripcion] = tipo
        return tipo

    def __find_tema(self,descripcion, temas):
        tema = temas.get(descripcion)
        if tema is None:
            tema = TemaPregunta(descripcion=descripcion)
            temas[descripcion] = tema
        return tema

    @expose(template='kid:%s.templates.import_results' % __name__)
    def from_file_add(self, archivo):
        """ Se espera :
             fecha(dd/mm/yyy),anio,cuatrimestre,oportunidad,numero_pregunta,texto_pregunta,tipo.tema
        """
        import csv
        lines = archivo.file.read().split('\n')
        ok = []
        fail = []
        examenes = dict([((e.anio, e.cuatrimestre, e.oportunidad), e) for e in ExamenFinal.select()])
        temas = dict([(t.descripcion, t) for t in TemaPregunta.select()])
        tipos = dict([(t.descripcion, t) for t in TipoPregunta.select()])
        for line in lines:
            for row in csv.reader([line]):
                if row == []:
                    continue
                try:
                    fecha = datetime.strptime(row[0], "%d/%m/%Y")
                    anio = int(row[1])
                    cuatrimestre = int(row[2])
                    oportunidad = int(row[3])
                    numero = int(row[4])
                    examen = self.__find_examen(fecha, anio, cuatrimestre, oportunidad, examenes)
                    tipo = self.__find_tipo(row[6], tipos)
                    tema = self.__find_tema(row[7], temas)
                    u = PreguntaExamen(texto=row[5], examen = examen, numero=numero, tipo=tipo, tema=tema)
                    ok.append(row)
                except Exception, e:
                    row.append(str(e))
                    fail.append(row)
        return dict(ok=ok, fail=fail)

    tema = TemaPreguntaController()
    tipo = TipoPreguntaController()
    pregunta = PreguntaExamenController()

#}}}

