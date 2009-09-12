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
from sercom.backend.incomming_queue import ColaDeEntregas
from sercom.backend.context import ContextoEjecucion
from sercom.backend.tester import Tester
from sercom.backend.processing import UserInfo
from turbogears import config
from os.path import join



user_info = UserInfo(config.get('sercom.tester.user', 65534))
chroot_uid = config.get('sercom.tester.chroot.user', 65534)
obj = ColaDeEntregas()
cola = ColaDeEntregas()

chroot_origen = join('var','chroot')
chroot_destino = join('var','chroot_pepe')
home_en_chroot = join('home', 'sercom')
temp_folder = join('/tmp','sercom_pepe')
contexto = ContextoEjecucion(user_info, chroot_origen, chroot_destino, home_en_chroot, temp_folder, chroot_uid)
tester = Tester(contexto_ejecucion = contexto, queue=cola)
tester.run()

