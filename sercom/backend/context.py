# vim: set et sw=4 sts=4 encoding=utf-8 foldmethod=marker:

from processing import *
import os
from os.path import join
import subprocess as sp
import logging

log = logging.getLogger('sercom.tester')


class ContextoEjecucion:
    def __init__(self, user_info, chroot_origen, chroot_destino, home_en_chroot, temp_folder, uid_ejecucion_comandos):
        self.user_info = user_info
        self.chroot_origen = chroot_origen
        self.chroot_destino = chroot_destino
        self.home_en_chroot = home_en_chroot
        self.uid_comandos = uid_ejecucion_comandos
        self.temp_folder = temp_folder

    @property
    def home_ejecucion(self):
        return join(self.chroot_destino, self.home_en_chroot)

    @property
    def build_path(self):
        return join(self.home_ejecucion, 'build')

    @property
    def test_path(self):
        return join(self.home_ejecucion, 'test')

    @property
    def build_temp_base_path(self):
        return join(self.temp_folder, 'fuente')

    @property
    def test_temp_base_path(self):
        return join(self.temp_folder, 'prueba')

    @property
    def build_path_en_chroot(self):
        return join('/',self.home_en_chroot, 'build')

    @property
    def test_path_en_chroot(self):
        return join('/',self.home_en_chroot, 'test')

    def setup(self): #{{{
        path_origen = join(self.chroot_origen, '') #agregamos un slash para incluir todo archivo a partir del directorio indicado
        path_destino = self.chroot_destino #no requiere cambios
        rsync = ('rsync', '--stats', '--itemize-changes', '--human-readable',
            '--archive', '--acls', '--delete-during', '--force',
            '--exclude', '/proc', '--exclude', '/sys',
            path_origen, path_destino)
        log.debug(_(u'Configurando ContextoEjecucion - Ejecutando como root: %s'), ' '.join(rsync))
        os.seteuid(0) # Dios! (para chroot)
        os.setegid(0)
        try:
            sp.check_call(rsync)
        finally:
            self.user_info.reset_permisos() # Mortal de nuevo

    def clean(self):
        pass # Se limpia con el próximo rsync
    #}}}

    def ejecutar_test(self,comando):
        return self.ejecutar(comando,self.test_path_en_chroot)

    def ejecutar_fuente(self, comando, caso):
        return self.ejecutar(comando, self.build_path_en_chroot, caso)

    def ejecutar(self,comando, working_dir, caso=None):
        return SecureProcess(comando, self.chroot_destino, working_dir, self.uid_comandos, False, False, False, caso)

    def __str__(self):
        return 'Contexto (Chroot:\'%s\' - Usr:%s)' % (self.chroot_destino, self.user_info)

