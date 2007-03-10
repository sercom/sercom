# vim: set et sw=4 sts=4 encoding=utf-8 foldmethod=marker:

from sercom.model import Entrega, CasoDePrueba
from sercom.model import TareaFuente, TareaPrueba, ComandoFuente, ComandoPrueba
from zipfile import ZipFile, BadZipfile
from cStringIO import StringIO
from shutil import rmtree
from datetime import datetime
from subprocess import Popen, PIPE, call #, check_call XXX Python 2.5
from os.path import join
from turbogears import config
import os, sys, pwd, grp
import resource as rsrc
import logging

log = logging.getLogger('sercom.tester')

error_interno = _(u'\n**Error interno al preparar la entrega.**')

class UserInfo(object): #{{{
    def __init__(self, user):
        try:
            info = pwd.getpwnam(user)
        except:
            info = pwd.get(int(user))
        self.user = info[0]
        self.uid = info[2]
        self.gid = info[3]
        self.name = info[4]
        self.home = info[5]
        self.shell = info[6]
        self.group = grp.getgrgid(self.gid)[0]
#}}}

user_info = UserInfo(config.get('sercom.tester.user', 65534))

def check_call(*popenargs, **kwargs): #{{{ Python 2.5 forward-compatibility
    """Run command with arguments.  Wait for command to complete.  If
    the exit code was zero then return, otherwise raise
    CalledProcessError.  The CalledProcessError object will have the
    return code in the returncode attribute.
    ret = call(*popenargs, **kwargs)

    The arguments are the same as for the Popen constructor.  Example:

    check_call(["ls", "-l"])
    """
    retcode = call(*popenargs, **kwargs)
    cmd = kwargs.get("args")
    if cmd is None:
        cmd = popenargs[0]
    if retcode:
        raise CalledProcessError(retcode, cmd)
    return retcode
#}}}

#{{{ Excepciones

class CalledProcessError(Exception): #{{{ Python 2.5 forward-compatibility
    """This exception is raised when a process run by check_call() returns
    a non-zero exit status.  The exit status will be stored in the
    returncode attribute."""
    def __init__(self, returncode, cmd):
        self.returncode = returncode
        self.cmd = cmd
    def __str__(self):
        return ("Command '%s' returned non-zero exit status %d"
            % (self.cmd, self.returncode))
#}}}

class Error(StandardError): pass

class ExecutionFailure(Error, RuntimeError): pass

class RsyncError(Error, EnvironmentError): pass

#}}}

def unzip(bytes, dst): # {{{
    log.debug(_(u'Intentando descomprimir en %s'), dst)
    if bytes is None:
        return
    zfile = ZipFile(StringIO(bytes), 'r')
    for f in zfile.namelist():
        if f.endswith(os.sep):
            log.debug(_(u'Creando directorio %s'), f)
            os.mkdir(join(dst, f))
        else:
            log.debug(_(u'Descomprimiendo archivo %s'), f)
            file(join(dst, f), 'w').write(zfile.read(f))
#}}}

