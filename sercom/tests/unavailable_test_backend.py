import turbogears
from turbogears import config
from turbogears import update_config
update_config(configfile='test.cfg', modulename='sercom.model')

from sercom.backend.context import *
from os.path import join
import subprocess as sp
import os
from datetime import datetime
from turbogears import testutil

from sercom import model
from sercom.model import Rol, Permiso, Curso, Alumno, Docente, TareaFuente, TareaPrueba, ComandoPrueba, Enunciado


class ComandoDummy:
    max_tiempo_cpu = None
    max_memoria = None
    max_tam_archivo = None
    max_cant_archivos = None
    max_cant_procesos = None
    max_locks_memoria = None

class TestContextoEjecucion(testutil.DBTest):

    def test_ejecutar_test_en_subprocess(self):
        contexto = self._crear_contexto()
        options = dict()
        options['close_fds']=True
        options['shell']=True
        options['preexec_fn'] = contexto.ejecutar_fuente(ComandoDummy())
        comando = 'ls'

        os.seteuid(0)
        os.setegid(0)
        try:
            proc = sp.Popen(comando, **options)
        finally:
            contexto.user_info.reset_permisos() # Mortal de nuevo
        retorno = proc.wait()
        assert retorno == 0, "Se obtuvo retorno %d" % retorno

    def _crear_contexto(self):
        user_info = UserInfo(config.get('sercom.tester.user', 65534))
        chroot_uid = config.get('sercom.tester.chroot.user', 65534)

        chroot_origen = join('var','chroot')
        chroot_destino = join('var','chroot_pablo')
        home_en_chroot = join('home', 'sercom')
        temp_folder = join('', 'tmp', 'sercom_pablo')
        return ContextoEjecucion(user_info, chroot_origen, chroot_destino, home_en_chroot, temp_folder, chroot_uid)

class TestCasoDePrueba(testutil.DBTest):
    model = model
    def test_ejecutar(self):
        ej = self._crear_ejercicio()

        from datetime import timedelta
        now = datetime.now()
        # Instancias de entrega
        i = ej.add_instancia(numero=1, inicio=now-timedelta(0,0,1),
            fin=now+timedelta(0,0,1), observaciones='observaciones', activo=True)

        ai = ej.curso.alumnos[0]

        # Entregas
        archivo_zip = file('doc/entrega.zip').read()
        entrega = ai.add_entrega(i, inicio=now, archivos=archivo_zip)


    def _crear_ejercicio(self):
        # Roles
        r1 = Rol(nombre='admin', permisos=())
#        r1.permisos = (Permiso.entregar_tp,Permiso.admin)
        r2 = Rol(nombre='alumno', permisos=())
#        r2.permisos = (Permiso.entregar_tp)


        # Usuarios
        d = Docente(usuario='luca', nombre=u'Leandro Lucarella', password='luca',
            email='llucax@gmail.com', telefono='4554-1554', roles=[r1], activo=True)
        a = Alumno(padron='77891', nombre='Tito Puente', password='77891', roles=[r2])

        # Tareas y comandos
        tf = TareaFuente(nombre='Compilar C con Makefile')
        com_f = tf.add_comando(1, 'make', retorno=0, max_cant_archivos=15,
            max_cant_procesos=200, terminar_si_falla=True, rechazar_si_falla=True,
            archivos_a_guardar=('__stdouterr__',),
            descripcion='Compila un programa en C con make ' \
            'sin usar un Makefile (debe ser un solo archivo que se llame tito.c)')
        tp = TareaPrueba(nombre='Probar')
        com_p = tp.add_comando(1, retorno=ComandoPrueba.RET_PRUEBA, terminar_si_falla=True,
            rechazar_si_falla=True, descripcion='Prueba normalmente, sin filtros')

        # Enunciados
        e = Enunciado(nombre=u'Un enunciado', anio=2007, cuatrimestre=1, autor=d,
            descripcion=u'descripcion', tareas=(tf, tp))

        # Casos de prueba
        cp = e.add_caso_de_prueba(nombre=u'prueba', retorno=0,
            descripcion=u'Un caso', comando='./tp')

        # Cursos
        c = Curso(anio=2007, cuatrimestre=1, numero=1, descripcion=u'Martes')
        c.add_docente(d)
        c.add_alumno(a)
        ej = c.add_ejercicio(1,e)
        return ej


