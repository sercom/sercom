#!/usr/bin/python
# vim: set et sw=4 sts=4 encoding=utf-8 foldmethod=marker :

#{{{ TG config/hacks
import turbogears
import turbogears.database
turbogears.update_config(configfile="dev.cfg", modulename="sercom.config")
import turbogears.i18n
__builtins__._ = turbogears.i18n.plain_gettext # Nada de gettext lazy
#}}}

from sercom.tester import *
from sercom import model
from Queue import Queue
from os.path import join

q = Queue()

q.put(1)
#q.put(5)
q.put(None)

tester = Tester(name='pepe', path='var', home=join('home', 'sercom'), queue=q)

tester.run()

model.hub.rollback()
#model.hub.commit()

#model.hub.begin()
#model.Entrega.get(5).correcta = True
#model.hub.rollback()