class SecureProcess(object): #{{{
    default = dict(
        max_tiempo_cpu      = 120,
        max_memoria         = 16,
        max_tam_archivo     = 5,
        max_cant_archivos   = 5,
        max_cant_procesos   = 0,
        max_locks_memoria   = 0,
    )
    uid = config.get('sercom.tester.chroot.user', 65534)
    MB = 1048576
    # XXX probar! make de un solo archivo lleva nproc=100 y nofile=15
    def __init__(self, comando, chroot, cwd):
            self.comando = comando
            self.chroot = chroot
            self.cwd = cwd
    def __getattr__(self, name):
        if getattr(self.comando, name) is not None:
            return getattr(self.comando, name)
        return config.get('sercom.tester.limits.' + name, self.default[name])
    def __call__(self):
        x2 = lambda x: (x, x)
        os.chroot(self.chroot)
        os.chdir(self.cwd)
        uinfo = UserInfo(self.uid)
        os.setgid(uinfo.gid)
        os.setuid(uinfo.uid) # Somos mortales irreversiblemente
        rsrc.setrlimit(rsrc.RLIMIT_CPU, x2(self.max_tiempo_cpu))
        rsrc.setrlimit(rsrc.RLIMIT_AS, x2(self.max_memoria*self.MB))
        rsrc.setrlimit(rsrc.RLIMIT_FSIZE, x2(self.max_tam_archivo*self.MB)) # XXX calcular en base a archivos esperados?
        rsrc.setrlimit(rsrc.RLIMIT_NOFILE, x2(self.max_cant_archivos)) #XXX Obtener de archivos esperados?
        rsrc.setrlimit(rsrc.RLIMIT_NPROC, x2(self.max_cant_procesos))
        rsrc.setrlimit(rsrc.RLIMIT_MEMLOCK, x2(self.max_locks_memoria))
        rsrc.setrlimit(rsrc.RLIMIT_CORE, x2(0))
        log.debug('Proceso segurizado: chroot=%s, cwd=%s, user=%s(%s), '
            'group=%s(%s), cpu=%s, as=%sMiB, fsize=%sMiB, nofile=%s, nproc=%s, '
            'memlock=%s', self.chroot, self.cwd, uinfo.user, uinfo.uid,
            uinfo.group, uinfo.gid, self.max_tiempo_cpu, self.max_memoria,
            self.max_tam_archivo, self.max_cant_archivos,
            self.max_cant_procesos, self.max_locks_memoria)
        # Tratamos de forzar un sync para que entre al sleep del padre FIXME
        import time
        time.sleep(0)
#}}}

class Tester(object): #{{{

    def __init__(self, name, path, home, queue): #{{{ y properties
        self.name = name
        self.path = path
        self.home = home
        self.queue = queue
        # Ahora somos mortales (oid mortales)
        log.debug(_(u'Cambiando usuario y grupo efectivos a %s:%s (%s:%s)'),
            user_info.user, user_info.group, user_info.uid, user_info.gid)
        os.setegid(user_info.gid)
        os.seteuid(user_info.uid)

    @property
    def build_path(self):
        return join(self.chroot, self.home, 'build')

    @property
    def test_path(self):
        return join(self.chroot, self.home, 'test')

    @property
    def chroot(self):
        return join(self.path, 'chroot_' + self.name)
    #}}}

    @property
    def orig_chroot(self):
        return join(self.path, 'chroot')

    def run(self): #{{{
        entrega_id = self.queue.get() # blocking
        while entrega_id is not None:
            entrega = Entrega.get(entrega_id)
            log.debug(_(u'Nueva entrega para probar en tester %s: %s'),
                self.name, entrega)
            self.test(entrega)
            log.debug(_(u'Fin de pruebas de: %s'), entrega)
            entrega_id = self.queue.get() # blocking
    #}}}

    def test(self, entrega): #{{{
        log.debug(_(u'Tester.test(entrega=%s)'), entrega)
        entrega.inicio_tareas = datetime.now()
        try:
            try:
                self.setup_chroot(entrega)
                self.ejecutar_tareas_fuente(entrega)
                self.ejecutar_tareas_prueba(entrega)
                self.clean_chroot(entrega)
            except ExecutionFailure, e:
                entrega.correcta = False
                log.info(_(u'Entrega incorrecta: %s'), entrega)
            except Exception, e:
                if isinstance(e, SystemExit): raise
                entrega.observaciones += error_interno
                log.exception(_(u'Hubo una excepción inesperada: %s'), e)
            except:
                entrega.observaciones += error_interno
                log.exception(_(u'Hubo una excepción inesperada desconocida'))
            else:
                entrega.correcta = True
                log.debug(_(u'Entrega correcta: %s'), entrega)
        finally:
            entrega.fin_tareas = datetime.now()
    #}}}

    def setup_chroot(self, entrega): #{{{ y clean_chroot()
        log.debug(_(u'Tester.setup_chroot(entrega=%s)'), entrega.shortrepr())
        rsync = ('rsync', '--stats', '--itemize-changes', '--human-readable',
            '--archive', '--acls', '--delete-during', '--force', # TODO config
            join(self.orig_chroot, ''), self.chroot)
        log.debug(_(u'Ejecutando como root: %s'), ' '.join(rsync))
        os.seteuid(0) # Dios! (para chroot)
        os.setegid(0)
        try:
            check_call(rsync)
        finally:
            log.debug(_(u'Cambiando usuario y grupo efectivos a %s:%s (%s:%s)'),
                user_info.user, user_info.group, user_info.uid, user_info.gid)
            os.setegid(user_info.gid) # Mortal de nuevo
            os.seteuid(user_info.uid)
        unzip(entrega.archivos, self.build_path)

    def clean_chroot(self, entrega):
        log.debug(_(u'Tester.clean_chroot(entrega=%s)'), entrega.shortrepr())
        pass # Se limpia con el próximo rsync
    #}}}

    def ejecutar_tareas_fuente(self, entrega): #{{{ y tareas_prueba
        log.debug(_(u'Tester.ejecutar_tareas_fuente(entrega=%s)'),
            entrega.shortrepr())
        tareas = [t for t in entrega.instancia.ejercicio.enunciado.tareas
                    if isinstance(t, TareaFuente)]
        for tarea in tareas:
            tarea.ejecutar(self.build_path, entrega)

    def ejecutar_tareas_prueba(self, entrega):
        log.debug(_(u'Tester.ejecutar_tareas_prueba(entrega=%s)'),
            entrega.shortrepr())
        for caso in entrega.instancia.ejercicio.enunciado.casos_de_prueba:
            caso.ejecutar(self.test_path, entrega)
    #}}}

