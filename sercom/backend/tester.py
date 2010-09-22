# vim: set et sw=4 sts=4 encoding=utf-8 foldmethod=marker:

from sercom.model import Entrega, CasoDePrueba, Tarea, TareaFuente, TareaPrueba
from sercom.model import ComandoFuente, ComandoPrueba
from sercom.domain.exceptions import *
from sercom.ziputil import *
from zipfile import ZipFile
from difflib import unified_diff, HtmlDiff
from cStringIO import StringIO
from shutil import rmtree
from datetime import datetime
from os.path import join
from turbogears import config
import subprocess as sp
import resource as rsrc
import os, sys
import logging

log = logging.getLogger('sercom.tester')

error_interno = _(u'\n**Error interno al preparar la entrega.**')

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
#}}}


class Tester(object): #{{{
    def __init__(self, contexto_ejecucion, queue): #{{{ y properties
        self.contexto_ejecucion = contexto_ejecucion
        self.queue = queue
        # Ahora somos mortales (oid mortales)
        contexto_ejecucion.user_info.reset_permisos()
    #}}}

    def run(self): #{{{
        entrega_id = self.queue.get() # blocking
        while entrega_id is not None:
            Entrega._connection.expireAll()
            entrega = Entrega.get(entrega_id)
            log.debug(_(u'Nueva entrega para probar en: %s: %s'),
                self.contexto_ejecucion, entrega)
            self.test(entrega)
            log.debug(_(u'Fin de pruebas de: %s'), entrega)
            entrega_id = self.queue.get() # blocking
    #}}}

    def test(self, entrega): #{{{
        log.debug(_(u'Testeando entrega. %s'), entrega)
        entrega.inicio = datetime.now()
        try:
            try:
                self.contexto_ejecucion.setup()
                self.copiar_archivos_entrega(entrega)

                self.ejecutar_tareas_fuente(entrega)
                self.ejecutar_tareas_prueba(entrega)

                self.contexto_ejecucion.clean()
            except ExecutionFailure, e:
                pass
            except ExecutionFatalError, e:
                # Si llegó esta excepción las cosas se pusieron difíciles.
                # Pasamos a la próxima entrega para que no nos consuma el tiempo.
                log.exception(_('Se activó el sistema de protección de SERCOM backend. [%s]'), e)
            except Exception, e:
                if isinstance(e, SystemExit): raise
                entrega.observaciones += error_interno
                log.exception(_('Hubo una excepcion inesperada')) # FIXME encoding
            except:
                entrega.observaciones += error_interno
                log.exception(_('Hubo una excepcion inesperada desconocida')) # FIXME encoding
        finally:
            entrega.fin = datetime.now()
            if entrega.exito is None:
                entrega.exito = True
            if entrega.exito:
                log.info(_(u'Entrega correcta: %s'), entrega)
            else:
                log.info(_(u'Entrega incorrecta: %s'), entrega)
    #}}}

    def copiar_archivos_entrega(self, entrega):
        unzip(entrega.archivos, self.contexto_ejecucion.build_path)

    def ejecutar_tareas_fuente(self, entrega): #{{{ y tareas_prueba
        log.debug(_(u'Tester.ejecutar_tareas_fuente(entrega=%s)'),
            entrega)
        tareas = [t for t in entrega.instancia.ejercicio.enunciado.tareas
                    if isinstance(t, TareaFuente)]
        for tarea in tareas:
            tarea.ejecutar(entrega, self.contexto_ejecucion)

    def ejecutar_tareas_prueba(self, entrega):
        log.debug(_(u'Tester.ejecutar_tareas_prueba(entrega=%s)'),
            entrega)
        for caso in entrega.instancia.ejercicio.enunciado.casos_de_prueba:
            caso.ejecutar(entrega, self.contexto_ejecucion)
    #}}}

#}}}


