# vim: set et sw=4 sts=4 encoding=utf-8 foldmethod=marker :

from datetime import timedelta

# Roles
r1 = Rol(nombre='admin', permisos=(entregar_tp, admin))
r2 = Rol(nombre='alumno', permisos=(entregar_tp,))

# Usuarios
d = Docente(usuario='luca', nombre=u'Leandro Lucarella', password='luca',
    email='llucax@gmail.com', telefono='4554-1554', roles=[r1], activo=True)
a = Alumno(padron='77891', nombre='Tito Puente', password='77891', roles=[r2])

# Tareas y comandos
tf = TareaFuente(nombre='Compilar C con Makefile',
    terminar_si_falla=True, rechazar_si_falla=True)
cf = tf.add_comando(1, 'make -f Makefile', retorno=0, terminar_si_falla=True,
    rechazar_si_falla=True,
    descripcion='Compila usando un Makefile predeterminado')
tp = TareaPrueba(nombre='Probar', terminar_si_falla=True,
    rechazar_si_falla=True)
cp = tp.add_comando(1, [], retorno=0, terminar_si_falla=True,
    rechazar_si_falla=True, descripcion='Prueba normalmente, sin filtros')

# Enunciados
e1 = Enunciado(nombre=u'Un enunciado', anio=2007, cuatrimestre=1, autor=d,
    descripcion=u'Ejercicio reeee jodido', tareas=(tf, tp))
e2 = Enunciado(nombre=u'Otro enunciado', anio=2007, cuatrimestre=1, autor=d,
    descripcion=u'Ejercicio facilongo', tareas=(tf,))
e3 = d.add_enunciado(u'Más enunciados', anio=2007, cuatrimestre=1,
    descripcion=u'Ejercicio anónimo')

# Cursos
c = Curso(anio=2007, cuatrimestre=1, numero=1, descripcion=u'Martes',
    docentes=[d], ejercicios=[e1, e2])

# Casos de prueba
cp1 = e1.add_caso_de_prueba(nombre=u'Sin parámetros', retorno=0,
    descripcion=u'Un caso')
cp2 = e1.add_caso_de_prueba(nombre=u'2 parámetross', retorno=0,
    parametros='--test -c "con espacios"')

# Ejercicios
ej1 = c.ejercicios[0]
ej1.grupal = True
ej2 = c.ejercicios[1]

# Instancias de entrega
ide = ej1.add_instancia(numero=1, inicio=datetime(2007, 2, 25),
    fin=datetime(2007, 3, 31, 20), observaciones='Entrega fea', activo=True)

# Docentes/Alumnos/Grupos inscriptos
di = c.docentes[0]
ai1 = c.add_alumno(a)
ai2 = c.add_alumno(Alumno(padron='83525', nombre=u'Pepe Lui'), tutor=di)
g1 = c.add_grupo(5)
g2 = c.add_grupo(8, responsable=ai2, miembros=[ai1], tutores=[di])
g2.add_miembro(ai2)

# Entregas
archivo_zip = file('doc/entrega.zip').read()
ai1.add_entrega(ide, archivos=archivo_zip)
entrega = ai2.add_entrega(ide, inicio_tareas=datetime.now(),
    fin_tareas=datetime.now() + timedelta(0, 0, 1), correcta=True,
    archivos=archivo_zip)
entrega2 = g1.add_entrega(ide, inicio_tareas=datetime.now(),
    fin_tareas=datetime.now() + timedelta(0, 0, 3), correcta=False,
    archivos=archivo_zip)
d.add_entrega(ide, observaciones='Prueba de docente', archivos=archivo_zip)

# Comandos ejecutados / pruebas
cpe = entrega.add_comando_ejecutado(cf, exito=True,
    fin=datetime(2007, 2, 25, 10, 13, 34),
    inicio=datetime(2007, 2, 25, 10, 12, 34))
p = entrega.add_prueba(cp1)
p.add_comando_ejecutado(cp)

# Correcciones
di.add_correccion(entrega, asignado=datetime(2007, 1, 19), nota=7.5,
    corregido=datetime.now(), observaciones=u'Le faltó un punto')
di.add_correccion(entrega2)

__connection__.hub.commit()

