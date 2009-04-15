# vim: set et sw=4 sts=4 encoding=utf-8 foldmethod=marker:

import os
import logging
from zipfile import ZipFile
from cStringIO import StringIO
from os import path

log = logging.getLogger('sercom.ziputil')

def unzip_filenames(bytes):
    if bytes:
        zip = ZipFile(StringIO(bytes), 'r')
        return zip.namelist()
    else:
        return []

def unzip_arch_interno(bytes, nombre_arch_interno):
    return ZipFile(StringIO(bytes), 'r').read(nombre_arch_interno)
 
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
        dst = specific_dst[f] if f in specific_dst else path.join(default_dst, f)
        if f.endswith(os.sep):
            log.debug(_(u'Creando directorio "%s" en "%s"'), f, dst)
            os.mkdir(dst)
        else:
            log.debug(_(u'Descomprimiendo archivo "%s" en "%s"'), f, dst)
            file(dst, 'w').write(zfile.read(f))
    zfile.close()

