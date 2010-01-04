from turbogears import identity
from sercom.model import Permiso

class IdentityRequireHasAny(identity.Predicate, identity.IdentityPredicateHelper):
    error_message = "Ninguno de los permisos requiridos fue encontrado"

    def __init__(self, *lista_permisos):
        self.lista_permisos = lista_permisos

    def eval_with_object(self, identity, errors = None):
        for permiso in self.lista_permisos:
            if permiso in identity.permissions:
                return True
        #else
        self.append_error_message(errors)
        return False

class IdentityRequireAnonymous(identity.Predicate, identity.IdentityPredicateHelper):
	def eval_with_object(self, identity, errors = None):
		return True