#}}}

def ejecutar_caso_de_prueba(self, path, entrega): #{{{
    log.debug(_(u'CasoDePrueba.ejecutar(path=%s, entrega=%s)'), path,
        entrega.shortrepr())
    tareas = [t for t in entrega.instancia.ejercicio.enunciado.tareas
                if isinstance(t, TareaPrueba)]
    prueba = entrega.add_prueba(self)
    try:
        try:
            for tarea in tareas:
                tarea.ejecutar(path, prueba)
        except ExecutionFailure, e:
            prueba.exito = False
            if self.rechazar_si_falla:
                entrega.exito = False
            if self.terminar_si_falla:
                raise ExecutionError(e.comando, e.tarea, prueba)
        else:
            prueba.exito = True
    finally:
        prueba.fin = datetime.now()
CasoDePrueba.ejecutar = ejecutar_caso_de_prueba
#}}}

def ejecutar_tarea_fuente(self, path, entrega): #{{{
    log.debug(_(u'TareaFuente.ejecutar(path=%s, entrega=%s)'), path,
        entrega.shortrepr())
    try:
        for cmd in self.comandos:
            cmd.ejecutar(path, entrega)
    except ExecutionFailure, e:
        if self.rechazar_si_falla:
            entrega.exito = False
        if self.terminar_si_falla:
            raise ExecutionError(e.comando, tarea)
TareaFuente.ejecutar = ejecutar_tarea_fuente
#}}}

def ejecutar_tarea_prueba(self, path, prueba): #{{{
    log.debug(_(u'TareaPrueba.ejecutar(path=%s, prueba=%s)'), path,
        prueba.shortrepr())
    try:
        for cmd in self.comandos:
            cmd.ejecutar(path, prueba)
    except ExecutionFailure, e:
        if self.rechazar_si_falla:
            prueba.exito = False
        if self.terminar_si_falla:
            raise ExecutionError(e.comando, tarea)
TareaPrueba.ejecutar = ejecutar_tarea_prueba
#}}}

