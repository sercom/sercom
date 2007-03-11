# vim: set et sw=4 sts=4 encoding=utf-8 foldmethod=marker:

from sercom.model import Entrega, CasoDePrueba
from sercom.model import TareaFuente, TareaPrueba, ComandoFuente, ComandoPrueba
from zipfile import ZipFile, BadZipfile
from cStringIO import StringIO
from shutil import rmtree
from datetime import datetime
from os.path import join
from turbogears import config
import subprocess as sp
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

def check_call(*popenargs, **kwargs): #{{{ XXX Python 2.5 forward-compatibility
    """Run command with arguments.  Wait for command to complete.  If
    the exit code was zero then return, otherwise raise
    CalledProcessError.  The CalledProcessError object will have the
    return code in the returncode attribute.
    ret = call(*popenargs, **kwargs)

    The arguments are the same as for the Popen constructor.  Example:

    check_call(["ls", "-l"])
    """
    retcode = sp.call(*popenargs, **kwargs)
    cmd = kwargs.get("args")
    if cmd is None:
        cmd = popenargs[0]
    if retcode:
        raise sp.CalledProcessError(retcode, cmd)
    return retcode
sp.check_call = check_call
#}}}

#{{{ Excepciones

class CalledProcessError(Exception): #{{{ XXX Python 2.5 forward-compatibility
    """This exception is raised when a process run by check_call() returns
    a non-zero exit status.  The exit status will be stored in the
    returncode attribute."""
    def __init__(self, returncode, cmd):
        self.returncode = returncode
        self.cmd = cmd
    def __str__(self):
        return ("Command '%s' returned non-zero exit status %d"
            % (self.cmd, self.returncode))
sp.CalledProcessError = CalledProcessError
#}}}

class Error(StandardError): pass

class ExecutionFailure(Error, RuntimeError): pass

class RsyncError(Error, EnvironmentError): pass

#}}}

def unzip(bytes, default_dst='.', specific_dst=dict()): # {{{
    """Descomprime un buffer de datos en formato ZIP.
    Los archivos se descomprimen en default_dst a menos que exista una entrada
    en specific_dst cuya clave sea el nombre de archivo a descomprimir, en
    cuyo caso, se descomprime usando como destino el valor de dicha clave.
    """
    log.debug(_(u'Intentando descomprimir'))
    if bytes is None:
        return
    zfile = ZipFile(StringIO(bytes), 'r')
    for f in zfile.namelist():
        dst = join(specific_dst.get(f, default_dst), f)
        if f.endswith(os.sep):
            log.debug(_(u'Creando directorio "%s" en "%s"'), f, dst)
            os.mkdir(dst)
        else:
            log.debug(_(u'Descomprimiendo archivo "%s" en "%s"'), f, dst)
            file(dst, 'w').write(zfile.read(f))
    zfile.close()
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
    def __init__(self, comando, chroot, cwd, close_stdin=False,
                 close_stdout=False, close_stderr=False):
        self.comando = comando
        self.chroot = chroot
        self.cwd = cwd
        self.close_stdin = close_stdin
        self.close_stdout = close_stdout
        self.close_stderr = close_stderr
        log.debug('Proceso segurizado: chroot=%s, cwd=%s, user=%s, cpu=%s, '
            'as=%sMiB, fsize=%sMiB, nofile=%s, nproc=%s, memlock=%s',
            self.chroot, self.cwd, self.uid, self.max_tiempo_cpu,
            self.max_memoria, self.max_tam_archivo, self.max_cant_archivos,
            self.max_cant_procesos, self.max_locks_memoria)
    def __getattr__(self, name):
        if getattr(self.comando, name) is not None:
            return getattr(self.comando, name)
        return config.get('sercom.tester.limits.' + name, self.default[name])
    def __call__(self):
        x2 = lambda x: (x, x)
        if self.close_stdin:
            os.close(0)
        if self.close_stdout:
            os.close(1)
        if self.close_stderr:
            os.close(2)
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

    @property
    def orig_chroot(self):
        return join(self.path, 'chroot')
    #}}}

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
            sp.check_call(rsync)
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
    comando_ejecutado = entrega.add_comando_ejecutado(self)
    unzip(self.archivos_entrada, path, # TODO try/except
        dict(__stdin__='/tmp/sercom.tester.%s.stdin' % comando_ejecutado.id)) # TODO /var/run/sercom
    options = dict(
        close_fds=True,
        shell=True,
        preexec_fn=SecureProcess(self, 'var/chroot_pepe', '/home/sercom/build')
    )
    if os.path.exists('/tmp/sercom.tester.%s.stdin' % comando_ejecutado.id): # TODO
        options['stdin'] = file('/tmp/sercom.tester.%s.stdin' % comando_ejecutado.id, 'r') # TODO
    else:
        options['preexec_fn'].close_stdin = True
    if self.guardar_stdouterr:
        options['stdout'] = file('/tmp/sercom.tester.%s.stdouterr'
            % comando_ejecutado.id, 'w') #TODO /var/run/sercom?
        options['stderr'] = sp.STDOUT
    else:
        if self.guardar_stdout:
            options['stdout'] = file('/tmp/sercom.tester.%s.stdout'
                % comando_ejecutado.id, 'w') #TODO /run/lib/sercom?
        else:
            options['preexec_fn'].close_stdout = True
        if self.guardar_stderr:
            options['stderr'] = file('/tmp/sercom.tester.%s.stderr'
                % comando_ejecutado.id, 'w') #TODO /var/run/sercom?
        else:
            options['preexec_fn'].close_stderr = True
    log.debug(_(u'Ejecutando como root: %s'), self.comando)
    os.seteuid(0) # Dios! (para chroot)
    os.setegid(0)
    try:
        try:
            proc = sp.Popen(self.comando, **options)
        finally:
            log.debug(_(u'Cambiando usuario y grupo efectivos a %s:%s (%s:%s)'),
                user_info.user, user_info.group, user_info.uid, user_info.gid)
            os.setegid(user_info.gid) # Mortal de nuevo
            os.seteuid(user_info.uid)
    except Exception, e:
        if hasattr(e, 'child_traceback'):
            log.error(_(u'Error en el hijo: %s'), e.child_traceback)
        raise
    proc.wait() #TODO un sleep grande nos caga todo, ver sercom viejo
    comando_ejecutado.fin = datetime.now()
    buffer = StringIO()
    zip = ZipFile(buffer, 'w')
    if self.guardar_stdouterr:
        zip.write('/tmp/sercom.tester.%s.stdouterr'
            % comando_ejecutado.id, '__stdouterr__')
    else:
        if self.guardar_stdout:
            azipwrite('/tmp/sercom.tester.%s.stdout'
                % comando_ejecutado.id, '__stdout__')
        if self.guardar_stderr:
            zip.write('/tmp/sercom.tester.%s.stderr'
                % comando_ejecutado.id, '__stderr__')
    zip.close()
    comando_ejecutado.archivos_guardados = buffer.getvalue()

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

