from turbogears import controllers
from sercom.presentation.utils.sessionhelper import SessionHelper



class BaseController(controllers.Controller):
    def get_curso_actual(self):
        contexto = SessionHelper().get_contexto_usuario()
        return contexto.get_curso()

    def set_curso_actual(self,curso):
        contexto = SessionHelper().get_contexto_usuario()
        contexto.set_curso(curso)


