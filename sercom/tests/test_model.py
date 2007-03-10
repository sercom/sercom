# If your project uses a database, you can set up database tests
# similar to what you see below. Be sure to set the db_uri to
# an appropriate uri for your testing database. sqlite is a good
# choice for testing, because you can use an in-memory database
# which is very fast.

from turbogears import testutil, database
from sercom.model import Curso

database.set_db_uri("sqlite:///:memory:")

class TestCurso(testutil.DBTest):
    def get_model(self):
        return Curso
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

