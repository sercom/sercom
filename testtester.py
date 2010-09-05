#!/usr/bin/python
# vim: set et sw=4 sts=4 encoding=utf-8 foldmethod=marker :

import sys
try:
    configfile = sys.argv[1]
except:
    configfile = 'dev.cfg'

#{{{ TG config/hacks
import turbogears
import turbogears.database
turbogears.update_config(configfile=configfile, modulename="sercom.config")
import turbogears.i18n
__builtins__._ = turbogears.i18n.plain_gettext # Nada de gettext lazy
#}}}
from sercom.domain.exceptions import ValorConfiguracionInvalido
from sercom.backend.incomming_queue import ColaDeEntregas
from sercom.backend.context import ContextoEjecucion
from sercom.backend.tester import Tester
from sercom.backend.processing import UserInfo
from turbogears import config
from os.path import join

import logging
log = logging.getLogger('sercom.tester')



def get_config(clave):
    valor = config.get(clave)
    if not valor:
        raise ValorConfiguracionInvalido(clave)
    else:
        return valor

log.info('Inicializando Tester v1.1')

cola = ColaDeEntregas()

user_info = UserInfo(get_config('sercom.tester.user'))
chroot_uid = get_config('sercom.tester.chroot.user')
chroot_origen = get_config('sercom.tester.chroot.source.dir')
chroot_destino = get_config('sercom.tester.chroot.target.dir')
home_en_chroot = get_config('sercom.tester.chroot.target.home.dir')
temp_folder = get_config('sercom.tester.temp.dir')

contexto = ContextoEjecucion(user_info, chroot_origen, chroot_destino, home_en_chroot, temp_folder, chroot_uid)
tester = Tester(contexto_ejecucion = contexto, queue=cola)
tester.run()

