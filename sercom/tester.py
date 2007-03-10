# vim: set et sw=4 sts=4 encoding=utf-8 foldmethod=marker:

from sercom import model as mod
import zipfile as zf
import cStringIO as sio
import shutil as shu
import datetime as dt
from os import path as osp
import os

import logging
log = logging.getLogger('sercom.tester')

#from Queue import Queue
#queue = Queue()

class Error(StandardError): pass

class ExecutionFailure(Error, RuntimeError): pass

class RsyncError(Error, EnvironmentError): pass

error_interno = _(u'\n**Error interno al preparar la entrega.**')

def unzip(bytes, dst): # {{{
    log.debug(_(u'Intentando descomprimir en %s') % dst)
    if bytes is None:
        return
    zfile = zf.ZipFile(sio.StringIO(bytes), 'r')
    for f in zfile.namelist():
        if f.endswith(os.sep):
            log.debug(_(u'Creando directorio %s') % f)
            os.mkdir(osp.join(dst, f))
        else:
            log.debug(_(u'Descomprimiendo archivo %s') % f)
            file(osp.join(dst, f), 'w').write(zfile.read(f))
#}}}

class Tester(object): #{{{

    def __init__(self, name, path, home, queue): #{{{ y properties
        self.name = name
        self.path = path
        self.home = home
        self.queue = queue

    @property
    def build_path(self):
        return osp.join(self.chroot, self.home, 'build')

    @property
    def test_path(self):
        return osp.join(self.chroot, self.home, 'test')

    @property
    def chroot(self):
        return osp.join(self.path, 'chroot_' + self.name)
    #}}}

    @property
    def orig_chroot(self):
        return osp.join(self.path, 'chroot')

    def run(self): #{{{
        entrega_id = self.queue.get() # blocking
        while entrega_id is not None:
            entrega = mod.Entrega.get(entrega_id)
            log.debug(_(u'Nueva entrega para probar en tester %s: %s')
                % (self.name, entrega))
            self.test(entrega)
            log.debug(_(u'Fin de pruebas de: %s') % entrega)
            entrega_id = self.queue.get() # blocking
    #}}}

    def test(self, entrega): #{{{
        log.debug(_(u'Tester.test(entrega=%s)') % entrega)
        entrega.inicio_tareas = dt.datetime.now()
        try:
            try:
                self.setup_chroot(entrega)
                self.ejecutar_tareas_fuente(entrega)
                self.ejecutar_tareas_prueba(entrega)
                self.clean_chroot(entrega)
            except ExecutionFailure, e:
                entrega.correcta = False
                log.debug(_(u'Entrega incorrecta: %s') % entrega)
            except Exception, e:
                entrega.observaciones += error_interno
                log.exception(_(u'Hubo una excepción inesperada: %s') % e)
            except:
                entrega.observaciones += error_interno
                log.exception(_(u'Hubo una excepción inesperada desconocida'))
            else:
                entrega.correcta = True
                log.debug(_(u'Entrega correcta: %s') % entrega)
        finally:
            entrega.fin_tareas = dt.datetime.now()
    #}}}

    def setup_chroot(self, entrega): #{{{ y clean_chroot()
        log.debug(_(u'Tester.setup_chroot(entrega=%s)') % entrega)
        rsync = 'rsync --stats --itemize-changes --human-readable --archive ' \
            '--acls --delete-during --force' # TODO config
        orig_chroot = osp.join(self.orig_chroot, '')
        cmd = '%s %s %s' % (rsync, orig_chroot, self.chroot)
        log.debug(_(u'Ejecutando: %s') % cmd)
        ret = os.system(cmd)
        if ret != 0:
            entrega.observaciones += error_interno
            errstr = _(u'No se pudo hacer rsync al chroot para la prueba,' \
                u'falló el comando: %s (con código de error %d)') % (cmd, ret)
            log.error(errstr)
            raise RsyncError(errstr)
        try:
            unzip(entrega.archivos, self.build_path)
        except zf.BadZipfile:
            entrega.correcta = False
            entrega.observaciones += error_interno
            log.error(_(u'El archivo adjunto no está en formato ZIP'))
            raise
        except IOError, e:
            entrega.observaciones += error_interno
            log.error(_(u'Error de IO al descromprimir archivos del ZIP: %s')
                % e)
            raise

    def clean_chroot(self, entrega):
        log.debug(_(u'Tester.clean_chroot(entrega=%s)') % entrega)
        pass # Se limpia con el próximo rsync
    #}}}

    def ejecutar_tareas_fuente(self, entrega): #{{{ y tareas_prueba
        log.debug(_(u'Tester.ejecutar_tareas_fuente(entrega=%s)') % entrega)
        tareas = [t for t in entrega.instancia.ejercicio.enunciado.tareas
                    if isinstance(t, mod.TareaFuente)]
        for tarea in tareas:
            tarea.ejecutar(self.build_path, entrega)

    def ejecutar_tareas_prueba(self, entrega):
        log.debug(_(u'Tester.ejecutar_tareas_prueba(entrega=%s)') % entrega)
        for caso in entrega.instancia.ejercicio.enunciado.casos_de_prueba:
            caso.ejecutar(self.test_path, entrega)
    #}}}

