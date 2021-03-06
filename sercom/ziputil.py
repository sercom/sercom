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
    return ZipFile(StringIO(bytes), 'r').read(nombre_arch_interno).decode('utf8', 'replace')
 
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
        # sanitize the filename before unziping it
        if f.find('..') == -1 and not f.startswith('/'):
            dst = specific_dst[f] if f in specific_dst else path.join(default_dst, f)
            (dir, filename) = os.path.split(dst)
            if not os.path.isdir(dir):
                log.debug(_(u'Creando directorio "%s" en "%s"'), f, dst)
                os.makedirs(dir)
            if filename:
                log.debug(_(u'Descomprimiendo archivo "%s" en "%s"'), f, dst)
                file = open(dst, 'w')
                file.write(zfile.read(f))
                file.close()
            # else it was a folder
    zfile.close()


class Multizip(object): #{{{
    def __init__(self, *zip_streams):
        self.zips = [ZipFile(StringIO(z), 'r') for z in zip_streams
            if z is not None]
        self.names = set()
        for z in self.zips:
            self.names |= set(z.namelist())
    def read(self, name):
        for z in self.zips:
            try:
                return z.read(name)
            except KeyError:
                pass
        raise KeyError(name)
    def open(self, name):
        for z in self.zips:
            try:
                return z.open(name)
            except KeyError:
                pass
        raise KeyError(name)
    def getinfo(self, name):
        for z in self.zips:
            try:
                return z.getinfo(name)
            except KeyError:
                pass
        raise KeyError(name)
    def namelist(self):
        return self.names
#}}}
