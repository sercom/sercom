from sercom.model import Entrega, hub
from datetime import datetime
import time
import logging
log = logging.getLogger('sercom.tester')

class ColaDeEntregas(object):
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
                time.sleep(10) # TODO config?
            except Exception, e:
                if isinstance(e, SystemExit):
                    raise
                log.exception('Queue: ')
                time.sleep(10) # TODO config?
        return None

