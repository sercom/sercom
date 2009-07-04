import sercom.model

class ContextoUsuario:
    def __init__(self, curso):
        self.curso_id = curso.id

    def get_curso(self):
        return sercom.model.Curso.get(self.curso_id);

    def set_curso(self, curso):
        self.curso_id = curso.id
