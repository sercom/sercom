
r1 = Rol(nombre='admin', permisos=(entregar_tp, admin))

r2 = Rol(nombre='alumno', permisos=(entregar_tp,))

d = Docente('luca', u'Leandro Lucarella', 'luca', 'llucax@gmail.com',
	'4554-1554', roles=[r1])

a = Alumno('77891', 'Tito Puente', '77891', roles=[r2])

t1 = Tarea('compilar')
t2 = Tarea('probar', dependencias=(t1,))
t3 = Tarea(u'configurar detector de copias')
t4 = Tarea(u'detectar copias', dependencias=(t3, t2))

e1 = Enunciado(u'Un enunciado', d, u'Ejercicio reeee jodido', (t4,))
e2 = Enunciado(u'Otro enunciado', d, u'Ejercicio facilongo', (t2, t4))
e3 = d.add_enunciado(u'Más enunciados', u'Ejercicio anónimo')

c = Curso(2007, 1, 1, u'Martes', [d], [e1, e2])

cp1 = e1.add_caso_de_prueba(u'Sin parámetros', retorno=0, descripcion=u'Un caso')
cp2 = e1.add_caso_de_prueba(u'2 parámetross', retorno=0, parametros=('--test', '-c'))

ej1 = c.ejercicios[0]
ej1.grupal = True
ej2 = c.ejercicios[1]

ide = ej1.add_instancia(1, datetime(2007, 1, 25), datetime(2007, 1, 31, 20),
    observaciones='Entrega fea', activo=False, tareas=(t2, t4))

di = c.docentes[0]

ai1 = c.add_alumno(a)
ai2 = c.add_alumno(Alumno('83525', u'Pepe Lui'), tutor=di)

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