#}}}

def ejecutar_caso_de_prueba(self, path, entrega): #{{{
    log.debug(_(u'CasoDePrueba.ejecutar(path=%s, entrega=%s)')
        % (path, entrega))
    tareas = [t for t in entrega.instancia.ejercicio.enunciado.tareas
                if isinstance(t, mod.TareaPrueba)]
    prueba = entrega.add_prueba(self)
    try:
        try:
            for tarea in tareas:
                tarea.ejecutar(path, prueba)
        except ExecutionFailure, e:
            prueba.pasada = False
            if self.rechazar_si_falla:
                entrega.exito = False
            if self.terminar_si_falla:
                raise ExecutionError(e.comando, e.tarea, prueba)
        else:
            prueba.pasada = True
    finally:
        prueba.fin = dt.datetime.now()
mod.CasoDePrueba.ejecutar = ejecutar_caso_de_prueba
#}}}

def ejecutar_tarea_fuente(self, path, entrega): #{{{
    log.debug(_(u'TareaFuente.ejecutar(path=%s, entrega=%s)') % (path, entrega))
    try:
        for cmd in self.comandos:
            cmd.ejecutar(path, entrega)
    except ExecutionFailure, e:
        if self.rechazar_si_falla:
            entrega.exito = False
        if self.terminar_si_falla:
            raise ExecutionError(e.comando, tarea)
mod.TareaFuente.ejecutar = ejecutar_tarea_fuente
#}}}

def ejecutar_tarea_prueba(self, path, prueba): #{{{
    log.debug(_(u'TareaPrueba.ejecutar(path=%s, prueba=%s)') % (path, prueba))
    try:
        for cmd in self.comandos:
            cmd.ejecutar(path, prueba)
    except ExecutionFailure, e:
        if self.rechazar_si_falla:
            prueba.exito = False
        if self.terminar_si_falla:
            raise ExecutionError(e.comando, tarea)
mod.TareaPrueba.ejecutar = ejecutar_tarea_prueba
#}}}

def ejecutar_comando_fuente(self, path, entrega): #{{{
    log.debug(_(u'ComandoFuente.ejecutar(path=%s, entrega=%s)')
        % (path, entrega))
    unzip(self.archivos_entrada, path) # TODO try/except
    comando_ejecutado = entrega.add_comando_ejecutado(self)
    # TODO ejecutar en chroot (path)
    comando_ejecutado.fin = dt.datetime.now()
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
mod.ComandoFuente.ejecutar = ejecutar_comando_fuente
#}}}

def ejecutar_comando_prueba(self, path, prueba): #{{{
    log.debug(_(u'ComandoPrueba.ejecutar(path=%s, prueba=%s)')
        % (path, prueba))
    shu.rmtree(path)
    os.mkdir(path)
    unzip(prueba.caso_de_prueba.archivos_entrada, path) # TODO try/except
    unzip(self.archivos_entrada, path) # TODO try/except
    comando_ejecutado = prueba.add_comando_ejecutado(self)
    # TODO ejecutar en chroot (path)
    comando_ejecutado.fin = dt.datetime.now()
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
mod.ComandoPrueba.ejecutar = ejecutar_comando_prueba
#}}}

