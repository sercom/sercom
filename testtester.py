#!/usr/bin/python
# vim: set et sw=4 sts=4 encoding=utf-8 foldmethod=marker :

#{{{ TG config/hacks
import turbogears
import turbogears.database
turbogears.update_config(configfile="dev.cfg", modulename="sercom.config")
import turbogears.i18n
__builtins__._ = turbogears.i18n.plain_gettext # Nada de gettext lazy
#}}}

from sercom.tester import Tester
from sercom.model import Entrega, hub
from os.path import join
from datetime import datetime
import time
import logging

log = logging.getLogger('sercom.tester')

class Queue(object):
    def __init__(self):
        self.go_on = True
    def get(self):
        while self.go_on:
            try:
                hub.begin()
                try:
                    e = Entrega.selectBy(inicio=None).orderBy(Entrega.q.fecha)[0]
                    e.inicio = datetime.now()
                finally:
                    hub.commit()
                return e.id
            except IndexError:
                log.debug(_(u'No hay entregas pendientes'))
                time.sleep(5) # TODO config?
            except Exception, e:
                if isinstance(e, SystemExit):
                    raise
                log.exception('Queue: ')
        return None

q = Queue()

tester = Tester(name='pepe', path='var', home=join('home', 'sercom'), queue=q)

tester.run()

