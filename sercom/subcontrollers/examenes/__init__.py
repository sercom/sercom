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
from sercom.subcontrollers.examenes import custom_selects as CS
from sercom.model import ExamenFinal, PreguntaExamen, TemaPregunta, TipoPregunta
from sercom.model import DTOPregunta
from sqlobject import *
from tipo import TipoPreguntaController
from tema import TemaPreguntaController
from pregunta import PreguntaExamenController

#}}}


class Mascaras: pass
Mascaras.TEXTO = "pregunta%d"
Mascaras.TEXTO_REGEX = re.compile(r'(pregunta)(\d+)(.*)')
Mascaras.TIPO = "tipo%d"
Mascaras.TIPO_REGEX = re.compile(r'(tipo)(\d+)(.*)')
Mascaras.TEMA = "tema%d"
Mascaras.TEMA_REGEX = re.compile(r'(tema)(\d+)(.*)')


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

    fields = Fields()

def create_form(examen_controller = None, cant_preguntas = 10):
    fields = list(ExamenFinalForm.fields)
    for numero_pregunta in range(1, cant_preguntas + 1):
	fields.append(CS.TemaSelectField(name=Mascaras.TEMA % numero_pregunta))
	fields.append(CS.TipoSelectField(name=Mascaras.TIPO % numero_pregunta))
        fields.append(W.TextArea(name=Mascaras.TEXTO % numero_pregunta, label="Pregunta %d" % numero_pregunta))
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
	for i in range(1,11):
		preguntas[i] = DTOPregunta("",None,None)

        for key in kw.keys():
        	if Mascaras.TEXTO_REGEX.match(key):
                	numero = Mascaras.TEXTO_REGEX.sub(r'\2',key)
			preguntas[int(numero)].texto = kw[key]
               		del kw[key]
		elif Mascaras.TEMA_REGEX.match(key):
			numero = Mascaras.TEMA_REGEX.sub(r'\2',key)
			preguntas[int(numero)].tema = int(kw[key])
			del kw[key]
		elif Mascaras.TIPO_REGEX.match(key):
			numero = Mascaras.TIPO_REGEX.sub(r'\2',key)
			preguntas[int(numero)].tipo = int(kw[key])
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
            u = PreguntaExamen(numero = numero, dto = preguntas[numero],examen = examen)
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
        	r[Mascaras.TEXTO % pregunta.numero] = pregunta.texto
        	r[Mascaras.TIPO % pregunta.numero] = pregunta.tipoID
        	r[Mascaras.TEMA % pregunta.numero] = pregunta.temaID
        return dict(name=name, namepl=namepl, record=r, form=create_form())

    @validate(form=create_form)
    @error_handler(edit)
    @expose()
    def update(self, id, **kw):
        preguntas = self.__extract_preguntas(kw)
        r = validate_set(id, kw)
        for numero in preguntas.keys():
            r.update_pregunta(numero, preguntas[numero])
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

    @expose(template='kid:%s.templates.from_text' % __name__)
    def from_text(self):
        return dict()

    @expose(template='kid:%s.templates.new' % __name__)
    def from_text_add(self, **kw):
        """ Se espera :
             1)texto
             2)texto
        """
	texto_preguntas = kw['final']
        separador_preguntas = kw['separador']
        preguntas = PreguntaExamen.parse_preguntas(texto_preguntas,separador_preguntas)
        for numero_pregunta in preguntas.keys():
            kw[Mascaras.TEXTO % numero_pregunta] = preguntas[numero_pregunta]

        return dict(name=name, namepl=namepl, form=create_form(), values=kw)

    @expose(template='kid:%s.templates.from_file' % __name__)
    def from_file(self):
        return dict()

    @expose(template='kid:%s.templates.import_results' % __name__)
    def from_file_add(self, archivo, encoding):
        """ Se espera :
             fecha(dd/mm/yyy),anio,cuatrimestre,oportunidad,numero_pregunta,texto_pregunta,tipo.tema
        """
	#encoding = kw['encoding']
	#archivo = kw['archivo']
        (ok, fail) = PreguntaExamen.import_preguntas(archivo.file, encoding, 'utf-8')

        return dict(ok=ok, fail=fail)

    tema = TemaPreguntaController()
    tipo = TipoPreguntaController()
    pregunta = PreguntaExamenController()

#}}}
