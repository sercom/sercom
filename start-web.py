#!/usr/share/turbogears/bin/python
# vim: set et sw=4 sts=4 encoding=utf-8 foldmethod=marker :

import locale
locale.setlocale(locale.LC_ALL, '')

import pkg_resources
pkg_resources.require("TurboGears>=1.5b2")

from turbogears import update_config, start_server
import cherrypy
cherrypy.lowercase_api = True
from os.path import *
import sys

if len(sys.argv) > 1:
    if exists(sys.argv[1]):
        update_config(configfile=sys.argv[1],modulename="sercom.config")
    else:
        raise Exception("The configuration file '%s' was not found." % sys.argv[1])
elif exists(join(dirname(__file__), "dev.cfg")):
    update_config(configfile="dev.cfg",modulename="sercom.config")
elif exists(join(dirname(__file__), "prod.cfg")):
    update_config(configfile="prod.cfg",modulename="sercom.config")
else:
    raise Exception("No configuration file found for the server")
from sercom.controllers import Root

start_server(Root())

