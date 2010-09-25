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

