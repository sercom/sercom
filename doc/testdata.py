# vim: set et sw=4 sts=4 encoding=utf-8 foldmethod=marker :

r1 = Rol(nombre='admin', permisos=(entregar_tp, admin))

r2 = Rol(nombre='alumno', permisos=(entregar_tp,))

d = Docente(usuario='luca', nombre=u'Leandro Lucarella', password='luca',
    email='llucax@gmail.com', telefono='4554-1554', roles=[r1], activo=True)

a = Alumno(padron='77891', nombre='Tito Puente', password='77891', roles=[r2])

t1 = Tarea(nombre='compilar')
t2 = Tarea(nombre='probar', dependencias=(t1,))
t3 = Tarea(nombre=u'configurar detector de copias')
t4 = Tarea(nombre=u'detectar copias', dependencias=(t3, t2))

e1 = Enunciado(nombre=u'Un enunciado', anio=2007, cuatrimestre=1, autor=d,
    descripcion=u'Ejercicio reeee jodido', tareas=(t4,))
e2 = Enunciado(nombre=u'Otro enunciado', anio=2007, cuatrimestre=1, autor=d,
    descripcion=u'Ejercicio facilongo', tareas=(t2, t4))
e3 = d.add_enunciado(u'Más enunciados', anio=2007, cuatrimestre=1,
    descripcion=u'Ejercicio anónimo')

c = Curso(anio=2007, cuatrimestre=1, numero=1, descripcion=u'Martes',
    docentes=[d], ejercicios=[e1, e2])

cp1 = e1.add_caso_de_prueba(nombre=u'Sin parámetros', retorno=0,
    descripcion=u'Un caso')
cp2 = e1.add_caso_de_prueba(nombre=u'2 parámetross', retorno=0,
    parametros='--test -c "con espacios"')

ej1 = c.ejercicios[0]
ej1.grupal = True
ej2 = c.ejercicios[1]

ide = ej1.add_instancia(numero=1, inicio=datetime(2007, 1, 25),
    fin=datetime(2007, 1, 31, 20), observaciones='Entrega fea', activo=False,
    tareas=(t2, t4))

di = c.docentes[0]

ai1 = c.add_alumno(a)
ai2 = c.add_alumno(Alumno(padron='83525', nombre=u'Pepe Lui'), tutor=di)

g1 = c.add_grupo(5)
g2 = c.add_grupo(8, responsable=ai2, miembros=[ai1], tutores=[di])

g2.add_miembro(ai2)

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

