
from turbogears import url
from turbogears import controllers

class Menu:
    def __init__(self, controller):
        # Armo la lista de subcontrollers
        self.items = []
        for i in controller.__dict__:
            if isinstance(getattr(controller, i),controllers.Controller):
                self.items.append(i)
        self.items.sort()

    def __repr__(self):
        t = """
        <div id="navbar">
    			Ir a :
		    	<select OnChange="window.location=this.options[this.selectedIndex].value;">
    				%s
		    	</select>
    		</div>
        """
        s = ''
        for i in self.items:
            s = s + u"""<option value="%s">%s</option>" """ % (url('/' + i), i.capitalize().replace('_', ' '))
        return t % s

