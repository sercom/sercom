from turbogears import config
import subprocess
import threading
import resource as rsrc
import os, sys, pwd, grp
import logging
import signal

log = logging.getLogger('sercom.tester')

class ProcessException(Exception):
    def __init__(self, msg):
        self.msg = msg
    def __str__(self):
        return self.msg

class UserInfo(object): #{{{
    def __init__(self, user):
        try:
            info = pwd.getpwnam(user)
        except:
            info = pwd.getpwuid(int(user))
        self.user = info[0]
        self.uid = info[2]
        self.gid = info[3]
        self.name = info[4]
        self.home = info[5]
        self.shell = info[6]
        self.group = grp.getgrgid(self.gid)[0]

    def reset_permisos(self):
        os.setegid(self.gid)
        os.seteuid(self.uid)
        log.debug(_(u'usuario y grupo efectivos cambiados a %s:%s (%s:%s)'),
            self.user, self.group, self.uid, self.gid)

    def __str__(self):
        return '%s (%s)' % (self.user, self.uid)

class SecureProcessPreexec(object): #{{{
    default = dict(
        max_tiempo_cpu      = 120,
        max_memoria         = 128,
        max_tam_archivo     = 5,
        max_cant_archivos   = 5,
        max_cant_procesos   = 0,
        max_locks_memoria   = 0,
    )

    MB = 1048576
    # XXX probar! make de un solo archivo lleva nproc=100 y nofile=15
    def __init__(self, comando, chroot, working_dir, uid_ejecucion, close_stdin=False,
                 close_stdout=False, close_stderr=False, caso_de_prueba=None):
        self.comando = comando
        self.chroot = chroot
        self.working_dir = working_dir
        self.uid_ejecucion = uid_ejecucion
        self.close_stdin = close_stdin
        self.close_stdout = close_stdout
        self.close_stderr = close_stderr
        self.caso_de_prueba = caso_de_prueba
        log.debug(_(u'Proceso segurizado: cmd=%s, chroot=%s, working_dir=%s, user=%s, cpu=%s, '
            u'as=%sMiB, fsize=%sMiB, nofile=%s, nproc=%s, memlock=%s'),
            self.comando, self.chroot, self.working_dir, self.uid_ejecucion, self.max_tiempo_cpu,
            self.max_memoria, self.max_tam_archivo, self.max_cant_archivos,
            self.max_cant_procesos, self.max_locks_memoria)
    def __getattr__(self, name):
        if self.caso_de_prueba is not None and getattr(self.caso_de_prueba, name) is not None:
            return getattr(self.caso_de_prueba, name)
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
        os.chdir(self.working_dir)
        user_info = UserInfo(self.uid_ejecucion)
#TODO chequear si no corresponde usar user_info.reset_permisos
        os.setgid(user_info.gid)
        os.setuid(user_info.uid) # Somos mortales irreversiblemente
        rsrc.setrlimit(rsrc.RLIMIT_CPU, x2(self.max_tiempo_cpu))
        rsrc.setrlimit(rsrc.RLIMIT_AS, x2(self.max_memoria*self.MB))
        rsrc.setrlimit(rsrc.RLIMIT_FSIZE, x2(self.max_tam_archivo*self.MB)) # XXX calcular en base a archivos esperados?
#        rsrc.setrlimit(rsrc.RLIMIT_NOFILE, x2(self.max_cant_archivos)) #XXX Obtener de archivos esperados?
        rsrc.setrlimit(rsrc.RLIMIT_NPROC, x2(self.max_cant_procesos))
        rsrc.setrlimit(rsrc.RLIMIT_MEMLOCK, x2(self.max_locks_memoria))
        rsrc.setrlimit(rsrc.RLIMIT_CORE, x2(0))
        os.setsid()
        # Tratamos de forzar un sync para que entre al sleep del padre FIXME
        # import time
        # time.sleep(0)
#}}}

class SecureProcess(object): #{{{
    def __init__(self, comando, options, timeout):
        self.comando = comando
        self.options = options
        self.timeout = timeout
        self.errormsg = None
        log.debug(_(u'Proceso segurizado: cmd=%s, timeout=%f'), (self.comando, self.timeout))
    def __call__(self):
        def target():
            try:
                log.debug(_(u'Iniciando proceso: %s'), self.comando)
                self.process = subprocess.Popen(self.comando, **self.options)
                self.process.communicate()
                log.debug(_(u'Proceso finalizado: %s'), self.comando)
            except Exception as e:  
                self.errormsg = 'Error inexperado durante la ejecucion del proceso'
                log.error(_(u'Ha ocurrido un error inexperado en el proceso. %s'), e)
        processThread = threading.Thread(target = target)
        processThread.start()
        log.debug(_(u'Esperando por la finalizacion del proceso. Timeout=%f'), self.timeout)
        processThread.join(self.timeout)
        if not self.errormsg and not processThread.is_alive():
            return self.process.returncode
        elif self.errormsg:
            raise ProcessException(self.errormsg)
        else:
            log.debug(u'El proceso aun esta vivo. Abortando proceso...')
            if self.process:
                # self.process.kill()
                os.killpg(self.process.pid, signal.SIGTERM)
            processThread.join()
            log.debug(u'Proceso abortado correctamente.')
            raise ProcessException('El proceso fue cancelado por exceso de tiempo.')
#}}}

