from sercom.domain import *
from turbogears import identity, redirect, url
import cherrypy

class SessionHelper:
    def get_contexto_usuario(self):
        contexto = cherrypy.session.get('contexto_usuario', None)
        if not contexto:
            contexto = self._create_contexto_usuario_default()
            cherrypy.session['contexto_usuario'] = contexto
        return contexto

    def _create_contexto_usuario_default(self):
        curso = identity.current.user.get_curso_default()
        if not curso:
            raise SinCursosDisponibles()
        else:
            return ContextoUsuario(curso)
