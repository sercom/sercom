
from turbogears import url
from turbogears.controllers import Controller

class Menu:
    def __init__(self, base):
        # Armo la lista de subcontrollers
        self.items = filter(lambda i: isinstance(getattr(base, i), Controller), base.__dict__)
        self.items.sort()

    def __repr__(self):
        option = u"""<option value="%s">%s</option>" """
        template = """
        <div id="navbar">
    			Ir a :
		    	<select OnChange="window.location=this.options[this.selectedIndex].value;">
    				%s
		    	</select>
    		</div>
        """
        s = ''
        for i in self.items:
            s + = option % (url('/' + i), i.capitalize().replace('_', ' '))
        return t % s

