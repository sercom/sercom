#!/usr/bin/python
# vim: set et sw=4 sts=4 encoding=utf-8 foldmethod=marker :

import turbogears
import turbogears.database
turbogears.update_config(configfile="dev.cfg", modulename="sercom.config")
from sercom.tester import *
from sercom import model
from Queue import Queue

queue = Queue()

queue.put(1)
#queue.put(5)
queue.put(None)

tester = Tester(name='pepe', path='var', home=os.path.join('home', 'sercom'),
    queue=queue)

tester.run()

model.hub.rollback()
#model.hub.commit()

#model.hub.begin()
#model.Entrega.get(5).correcta = True
#model.hub.rollback()

