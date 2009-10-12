# vim: set et sw=4 sts=4 encoding=utf-8 foldmethod=marker :

from turbogears import url
from turbogears.identity import SecureResource
from turbogears import identity

class Menu:
    def __init__(self, base):
        self.base = base
        self.items = [i for i in dir(base)
            if isinstance(getattr(base, i), SecureResource)]
        self.items.sort()
        self.items = ['dashboard'] + self.items

    def _check(self, c):
        if hasattr(c, 'menu_require'): return c.menu_require.eval_with_object(identity.current)
        return c.require.eval_with_object(identity.current)

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
        s = option % ('', '-----')
        for i in self.items:
            if i == 'dashboard' or self._check(getattr(self.base, i)):
                s += option % (url('/' + i), i.capitalize().replace('_', ' '))
        return template % s

