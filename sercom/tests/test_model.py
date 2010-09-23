from turbogears import testutil, database
from sercom.model import *


class TestCurso(testutil.DBTest):
    def test_creation(self):
        "Object creation should set the name"
        c = Curso(anio=2007, cuatrimestre=1, numero=1)
        assert c.anio == 2007
        assert c.cuatrimestre == 1
        assert c.numero == 1
        assert c.docentes == []
        assert c.alumnos == []
        assert c.grupos == []
        assert c.ejercicios == []


class TestAlumno(testutil.DBTest):
    def create_curso(self):
        return Curso(anio=2000, cuatrimestre=1, numero=1)

    def create_alumno(self): 
        return Alumno(padron='12345', nombre='nombre')

    def create_grupo(self, curso):
        return Grupo(nombre='grupo1', curso=curso)

    def create_alumno_con_curso(self):
        a = self.create_alumno()
        c = self.create_curso()
        c.add_alumno(a)
        return a

    def create_alumno_con_grupo(self):
        a = self.create_alumno_con_curso()
        c = a.cursos[0]
        g = self.create_grupo(c)
        g.add_miembro(a.get_inscripcion(c))
        return a

    def test_get_entregadores_con_inscripcion_en_curso_debe_retornar_inscripcion(self):
        a = self.create_alumno_con_curso()
        c = a.cursos[0]
        entregadores = a.get_entregadores(c)
        assert len(entregadores) == 1
        assert entregadores[0] == a.get_inscripcion(c)
 
    def test_get_entregadores_con_inscripcion_y_grupo_en_curso_debe_retornar_ambos(self):
        a = self.create_alumno_con_grupo()
        c = a.cursos[0]

        entregadores = a.get_entregadores(c)
        esperado = [a.get_inscripcion(c), a.get_grupos(c)[0]]
        assert len(entregadores) == 2
        assert set(entregadores) == set(esperado)
 
