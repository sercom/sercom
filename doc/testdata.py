c = Curso(anio=2007, cuatrimestre=1, numero=1, descripcion=u'Martes')

d = Docente(usuario=u'luca', nombre='Leandro Lucarella')
d.password = 'luca'

a = Alumno(usuario='77891', nombre='Tito Puente')
a.password = '77891'

r = Rol(nombre='admin', permisos=(entregar_tp, admin))
d.addRol(r)

r = Rol(nombre='alumno', permisos=(entregar_tp,))
a.addRol(r)

t1 = Tarea(nombre='compilar')
t2 = Tarea(nombre='probar')
t2.dependencias = (t1,)
t3 = Tarea(nombre=u'configurar detector de copias')
t4 = Tarea(nombre=u'detectar copias')
t4.dependencias = (t3, t2)

e1 = Enunciado(nombre=u'Un enunciado', autor=d, descripcion=u'Ejercicio reeee jodido')
e2 = Enunciado(nombre=u'Otro enunciado', autor=d, descripcion=u'Ejercicio facilongo')
e3 = Enunciado(nombre=u'Más enunciados', descripcion=u'Ejercicio anónimo')
e1.tareas = (t4,)
e2.tareas = (t2, t4)

cp1 = e1.add_caso_de_prueba(u'Sin parámetros', retorno=0, descripcion=u'Un caso')
cp2 = e1.add_caso_de_prueba(u'2 parámetross', retorno=0, parametros=('--test', '-c'))

ej1 = c.add_ejercicio(1, e1, grupal=True)
ej2 = c.add_ejercicio(2, e2)

ide = ej1.add_instancia(1, datetime(2007, 1, 25), datetime(2007, 1, 31, 20),
    observaciones='Entrega fea', activo=False)
ide.tareas = (t2, t4)

di = c.add_docente(d, corrige=True, observaciones=u'Tipo Pulenta')

ai1 = c.add_alumno(a)
ai2 = c.add_alumno(Alumno(usuario='83525', nombre=u'Pepe Lui'), tutor=di)

g1 = c.add_grupo(5)
g2 = c.add_grupo(8, responsable=ai2)

g2.add_alumno(ai1)
g2.add_alumno(ai2)
g2.add_docente(di)

entrega = ai1.add_entrega(ide)
ai2.add_entrega(ide, correcta=True)
entrega2 = g1.add_entrega(ide, correcta=True)
d.add_entrega(ide, correcta=True, observaciones='Prueba de docente')

te = entrega.add_tarea_ejecutada(t1)
entrega.add_tarea_ejecutada(t2)
entrega2.add_tarea_ejecutada(t1, inicio=datetime(2007, 1, 2),
    fin=datetime.now(), exito=True)
entrega2.add_tarea_ejecutada(t2, observaciones='Va a tardar')

te.add_prueba(cp1, inicio=datetime(2007, 1, 7), fin=datetime.now(), pasada=True)
te.add_prueba(cp2)

di.add_correccion(entrega, asignado=datetime(2007, 1, 19), nota=7.5,
    corregido=datetime.now(), observaciones=u'Le faltó un punto')
di.add_correccion(entrega2)

__connection__.hub.commit()
