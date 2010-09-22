# vim: set et sw=4 sts=4 encoding=utf-8 foldmethod=marker:

from context import *
from tester import *
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
import os, sys, pwd, grp
import logging

log = logging.getLogger('sercom.tester')


def ejecutar_caso_de_prueba(self, entrega, contexto_ejecucion): #{{{
    log.debug(_(u'CasoDePrueba.ejecutar(caso=%s, entrega=%s)'), self,
        entrega)
    if not self.activo:
        log.debug(_(u'Ignorando caso de prueba porque esta inactivo'))
        return
    tareas = [t for t in entrega.instancia.ejercicio.enunciado.tareas
                if isinstance(t, TareaPrueba)]
    prueba = entrega.add_prueba(self, inicio=datetime.now())
    try:
        try:
            for tarea in tareas:
                tarea.ejecutar(prueba, contexto_ejecucion)
        except ExecutionFailure, e:
            pass
        except ExecutionFatalError, e:
            e.entrega = entrega
            raise e # Al pasar...
    finally:
        prueba.fin = datetime.now()
        if prueba.exito is None:
            prueba.exito = True
    if not prueba.exito and self.rechazar_si_falla:
        entrega.exito = False
    if not prueba.exito and self.terminar_si_falla:
        raise ExecutionFailure(prueba)
CasoDePrueba.ejecutar = ejecutar_caso_de_prueba
#}}}

def ejecutar_tarea(self, ejecucion, contexto_ejecucion): #{{{
    log.debug(_(u'Tarea.ejecutar(ejecucion=%s)'), ejecucion)
    for cmd in self.comandos:
        cmd.ejecutar(ejecucion, contexto_ejecucion)
Tarea.ejecutar = ejecutar_tarea
#}}}

# TODO generalizar ejecutar_comando_xxxx!!!

def generar_diff_html(udiff_lines, orig, new, fromdesc, todesc):
    max_permitido = int(config.get('sercom.tester.max_cant_lineas_para_htmldiff','800'))
    if len(udiff_lines) > max_permitido:
        new = ['La cantidad de diferencias excede el máximo permitido para el formato HTML. Por favor, controle la versión plana.']
        orig = []
    htmldiff = HtmlDiff().make_file(orig, new,
                fromdesc=fromdesc, todesc=todesc,
                context=True, numlines=3)
    return htmldiff
 