def ejecutar_comando_fuente(self, path, entrega): #{{{
    log.debug(_(u'ComandoFuente.ejecutar(path=%s, entrega=%s)'), path,
        entrega.shortrepr())
    unzip(self.archivos_entrada, path) # TODO try/except
    comando_ejecutado = entrega.add_comando_ejecutado(self)
    # Abro archivos para fds básicos (FIXME)
    options = dict(
        close_fds=True,
        stdin=None,
        stdout=None,
        stderr=None,
        shell=True,
        preexec_fn=SecureProcess(self, 'var/chroot_pepe', '/home/sercom/build')
    )
    log.debug(_(u'Ejecutando como root: %s'), self.comando)
    os.seteuid(0) # Dios! (para chroot)
    os.setegid(0)
    try:
        try:
            proc = Popen(self.comando, **options)
        finally:
            log.debug(_(u'Cambiando usuario y grupo efectivos a %s:%s (%s:%s)'),
                user_info.user, user_info.group, user_info.uid, user_info.gid)
            os.setegid(user_info.gid) # Mortal de nuevo
            os.seteuid(user_info.uid)
    except Exception, e: # FIXME poner en el manejo de exceptiones estandar
        if hasattr(e, 'child_traceback'):
            log.error(_(u'Error en el hijo: %s'), e.child_traceback)
        raise
    proc.wait()
    comando_ejecutado.fin = datetime.now()
#    if no_anda_ejecucion: # TODO
#        comando_ejecutado.exito = False
#        comando_ejecutado.observaciones += 'No anduvo xxx' # TODO mas info
#        if self.rechazar_si_falla:
#            entrega.exito = False
#        if self.terminar_si_falla: # TODO
#            raise ExecutionFailure(self)
    # XXX ESTO EN REALIDAD EN COMANDOS FUENTE NO IRIA
    # XXX SOLO HABRÍA QUE CAPTURAR stdout/stderr
    # XXX PODRIA TENER ARCHIVOS DE SALIDA PERO SOLO PARA MOSTRAR COMO RESULTADO
#    for archivo in self.archivos_salida:
#        pass # TODO hacer diff
#    if archivos_mal: # TODO
#        comando_ejecutado.exito = False
#        comando_ejecutado.observaciones += 'No anduvo xxx' # TODO mas info
#        if self.rechazar_si_falla:
#            entrega.exito = False
#        if self.terminar_si_falla: # TODO
#            raise ExecutionFailure(self)
#    else:
#        comando_ejecutado.exito = True
#        comando_ejecutado.observaciones += 'xxx OK' # TODO
    comando_ejecutado.exito = True
    comando_ejecutado.observaciones += 'xxx OK' # TODO
ComandoFuente.ejecutar = ejecutar_comando_fuente
#}}}

def ejecutar_comando_prueba(self, path, prueba): #{{{
    log.debug(_(u'ComandoPrueba.ejecutar(path=%s, prueba=%s)'), path,
        prueba.shortrepr())
    rmtree(path)
    os.mkdir(path)
    unzip(prueba.caso_de_prueba.archivos_entrada, path) # TODO try/except
    unzip(self.archivos_entrada, path) # TODO try/except
    comando_ejecutado = prueba.add_comando_ejecutado(self)
    # TODO ejecutar en chroot (path)
    comando_ejecutado.fin = datetime.now()
#    if no_anda_ejecucion: # TODO
#        comando_ejecutado.exito = False
#        comando_ejecutado.observaciones += 'No anduvo xxx' # TODO
#        if self.rechazar_si_falla:
#            entrega.exito = False
#        if self.terminar_si_falla: # TODO
#            raise ExecutionFailure(self) # TODO info de error
#    for archivo in self.archivos_salida:
#        pass # TODO hacer diff
#    if archivos_mal: # TODO
#        comando_ejecutado.exito = False
#        comando_ejecutado.observaciones += 'No anduvo xxx' # TODO
#        if self.rechazar_si_falla:
#            entrega.exito = False
#        if self.terminar_si_falla: # TODO
#            raise ExecutionFailure(comando=self) # TODO info de error
#    else:
#        comando_ejecutado.exito = True
#        comando_ejecutado.observaciones += 'xxx OK' # TODO
    comando_ejecutado.exito = True
    comando_ejecutado.observaciones += 'xxx OK' # TODO
ComandoPrueba.ejecutar = ejecutar_comando_prueba
#}}}

