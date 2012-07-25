
class Error(StandardError): pass

class ExecutionFailure(Error, RuntimeError): #{{{
    def __init__(self, comando, tarea=None, caso_de_prueba=None):
        self.comando = comando
        self.tarea = tarea
        self.caso_de_prueba = caso_de_prueba
#}}}

class ExecutionFatalError(Error, RuntimeError): #{{{
    def __init__(self, comando, descripcion):
        self.comando = comando
        self.descripcion = descripcion
    def __str__(self):
        return "Error fatal: %s" % self.descripcion
#}}}

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

class ValorConfiguracionInvalido(Exception):
    def __init__(self,clave):
        self.clave = clave

    def __str__(self):
        return "No se encuentra la configuracion para la clave '%s'." % self.clave

class SinCursosDisponibles(Exception):
    def __str__(self):
        return "No se han encontrado cursos disponibles.";

