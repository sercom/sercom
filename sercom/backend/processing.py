from turbogears import config
import subprocess as sp
import resource as rsrc
import os, sys, pwd, grp
import logging

log = logging.getLogger('sercom.tester')

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

class SecureProcess(object): #{{{
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
                 close_stdout=False, close_stderr=False):
        self.comando = comando
        self.chroot = chroot
        self.working_dir = working_dir
        self.uid_ejecucion = uid_ejecucion
        self.close_stdin = close_stdin
        self.close_stdout = close_stdout
        self.close_stderr = close_stderr
        raise 1
        log.debug(_(u'Proceso segurizado: cmd=%s, chroot=%s, working_dir=%s, user=%s, cpu=%s, '
            u'as=%sMiB, fsize=%sMiB, nofile=%s, nproc=%s, memlock=%s <<[%s]>>'),
            self.comando, self.chroot, self.working_dir, self.uid_ejecucion, self.max_tiempo_cpu,
            self.max_memoria, self.max_tam_archivo, self.max_cant_archivos,
            self.max_cant_procesos, self.max_locks_memoria, comando.max_tiempo_cpu)
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
        # Tratamos de forzar un sync para que entre al sleep del padre FIXME
        import time
        time.sleep(0)
#}}}

