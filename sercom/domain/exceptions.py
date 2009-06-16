class UsuarioSinPermisos(Exception):
    def __init__(self, usuario):
        self.usuario = usuario
    def __str__(self):
        return "El usuario '%s' no tiene acceso al recurso solicitado." % self.usuario.nombre

class AlumnoSinEntregas(Exception):
    def __init__(self, alumno, instancia):
        self.alumno = alumno
        self.instancia = instancia

    def __str__(self):
        return "El alumno '%s' no posee entregas para la instancia '%s'" % (self.alumno, self.instancia)
