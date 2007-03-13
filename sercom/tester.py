# vim: set et sw=4 sts=4 encoding=utf-8 foldmethod=marker:

from sercom.model import Entrega, CasoDePrueba, Tarea, TareaFuente, TareaPrueba
from sercom.model import ComandoFuente, ComandoPrueba
from difflib import unified_diff, HtmlDiff
from zipfile import ZipFile, BadZipfile
from cStringIO import StringIO
from shutil import rmtree
from datetime import datetime
from os.path import join
from turbogears import config
import subprocess as sp
import resource as rsrc
import os, sys, pwd, grp
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

class ExecutionFailure(Error, RuntimeError): #{{{
    def __init__(self, comando, tarea=None, caso_de_prueba=None):
        self.comando = comando
        self.tarea = tarea
        self.caso_de_prueba = caso_de_prueba
#}}}

#}}}

def unzip(bytes, default_dst='.', specific_dst=dict()): # {{{
    u"""Descomprime un buffer de datos en formato ZIP.
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
        log.debug(_(u'Proceso segurizado: chroot=%s, cwd=%s, user=%s, cpu=%s, '
            u'as=%sMiB, fsize=%sMiB, nofile=%s, nproc=%s, memlock=%s'),
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
        os.setegid(user_info.gid)
        os.seteuid(user_info.uid)
        log.debug(_(u'usuario y grupo efectivos cambiados a %s:%s (%s:%s)'),
            user_info.user, user_info.group, user_info.uid, user_info.gid)

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
        entrega.inicio = datetime.now()
        try:
            try:
                self.setup_chroot(entrega)
                self.ejecutar_tareas_fuente(entrega)
                self.ejecutar_tareas_prueba(entrega)
                self.clean_chroot(entrega)
            except ExecutionFailure, e:
                entrega.exito = False
                log.info(_(u'Entrega incorrecta: %s'), entrega)
            except Exception, e:
                if isinstance(e, SystemExit): raise
                entrega.observaciones += error_interno
                log.exception(_('Hubo una excepcion inesperada')) # FIXME encoding
            except:
                entrega.observaciones += error_interno
                log.exception(_('Hubo una excepcion inesperada desconocida')) # FIXME encoding
            else:
                entrega.exito = True
                log.debug(_(u'Entrega correcta: %s'), entrega)
        finally:
            entrega.fin = datetime.now()
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
            os.setegid(user_info.gid) # Mortal de nuevo
            os.seteuid(user_info.uid)
            log.debug(_(u'Usuario y grupo efectivos cambiados a %s:%s (%s:%s)'),
                user_info.user, user_info.group, user_info.uid, user_info.gid)
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
                raise ExecutionFailure(e.comando, e.tarea, self)
        else:
            prueba.exito = True
    finally:
        prueba.fin = datetime.now()
CasoDePrueba.ejecutar = ejecutar_caso_de_prueba
#}}}

def ejecutar_tarea(self, path, ejecucion): #{{{
    log.debug(_(u'Tarea.ejecutar(path=%s, ejecucion=%s)'), path,
        ejecucion.shortrepr())
    for cmd in self.comandos:
        cmd.ejecutar(path, ejecucion)
Tarea.ejecutar = ejecutar_tarea
#}}}

# TODO generalizar ejecutar_comando_xxxx!!!

def ejecutar_comando_fuente(self, path, entrega): #{{{
    log.debug(_(u'ComandoFuente.ejecutar(path=%s, entrega=%s)'), path,
        entrega.shortrepr())
    comando_ejecutado = entrega.add_comando_ejecutado(self) # TODO debería rodear solo la ejecución del comando
    basetmp = '/tmp/sercom.tester.fuente' # FIXME TODO /var/run/sercom?
    unzip(self.archivos_entrada, path, # TODO try/except
        {self.STDIN: '%s.%s.stdin' % (basetmp, comando_ejecutado.id)})
    options = dict(
        close_fds=True,
        shell=True,
        preexec_fn=SecureProcess(self, 'var/chroot_pepe', '/home/sercom/build') #FIXME!!! path
    )
    if os.path.exists('%s.%s.stdin' % (basetmp, comando_ejecutado.id)):
        options['stdin'] = file('%s.%s.stdin' % (basetmp, comando_ejecutado.id),
            'r')
    else:
        options['preexec_fn'].close_stdin = True
    a_guardar = set(self.archivos_a_guardar)
    if self.archivos_a_comparar:
        zip_a_comparar = ZipFile(StringIO(self.archivos_a_comparar), 'r')
        a_comparar = set(zip_a_comparar.namelist())
    else:
        zip_a_comparar = None
        a_comparar = frozenset()
    a_usar = frozenset(a_guardar | a_comparar)
    if self.STDOUTERR in a_usar:
        options['stdout'] = file('%s.%s.stdouterr' % (basetmp,
            comando_ejecutado.id), 'w')
        options['stderr'] = sp.STDOUT
    else:
        if self.STDOUT in a_usar:
            options['stdout'] = file('%s.%s.stdout' % (basetmp,
                comando_ejecutado.id), 'w')
        else:
            options['preexec_fn'].close_stdout = True
        if self.STDERR in a_usar:
            options['stderr'] = file('%s.%s.stderr' % (basetmp,
                comando_ejecutado.id), 'w')
        else:
            options['preexec_fn'].close_stderr = True
    log.debug(_(u'Ejecutando como root: %s'), self.comando)
    os.seteuid(0) # Dios! (para chroot)
    os.setegid(0)
    try:
        try:
            proc = sp.Popen(self.comando, **options)
        finally:
            os.setegid(user_info.gid) # Mortal de nuevo
            os.seteuid(user_info.uid)
            log.debug(_(u'Usuario y grupo efectivos cambiados a %s:%s (%s:%s)'),
                user_info.user, user_info.group, user_info.uid, user_info.gid)
    except Exception, e:
        if hasattr(e, 'child_traceback'):
            log.error(_(u'Error en el hijo: %s'), e.child_traceback)
        raise
    proc.wait() #TODO un sleep grande nos caga todo, ver sercom viejo
    comando_ejecutado.fin = datetime.now() # TODO debería rodear solo la ejecución del comando
    if self.retorno != self.RET_ANY:
        if self.retorno == self.RET_FAIL:
            if proc.returncode == 0:
                if self.rechazar_si_falla:
                    entrega.exito = False
                comando_ejecutado.exito = False
                comando_ejecutado.observaciones += _(u'Se esperaba que el '
                    u'programa termine con un error (código de retorno '
                    u'distinto de 0) pero terminó bien (código de retorno '
                    u'0).\n')
                log.debug(_(u'Se esperaba que el programa termine '
                    u'con un error (código de retorno distinto de 0) pero '
                    u'terminó bien (código de retorno 0).\n'))
        elif self.retorno != proc.returncode:
            if self.rechazar_si_falla:
                entrega.exito = False
            comando_ejecutado.exito = False
            if proc.returncode < 0:
                comando_ejecutado.observaciones += _(u'Se esperaba terminar '
                    u'con un código de retorno %s pero se obtuvo una señal %s '
                    u'(%s).\n') % (self.retorno, -proc.returncode,
                        -proc.returncode) # TODO poner con texto
                log.debug(_(u'Se esperaba terminar con un código '
                    u'de retorno %s pero se obtuvo una señal %s (%s).\n'),
                    self.retorno, -proc.returncode, -proc.returncode)
            else:
                comando_ejecutado.observaciones += _(u'Se esperaba terminar '
                    u'con un código de retorno %s pero se obtuvo %s.\n') \
                    % (self.retorno, proc.returncode)
                log.debug(_(u'Se esperaba terminar con un código de retorno '
                    u'%s pero se obtuvo %s.\n'), self.retorno, proc.returncode)
    if comando_ejecutado.exito is None:
        log.debug(_(u'Código de retorno OK'))
    if a_guardar:
        buffer = StringIO()
        zip = ZipFile(buffer, 'w')
        # Guardamos stdout/stderr
        if self.STDOUTERR in a_guardar:
            a_guardar.remove(self.STDOUTERR)
            zip.write('%s.%s.stdouterr' % (basetmp, comando_ejecutado.id),
                self.STDOUTERR)
        else:
            if self.STDOUT in a_guardar:
                a_guardar.remove(self.STDOUT)
                zip.write('%s.%s.stdout' % (basetmp, comando_ejecutado.id),
                    self.STDOUT)
            if self.STDERR in a_guardar:
                a_guardar.remove(self.STDERR)
                zip.write('%s.%s.stderr' % (basetmp, comando_ejecutado.id),
                    self.STDERR)
        # Guardamos otros
        for f in a_guardar:
            if not os.path.exists(join(path, f)):
                if self.rechazar_si_falla:
                    entrega.exito = False
                comando_ejecutado.exito = False
                comando_ejecutado.observaciones += _(u'Se esperaba un archivo '
                    u'"%s" para guardar pero no fue encontrado.\n') % f
                log.debug(_(u'Se esperaba un archivo "%s" para guardar pero '
                    u'no fue encontrado'), f)
            else:
                zip.write(join(path, f), f)
        zip.close()
        comando_ejecutado.archivos = buffer.getvalue()
    def diff(new, zip_in, zip_out, name, longname=None, origname='correcto',
             newname='entregado'):
        if longname is None:
            longname = name
        new = file(new, 'r').readlines()
        orig = zip_in.read(name).split('\n')
        udiff = ''.join(list(unified_diff(orig, new, fromfile=name+'.'+origname,
            tofile=name+'.'+newname)))
        if udiff:
            if self.rechazar_si_falla:
                entrega.exito = False
            comando_ejecutado.exito = False
            comando_ejecutado.observaciones += _(u'%s no coincide con lo '
                u'esperado (archivo "%s.diff").\n') % (longname, name)
            log.debug(_(u'%s no coincide con lo esperado (archivo "%s.diff")'),
                longname, name)
            htmldiff = HtmlDiff().make_file(orig, new,
                fromdesc=name+'.'+origname, todesc=name+'.'+newname,
                context=True, numlines=3)
            zip_out.writestr(name + '.diff', udiff)
            zip_out.writestr(name + '.diff.html', htmldiff)
            return True
        else:
            return False
    if a_comparar:
        buffer = StringIO()
        zip = ZipFile(buffer, 'w')
        # Comparamos stdout/stderr
        if self.STDOUTERR in a_comparar:
            a_comparar.remove(self.STDOUTERR)
            diff('%s.%s.stdouterr' % (basetmp, comando_ejecutado.id),
                zip_a_comparar, zip, self.STDOUTERR,
                _(u'La salida estándar y de error combinada'))
        else:
            if self.STDOUT in a_comparar:
                a_comparar.remove(self.STDOUT)
                diff('%s.%s.stdout' % (basetmp, comando_ejecutado.id),
                    zip_a_comparar, zip, self.STDOUT, _(u'La salida estándar'))
            if self.STDERR in a_comparar:
                a_comparar.remove(self.STDERR)
                diff('%s.%s.stderr' % (basetmp, comando_ejecutado.id),
                    zip_a_comparar, zip, self.STDERR, _(u'La salida de error'))
        # Comparamos otros
        for f in a_comparar:
            if not os.path.exists(join(path, f)):
                if self.rechazar_si_falla:
                    entrega.exito = False
                comando_ejecutado.exito = False
                comando_ejecutado.observaciones += _(u'Se esperaba un archivo '
                    u'"%s" para comparar pero no fue encontrado') % f
                log.debug(_(u'Se esperaba un archivo "%s" para comparar pero '
                    u'no fue encontrado'), f)
            else:
                diff(join(path, f), zip_a_comparar, zip, f)
        zip.close()
        comando_ejecutado.diferencias = buffer.getvalue()
    if comando_ejecutado.exito is None:
        comando_ejecutado.exito = True
    elif self.terminar_si_falla:
        raise ExecutionFailure(self)

ComandoFuente.ejecutar = ejecutar_comando_fuente
#}}}

def ejecutar_comando_prueba(self, path, prueba): #{{{
    # Diferencia con comando fuente: s/entrega/prueba/ y s/build/test/ en path
    # y setup/clean de test.
    log.debug(_(u'ComandoPrueba.ejecutar(path=%s, prueba=%s)'), path,
        prueba.shortrepr())
    comando_ejecutado = prueba.add_comando_ejecutado(self) # TODO debería rodear solo la ejecución del comando
    basetmp = '/tmp/sercom.tester.prueba' # FIXME TODO /var/run/sercom?
    #{{{ Código que solo va en ComandoPrueba (setup de directorio)
    rsync = ('rsync', '--stats', '--itemize-changes', '--human-readable',
        '--archive', '--acls', '--delete-during', '--force', # TODO config
        'var/chroot_pepe/home/sercom/build/', path) # FIXME!!!! path
    log.debug(_(u'Ejecutando como root: %s'), ' '.join(rsync))
    os.seteuid(0) # Dios! (para chroot)
    os.setegid(0)
    try:
        sp.check_call(rsync)
    finally:
        os.setegid(user_info.gid) # Mortal de nuevo
        os.seteuid(user_info.uid)
        log.debug(_(u'Usuario y grupo efectivos cambiados a %s:%s (%s:%s)'),
            user_info.user, user_info.group, user_info.uid, user_info.gid)
    unzip(prueba.caso_de_prueba.archivos_entrada, path, # TODO try/except
        {self.STDIN: '%s.%s.stdin' % (basetmp, comando_ejecutado.id)})
    #}}}
    unzip(self.archivos_entrada, path, # TODO try/except
        {self.STDIN: '%s.%s.stdin' % (basetmp, comando_ejecutado.id)})
    options = dict(
        close_fds=True,
        shell=True,
        preexec_fn=SecureProcess(self, 'var/chroot_pepe', '/home/sercom/test') # FIXME!!!! path
    )
    if os.path.exists('%s.%s.stdin' % (basetmp, comando_ejecutado.id)):
        options['stdin'] = file('%s.%s.stdin' % (basetmp, comando_ejecutado.id),
            'r')
    else:
        options['preexec_fn'].close_stdin = True
    a_guardar = set(self.archivos_a_guardar)
    if self.archivos_a_comparar:
        zip_a_comparar = ZipFile(StringIO(self.archivos_a_comparar), 'r')
        a_comparar = set(zip_a_comparar.namelist())
    else:
        zip_a_comparar = None
        a_comparar = frozenset()
    a_usar = frozenset(a_guardar | a_comparar)
    if self.STDOUTERR in a_usar:
        options['stdout'] = file('%s.%s.stdouterr' % (basetmp,
            comando_ejecutado.id), 'w')
        options['stderr'] = sp.STDOUT
    else:
        if self.STDOUT in a_usar:
            options['stdout'] = file('%s.%s.stdout' % (basetmp,
                comando_ejecutado.id), 'w')
        else:
            options['preexec_fn'].close_stdout = True
        if self.STDERR in a_usar:
            options['stderr'] = file('%s.%s.stderr' % (basetmp,
                comando_ejecutado.id), 'w')
        else:
            options['preexec_fn'].close_stderr = True
    log.debug(_(u'Ejecutando como root: %s'), self.comando)
    os.seteuid(0) # Dios! (para chroot)
    os.setegid(0)
    try:
        try:
            proc = sp.Popen(self.comando, **options)
        finally:
            os.setegid(user_info.gid) # Mortal de nuevo
            os.seteuid(user_info.uid)
            log.debug(_(u'Usuario y grupo efectivos cambiados a %s:%s (%s:%s)'),
                user_info.user, user_info.group, user_info.uid, user_info.gid)
    except Exception, e:
        if hasattr(e, 'child_traceback'):
            log.error(_(u'Error en el hijo: %s'), e.child_traceback)
        raise
    proc.wait() #TODO un sleep grande nos caga todo, ver sercom viejo
    comando_ejecutado.fin_tareas = datetime.now() # TODO debería rodear solo la ejecución del comando
    if self.retorno != self.RET_ANY:
        if self.retorno == self.RET_FAIL:
            if proc.returncode == 0:
                if self.rechazar_si_falla:
                    prueba.exito = False
                comando_ejecutado.exito = False
                comando_ejecutado.observaciones += _(u'Se esperaba que el '
                    u'programa termine con un error (código de retorno '
                    u'distinto de 0) pero terminó bien (código de retorno '
                    u'0).\n')
                log.debug(_(u'Se esperaba que el programa termine '
                    u'con un error (código de retorno distinto de 0) pero '
                    u'terminó bien (código de retorno 0).\n'))
        elif self.retorno != proc.returncode:
            if self.rechazar_si_falla:
                prueba.exito = False
            comando_ejecutado.exito = False
            if proc.returncode < 0:
                comando_ejecutado.observaciones += _(u'Se esperaba terminar '
                    u'con un código de retorno %s pero se obtuvo una señal %s '
                    u'(%s).\n') % (self.retorno, -proc.returncode,
                        -proc.returncode) # TODO poner con texto
                log.debug(_(u'Se esperaba terminar con un código '
                    u'de retorno %s pero se obtuvo una señal %s (%s).\n'),
                    self.retorno, -proc.returncode, -proc.returncode)
            else:
                comando_ejecutado.observaciones += _(u'Se esperaba terminar '
                    u'con un código de retorno %s pero se obtuvo %s.\n') \
                    % (self.retorno, proc.returncode)
                log.debug(_(u'Se esperaba terminar con un código de retorno '
                    u'%s pero se obtuvo %s.\n'), self.retorno, proc.returncode)
    if comando_ejecutado.exito is None:
        log.debug(_(u'Código de retorno OK'))
    if a_guardar:
        buffer = StringIO()
        zip = ZipFile(buffer, 'w')
        # Guardamos stdout/stderr
        if self.STDOUTERR in a_guardar:
            a_guardar.remove(self.STDOUTERR)
            zip.write('%s.%s.stdouterr' % (basetmp, comando_ejecutado.id),
                self.STDOUTERR)
        else:
            if self.STDOUT in a_guardar:
                a_guardar.remove(self.STDOUT)
                zip.write('%s.%s.stdout' % (basetmp, comando_ejecutado.id),
                    self.STDOUT)
            if self.STDERR in a_guardar:
                a_guardar.remove(self.STDERR)
                zip.write('%s.%s.stderr' % (basetmp, comando_ejecutado.id),
                    self.STDERR)
        # Guardamos otros
        for f in a_guardar:
            if not os.path.exists(join(path, f)):
                if self.rechazar_si_falla:
                    prueba.exito = False
                comando_ejecutado.exito = False
                comando_ejecutado.observaciones += _(u'Se esperaba un archivo '
                    u'"%s" para guardar pero no fue encontrado.\n') % f
                log.debug(_(u'Se esperaba un archivo "%s" para guardar pero '
                    u'no fue encontrado'), f)
            else:
                zip.write(join(path, f), f)
        zip.close()
        comando_ejecutado.archivos = buffer.getvalue()
    def diff(new, zip_in, zip_out, name, longname=None, origname='correcto',
             newname='entregado'):
        if longname is None:
            longname = name
        new = file(new, 'r').readlines()
        orig = zip_in.read(name).split('\n')
        udiff = ''.join(list(unified_diff(orig, new, fromfile=name+'.'+origname,
            tofile=name+'.'+newname)))
        if udiff:
            if self.rechazar_si_falla:
                prueba.exito = False
            comando_ejecutado.exito = False
            comando_ejecutado.observaciones += _(u'%s no coincide con lo '
                u'esperado (archivo "%s.diff").\n') % (longname, name)
            log.debug(_(u'%s no coincide con lo esperado (archivo "%s.diff")'),
                longname, name)
            htmldiff = HtmlDiff().make_file(orig, new,
                fromdesc=name+'.'+origname, todesc=name+'.'+newname,
                context=True, numlines=3)
            zip_out.writestr(name + '.diff', udiff)
            zip_out.writestr(name + '.diff.html', htmldiff)
            return True
        else:
            return False
    if a_comparar:
        buffer = StringIO()
        zip = ZipFile(buffer, 'w')
        # Comparamos stdout/stderr
        if self.STDOUTERR in a_comparar:
            a_comparar.remove(self.STDOUTERR)
            diff('%s.%s.stdouterr' % (basetmp, comando_ejecutado.id),
                zip_a_comparar, zip, self.STDOUTERR,
                _(u'La salida estándar y de error combinada'))
        else:
            if self.STDOUT in a_comparar:
                a_comparar.remove(self.STDOUT)
                diff('%s.%s.stdout' % (basetmp, comando_ejecutado.id),
                    zip_a_comparar, zip, self.STDOUT, _(u'La salida estándar'))
            if self.STDERR in a_comparar:
                a_comparar.remove(self.STDERR)
                diff('%s.%s.stderr' % (basetmp, comando_ejecutado.id),
                    zip_a_comparar, zip, self.STDERR, _(u'La salida de error'))
        # Comparamos otros
        for f in a_comparar:
            if not os.path.exists(join(path, f)):
                if self.rechazar_si_falla:
                    prueba.exito = False
                comando_ejecutado.exito = False
                comando_ejecutado.observaciones += _(u'Se esperaba un archivo '
                    u'"%s" para comparar pero no fue encontrado') % f
                log.debug(_(u'Se esperaba un archivo "%s" para comparar pero '
                    u'no fue encontrado'), f)
            else:
                diff(join(path, f), zip_a_comparar, zip, f)
        zip.close()
        comando_ejecutado.diferencias = buffer.getvalue()
    if comando_ejecutado.exito is None:
        comando_ejecutado.exito = True
    elif self.terminar_si_falla:
        raise ExecutionFailure(self)

ComandoPrueba.ejecutar = ejecutar_comando_prueba
#}}}

