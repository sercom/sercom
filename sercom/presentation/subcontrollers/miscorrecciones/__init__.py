# vim: set et sw=4 sts=4 encoding=utf-8 foldmethod=marker :

#{{{ Imports
import cherrypy
from turbogears import expose, redirect
from turbogears import validate, flash, error_handler
from turbogears import validators as V
from turbogears import widgets as W
from turbogears import identity
from turbogears import paginate
from turbogears import config
from docutils.core import publish_parts
from sercom.presentation.subcontrollers import validate as val
from sercom.model import Entrega, Correccion, Grupo, AlumnoInscripto
from sqlobject import *
from zipfile import ZipFile, BadZipfile
from cStringIO import StringIO
from sercom.presentation.controllers import BaseController


#}}}

#{{{ Configuración
cls = Correccion
name = 'correccion'
namepl = name + 'es'
#}}}

#{{{ Controlador
class MisCorreccionesController(BaseController, identity.SecureResource):
    """Basic model admin interface"""
    require = identity.has_permission('entregar')

    hide_to_admin = 1

    @expose()
    def default(self, tg_errors=None):
        """handle non exist urls"""
        raise redirect('list')

    @expose()
    def index(self):
        raise redirect('list')

    @expose(template='kid:%s.templates.list' % __name__)
    @paginate('records', limit=config.get('items_por_pagina'))
    def list(self):
        """List records in model"""
        # Grupos en los que el usuario formo parte
        m = [i.grupo.id for i in Grupo.selectByAlumno(identity.current.user)]
        try:
            entregador = identity.current.user.get_inscripcion(self.get_curso_actual())
            m.append(entregador.id)
        except:
            pass
        r = cls.select(IN(cls.q.entregadorID, m))
        return dict(records=r, name=name, namepl=namepl)

#}}}

