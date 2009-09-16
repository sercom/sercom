from turbogears import widgets as W
from turbogears import validators as V
from sercom.model import TemaPregunta, TipoPregunta

class CustomSelectField(W.SingleSelectField):
	def __init__(self,**kw):
		super(W.SingleSelectField,self).__init__(**kw)	

	def addDefault(self,option):
		self.options.insert(0,('',option))


class TemaSelectField(CustomSelectField):
	def __get_temas(self):
        	return [(t.id, t.descripcion) for t in TemaPregunta.select()]   

	def __init__(self,**kw):
		kw['options'] = self.__get_temas
		kw['label']=_(u'Tema')
		kw['validator'] = V.Int(not_empty=True)
		super(CustomSelectField, self).__init__(**kw)


class TipoSelectField(CustomSelectField):
	def __get_tipos(self):
		return [(t.id, t.descripcion) for t in TipoPregunta.select()]   
        
	def __init__(self,**kw):
		kw['options'] = self.__get_tipos
		kw['label']=_(u'Tipo')
		kw['validator'] = V.Int(not_empty=True)
		super(CustomSelectField, self).__init__(**kw)

