import turbogears
from nose import with_setup
from turbogears import testutil, identity, visit
from sercom.model import *
from sercom.controllers import Root
import datetime
import cherrypy

from turbogears import identity, visit
from sercom.model import Visita

turbogears.update_config(configfile='test.cfg', modulename='sercom.config')


cherrypy.root = Root() 

class BaseTestController(testutil.DBTest):
    def create_current_user(self):
        return Alumno(padron='12345', nombre = "nombre", password = "password")

    def setUp(self):
        testutil.DBTest.setUp(self)
        turbogears.startup.startTurboGears()
        self.test_user = self.create_current_user()
        testutil.set_identity_user(self.test_user)
        self.session = testutil.BrowsingSession()
        self.session.goto('/login?login_user=12345&login_password=password&login_submit=Login&forward_url=/')

    def tearDown(self):
        turbogears.startup.stopTurboGears()
        testutil.DBTest.tearDown(self)

    def goto(self,url):
        self.session.goto(url)
        return cherrypy.response.body[0].lower()

class TestDashboardController(BaseTestController):
    def create_current_user(self):
        a = BaseTestController.create_current_user(self)
        c = Curso(anio=2000, cuatrimestre=1, numero=1)
        c.add_alumno(a)
        return a

    def test_dashboard(self):
        response = self.goto('/dashboard')
        assert 'cpu' not in response 
        assert '<h1>dashboard</h1>' in response

    def test_admin_alumnos(self):
        response = self.goto('/alumno/list')
        assert 'Editar' not in response 
        assert 'credenciales' in response
    
    def test_admin_correcciones(self):
        response = self.goto('/correccion/mis_correcciones')
        assert 'Editar' not in response 
        assert 'credenciales' in response

    def test_admin_cursos(self):
        response = self.goto('/curso/list')
        assert 'Editar' not in response 
        assert 'credenciales' in response

    def test_admin_docentes(self):
        response = self.goto('/docente/list')
        assert 'Editar' not in response 
        assert 'credenciales' in response

    def test_admin_entregas(self):
        response = self.goto('/entregas/statistics')
        assert 'Forzar' not in response 
        assert 'credenciales' in response

    def test_admin_enunciados(self):
        response = self.goto('/enunciado/list')
        assert 'Editar' not in response 
        assert 'credenciales' in response

    def test_admin_examenes(self):
        response = self.goto('/examenes/list')
        assert 'Editar' not in response 
        assert 'credenciales' in response

    def test_admin_tareafuente(self):
        response = self.goto('/tarea_fuente/list')
        assert 'Editar' not in response 
        assert 'credenciales' in response

    def test_admin_tareaprueba(self):
        response = self.goto('/tarea_prueba/list')
        assert 'Editar' not in response 
        assert 'credenciales' in response

    def test_forzar_entrega(self):
        response = self.goto('/entregas/force_new')
        assert 'Forzar' not in response 
        assert 'credenciales' in response

