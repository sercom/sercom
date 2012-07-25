from turbogears import controllers, identity, config, redirect, url
from sercom.presentation.utils.sessionhelper import SessionHelper
from sercom.model import Permiso
from sercom.domain.exceptions import *

class BaseController(controllers.Controller):
    def get_curso_actual(self):
        try:
            contexto = SessionHelper().get_contexto_usuario()
            return contexto.get_curso()
        except SinCursosDisponibles as e:
            if identity.has_permission(Permiso.admin):
                raise redirect(url('/curso/new'))
            else:
                raise redirect(url('/error/%s' % e))

    def set_curso_actual(self,curso):
        contexto = SessionHelper().get_contexto_usuario()
        contexto.set_curso(curso)

    def get_limite_paginado(self):
        if identity.current.user:
            return identity.current.user.paginador
        else:
            return int(config.get('items_por_pagina'))