def ejecutar_comando_fuente(self, entrega, contexto_ejecucion): #{{{
    path = contexto_ejecucion.build_path
    log.debug(_(u'ComandoFuente.ejecutar(path=%s, entrega=%s)'), path,
        entrega)
    if not self.activo:
        log.debug(_(u'Ignorando comando fuente porque esta inactivo'))
        return
    comando_ejecutado = entrega.add_comando_ejecutado(self)
    basetmp = contexto_ejecucion.build_temp_base_path
    unzip(self.archivos_entrada, path, # TODO try/except
        {self.STDIN: '%s.%s.stdin' % (basetmp, comando_ejecutado.id)})
    options = dict(
        close_fds=True,
        shell=True,
        preexec_fn=contexto_ejecucion.ejecutar_fuente(self)
    )
    if os.path.exists('%s.%s.stdin' % (basetmp, comando_ejecutado.id)):
        options['stdin'] = file('%s.%s.stdin' % (basetmp, comando_ejecutado.id),
            'r')
    else:
        options['preexec_fn'].close_stdin = True
    a_guardar = set(self.archivos_a_guardar)
    zip_a_comparar = Multizip(self.archivos_a_comparar)
    a_comparar = set(zip_a_comparar.namelist())
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
    comando = self.comando # FIXME tiene que diferenciarse de ComandoPrueba
    comando_ejecutado.inicio = datetime.now()
    log.debug(_(u'Ejecutando como root: %s'), comando)
    os.seteuid(0) # Dios! (para chroot)
    os.setegid(0)
    try:
        try:
            proc = sp.Popen(comando, **options)
        finally:
            contexto_ejecucion.user_info.reset_permisos() # Mortal de nuevo
    except Exception, e:
        if hasattr(e, 'child_traceback'):
            log.error(_(u'Error en el hijo: %s'), e.child_traceback)
        raise
    proc.wait() #TODO un sleep grande nos caga todo, ver sercom viejo
    comando_ejecutado.fin = datetime.now()
    retorno = self.retorno
    if retorno != self.RET_ANY:
        if retorno == self.RET_FAIL:
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
        elif retorno != proc.returncode:
            if self.rechazar_si_falla:
                entrega.exito = False
            comando_ejecutado.exito = False
            if proc.returncode < 0:
                comando_ejecutado.observaciones += _(u'Se esperaba terminar '
                    u'con un código de retorno %s pero se obtuvo una señal %s '
                    u'(%s).\n') % (retorno, -proc.returncode, -proc.returncode) # TODO poner con texto
                log.debug(_(u'Se esperaba terminar con un código '
                    u'de retorno %s pero se obtuvo una señal %s (%s).\n'),
                    retorno, -proc.returncode, -proc.returncode)
            else:
                comando_ejecutado.observaciones += _(u'Se esperaba terminar '
                    u'con un código de retorno %s pero se obtuvo %s.\n') \
                    % (retorno, proc.returncode)
                log.debug(_(u'Se esperaba terminar con un código de retorno '
                    u'%s pero se obtuvo %s.\n'), retorno, proc.returncode)
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
                zip.write(str(join(path, f)), str(f)) # FIXME encoding de unicode
        zip.close()
        comando_ejecutado.archivos = buffer.getvalue()
    def diff(new, zip_in, zip_out, name, longname=None, origname='correcto',
             newname='entregado'):
        if longname is None:
            longname = name
        new = file(new, 'r').readlines()
        orig = zip_in.read(name).splitlines(True)

        udiff_lines = list(unified_diff(orig, new, fromfile=name+'.'+origname,
            tofile=name+'.'+newname))
        udiff = ''.join(udiff_lines)
        if udiff:
            if self.rechazar_si_falla:
                entrega.exito = False
            comando_ejecutado.exito = False
            comando_ejecutado.observaciones += _(u'%s no coincide con lo '
                u'esperado (archivo "%s.diff").\n') % (longname, name)
            log.debug(_(u'%s no coincide con lo esperado (archivo "%s.diff")'),
                longname, name)
            htmldiff = generar_diff_html(udiff_lines, orig, new, name+'.'+origname, name+'.'+newname)

            zip_out.writestr(name + '.diff', udiff)
            zip_out.writestr(name + '.html', htmldiff)
            return True
        else:
            return False
    if a_comparar:
        condiff = False
        buffer = StringIO()
        zip = ZipFile(buffer, 'w')
        # Comparamos stdout/stderr
        if self.STDOUTERR in a_comparar:
            a_comparar.remove(self.STDOUTERR)
            condiff |= diff('%s.%s.stdouterr' % (basetmp, comando_ejecutado.id),
                zip_a_comparar, zip, self.STDOUTERR,
                _(u'La salida estándar y de error combinada'))
        else:
            if self.STDOUT in a_comparar:
                a_comparar.remove(self.STDOUT)
                condiff |= diff('%s.%s.stdout' % (basetmp, comando_ejecutado.id),
                    zip_a_comparar, zip, self.STDOUT, _(u'La salida estándar'))
            if self.STDERR in a_comparar:
                a_comparar.remove(self.STDERR)
                condiff |= diff('%s.%s.stderr' % (basetmp, comando_ejecutado.id),
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
                condiff |= diff(join(path, f), zip_a_comparar, zip, f)
        zip.close()
        if condiff:
            comando_ejecutado.diferencias = buffer.getvalue()
    if comando_ejecutado.exito is None:
        comando_ejecutado.exito = True
    elif self.terminar_si_falla:
        raise ExecutionFailure(self)

ComandoFuente.ejecutar = ejecutar_comando_fuente
#}}}

def ejecutar_comando_prueba(self, prueba, contexto_ejecucion): #{{{
    # Diferencia con comando fuente: s/entrega/prueba/ y s/build/test/ en path
    # y setup/clean de test.
    path = contexto_ejecucion.test_path
    path_origen = join(contexto_ejecucion.build_path, '') #agregamos un slash para incluir todos los archivos del dir indicado
    log.debug(_(u'ComandoPrueba.ejecutar(path=%s, prueba=%s)'), path,
        prueba)
    if not self.activo:
        log.debug(_(u'Ignorando comando prueba porque esta inactivo'))
        return
    caso_de_prueba = prueba.caso_de_prueba
    comando_ejecutado = prueba.add_comando_ejecutado(self)
    basetmp = contexto_ejecucion.test_temp_base_path
    #{{{ Código que solo va en ComandoPrueba (setup de directorio)
    rsync = ('rsync', '--stats', '--itemize-changes', '--human-readable',
        '--archive', '--acls', '--delete-during', '--force', # TODO config
        path_origen, path)
    log.debug(_(u'Ejecutando como root: %s'), ' '.join(rsync))
    os.seteuid(0) # Dios! (para chroot)
    os.setegid(0)
    try:
        sp.check_call(rsync)
    finally:
        contexto_ejecucion.user_info.reset_permisos() # Mortal de nuevo
    #}}}
    unzip(self.archivos_entrada, path, # TODO try/except
        {self.STDIN: '%s.%s.stdin' % (basetmp, comando_ejecutado.id)})
    unzip(caso_de_prueba.archivos_entrada, path, # TODO try/except     # FIXME Esto es propio de ComandoPrueba
        {self.STDIN: '%s.%s.stdin' % (basetmp, comando_ejecutado.id)}) # FIXME Esto es propio de ComandoPrueba
    options = dict(
        close_fds=True,
        shell=True,
        preexec_fn=contexto_ejecucion.ejecutar_test(self)
    )
    if os.path.exists('%s.%s.stdin' % (basetmp, comando_ejecutado.id)):
        options['stdin'] = file('%s.%s.stdin' % (basetmp, comando_ejecutado.id),
            'r')
    else:
        options['preexec_fn'].close_stdin = True
    a_guardar = set(self.archivos_a_guardar)
    a_guardar |= set(caso_de_prueba.archivos_a_guardar)           # FIXME Esto es propio de ComandoPrueba
    log.debug('archivos a guardar: %s', a_guardar)
    zip_a_comparar = Multizip(caso_de_prueba.archivos_a_comparar, # FIXME Esto es propio de ComandoPrueba
        self.archivos_a_comparar)                                 # FIXME Esto es propio de ComandoPrueba
    a_comparar = set(zip_a_comparar.namelist())
    log.debug('archivos a comparar: %s', a_comparar)
    a_usar = frozenset(a_guardar | a_comparar)
    log.debug('archivos a usar: %s', a_usar)
    if self.STDOUTERR in a_usar:
        options['stdout'] = file('%s.%s.stdouterr' % (basetmp,
            comando_ejecutado.id), 'w')
        options['stderr'] = sp.STDOUT
    else:
        if self.STDOUT in a_usar:
            log.debug('capurando salida en: %s.%s.stdout', basetmp, comando_ejecutado.id)
            options['stdout'] = file('%s.%s.stdout' % (basetmp,
                comando_ejecutado.id), 'w')
        else:
            options['preexec_fn'].close_stdout = True
        if self.STDERR in a_usar:
            options['stderr'] = file('%s.%s.stderr' % (basetmp,
                comando_ejecutado.id), 'w')
        else:
            options['preexec_fn'].close_stderr = True
    comando = self.comando + ' ' + caso_de_prueba.comando # FIXME Esto es propio de ComandoPrueba
    comando_ejecutado.inicio = datetime.now()
    log.debug(_(u'Ejecutando como root: %s'), comando)
    os.seteuid(0) # Dios! (para chroot)
    os.setegid(0)
    try:
        try:
            proc = sp.Popen(comando, **options)
        finally:
            contexto_ejecucion.user_info.reset_permisos() # Mortal de nuevo
    except Exception, e:
        if hasattr(e, 'child_traceback'):
            log.error(_(u'Error en el hijo: %s'), e.child_traceback)
        raise
    proc.wait() #TODO un sleep grande nos caga todo, ver sercom viejo
    comando_ejecutado.fin = datetime.now()
    retorno = self.retorno
    if retorno == self.RET_PRUEBA:                # FIXME Esto es propio de ComandoPrueba
        retorno = caso_de_prueba.retorno   # FIXME Esto es propio de ComandoPrueba
    if retorno != self.RET_ANY:
        if retorno == self.RET_FAIL:
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
        elif retorno != proc.returncode:
            if self.rechazar_si_falla:
                prueba.exito = False
            comando_ejecutado.exito = False
            if proc.returncode < 0:
                comando_ejecutado.observaciones += _(u'Se esperaba terminar '
                    u'con un código de retorno %s pero se obtuvo una señal %s '
                    u'(%s).\n') % (retorno, -proc.returncode, -proc.returncode) # TODO poner con texto
                log.debug(_(u'Se esperaba terminar con un código '
                    u'de retorno %s pero se obtuvo una señal %s (%s).\n'),
                    retorno, -proc.returncode, -proc.returncode)
            else:
                comando_ejecutado.observaciones += _(u'Se esperaba terminar '
                    u'con un código de retorno %s pero se obtuvo %s.\n') \
                    % (retorno, proc.returncode)
                log.debug(_(u'Se esperaba terminar con un código de retorno '
                    u'%s pero se obtuvo %s.\n'), retorno, proc.returncode)
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
                zip.write(str(join(path, f)), str(f)) # FIXME encoding de unicode
        zip.close()
        comando_ejecutado.archivos = buffer.getvalue()

    def diff(new, zip_in, zip_out, name, longname=None, origname='correcto',
             newname='entregado'):
        fatal = None
        if longname is None:
            longname = name
        try:
            new = file(new, 'r').readlines()
            orig = zip_in.read(name).splitlines(True)
            udiff_lines = list(unified_diff(orig, new, fromfile=name+'.'+origname,
                tofile=name+'.'+newname))
            udiff = ''.join(udiff_lines)
        except MemoryError:
            fatal = u'No se pudo procesar la salida por ser demasiado extensa. Posiblemente el programa entró en un lazo infinito.'
        except:
            fatal = u'Hubo un error inesperado procesando la salida.'

        # Si hay un error fatal cortamos tratando de notificarlo
        if fatal:
            prueba.exito = False
            comando_ejecutado.exito = False
            comando_ejecutado.observaciones += fatal
            log.debug(_(u'Error fatal: %s'), fatal)
            # Bueno, no sé por dónde empezar. Digamos que esta excepción
            # particularmente me permite cortar el flujo y que pase a la
            # próxima entrega. Buena suerte.
            raise ExecutionFatalError(self)

        if udiff:
            if self.rechazar_si_falla:
                prueba.exito = False
            comando_ejecutado.exito = False
            comando_ejecutado.observaciones += _(u'%s no coincide con lo '
                u'esperado (archivo "%s.diff").\n') % (longname, name)
            log.debug(_(u'%s no coincide con lo esperado (archivo "%s.diff")'),
                longname, name)
            htmldiff = generar_diff_html(udiff_lines, orig, new, name+'.'+origname, name+'.'+newname)
            zip_out.writestr(name + '.diff', udiff)
            zip_out.writestr(name + '.html', htmldiff)
            return True
        else:
            return False
    if a_comparar:
        condiff = False
        buffer = StringIO()
        zip = ZipFile(buffer, 'w')
        # Comparamos stdout/stderr
        if self.STDOUTERR in a_comparar:
            a_comparar.remove(self.STDOUTERR)
            condiff |= diff('%s.%s.stdouterr' % (basetmp, comando_ejecutado.id),
                zip_a_comparar, zip, self.STDOUTERR,
                _(u'La salida estándar y de error combinada'))
        else:
            if self.STDOUT in a_comparar:
                log.debug('comparando salida con: %s.%s.stdout', basetmp, comando_ejecutado.id)
                a_comparar.remove(self.STDOUT)
                condiff |= diff('%s.%s.stdout' % (basetmp, comando_ejecutado.id),
                    zip_a_comparar, zip, self.STDOUT, _(u'La salida estándar'))
            if self.STDERR in a_comparar:
                a_comparar.remove(self.STDERR)
                condiff |= diff('%s.%s.stderr' % (basetmp, comando_ejecutado.id),
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
                condiff |= diff(join(path, f), zip_a_comparar, zip, f)
        zip.close()
        if condiff:
            comando_ejecutado.diferencias = buffer.getvalue()
    if comando_ejecutado.exito is None:
        comando_ejecutado.exito = True
    elif self.terminar_si_falla:
        raise ExecutionFailure(self)

ComandoPrueba.ejecutar = ejecutar_comando_prueba
#}}}

