
from turbogears import url

menu = []
menu.append({'name': 'Alumnos', 'url':url('/alumno')})
menu.append({'name': 'Docentes', 'url':url('/docente')})
menu.append({'name': 'Grupos', 'url':url('/grupo')})
menu.append({'name': 'Enunciados', 'url':url('/enunciado')})
menu.append({'name': 'Ejercicios', 'url':url('/ejercicio')})
menu.append({'name': 'Casos de Prueba', 'url':url('/caso_de_prueba')})
menu.append({'name': 'Cursos', 'url':url('/curso')})
