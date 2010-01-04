from turbogears import widgets as W
from turbogears import validators as V
from sercom.model import TemaPregunta, TipoPregunta

class CustomSelectField(W.SingleSelectField):
	def __init__(self,**kw):
		self.default_values = []
		kw['options'] = self.__get_values
		kw['label']= self.get_specific_label()
		kw['validator'] = V.Int(not_empty=True)
		super(W.SingleSelectField,self).__init__(**kw)	

	def __get_values(self):
		return self.default_values + self.get_specific_values()

	def add_default(self,option):
		self.default_values.append(('',option))


class TemaSelectField(CustomSelectField):
	def get_specific_values(self):
        	return [(t.id, t.descripcion) for t in TemaPregunta.select()]   

	def get_specific_label(self):
		return u'Tema'

class TipoSelectField(CustomSelectField):
	def get_specific_values(self):
		return [(t.id, t.descripcion) for t in TipoPregunta.select()]   

	def get_specific_label(self):
		return u'Tipo'

