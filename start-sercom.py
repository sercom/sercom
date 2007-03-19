#!/usr/bin/python
# vim: set et sw=4 sts=4 encoding=utf-8 foldmethod=marker :

import locale
locale.setlocale(locale.LC_ALL, '')

import pkg_resources
pkg_resources.require("TurboGears")

from turbogears import update_config, start_server
import cherrypy
cherrypy.lowercase_api = True
from os.path import *
import sys

# first look on the command line for a desired config file,
# if it's not on the command line, then
# look for setup.py in this directory. If it's not there, this script is
# probably installed
if len(sys.argv) > 1:
    update_config(configfile=sys.argv[1],
        modulename="sercom.config")
elif exists(join(dirname(__file__), "setup.py")):
    update_config(configfile="dev.cfg",modulename="sercom.config")
else:
    update_config(configfile="prod.cfg",modulename="sercom.config")

from sercom.model import InstanciaDeEntrega, Entrega, AND, hub
from sercom.finalizer import Finalizer
from threading import Thread
from datetime import datetime
import time
import logging

log = logging.getLogger('sercom.tester')

class Queue(object): #{{{
    def __init__(self):
        self.go_on = True
    def get(self):
        while self.go_on:
            try:
                hub.begin()
                try:
                    select = InstanciaDeEntrega.select(AND(
                        InstanciaDeEntrega.q.inicio_proceso == None,
                        InstanciaDeEntrega.q.fin <= datetime.now()))
                    instancia = select.orderBy(InstanciaDeEntrega.q.fin)[0]
                    n = Entrega.selectBy(instancia=instancia, fin=None).count()
                    if n:
                        log.debug(_(u'Esperando para procesar instancia (%s), '
                            'faltan probar %s entregas'), instancia.shortrepr(),
                            n)
                        time.sleep(30)
                        continue
                    instancia.inicio_proceso = datetime.now()
                finally:
                    hub.commit()
                return instancia.id
            except IndexError:
                log.debug(_(u'No hay instancias de entrega sin finalizar'))
                time.sleep(30) # TODO config?
            except Exception, e:
                if isinstance(e, SystemExit):
                    raise
                log.exception('Queue: ')
                time.sleep(30) # TODO config?
        return None
#}}}

#q = Queue()
#finalizer = Finalizer(name='juanca', queue=q)
#t = Thread(name='juanca', target=finalizer.run)
#t.start()

from sercom.controllers import Root

start_server(Root())

