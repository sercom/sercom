from turbogears import widgets as W
from turbogears import validators as V
from sercom.model import TemaPregunta, TipoPregunta


class TemaSelectField(W.SingleSelectField):
	def __get_temas(self):
        	return [(t.id, t.descripcion) for t in TemaPregunta.select()]   

	def __init__(self,**kw):
		kw['options'] = self.__get_temas()
		kw['label']=_(u'Tema')
		kw['validator'] = V.Int()
		super(W.SingleSelectField, self).__init__(**kw)


class TipoSelectField(W.SingleSelectField):
	def __get_tipos(self):
		return [(t.id, t.descripcion) for t in TipoPregunta.select()]   
        
	def __init__(self,**kw):
		kw['options'] = self.__get_tipos()
		kw['label']=_(u'Tipo')
		kw['validator'] = V.Int()
		super(W.SingleSelectField, self).__init__(**kw)

