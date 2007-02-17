# vim: set et sw=4 sts=4 encoding=utf-8 :

__all__ = ('validate_get', 'validate_set', 'validate_new')

from turbogears import redirect, flash
from cherrypy import NotFound

def validate_get(cls, name, id, url='../list'):
    try:
        return cls.get(int(id))
    except (ValueError, LookupError):
        raise NotFound

def validate_set(cls, name, id, data, url='../edit'):
    r = validate_get(cls, name, id)
    try:
        r.set(**data)
    except Exception, e:
        flash(_(u'No se pudo modificar el %s (error: %s).') % (name, e))
        raise redirect('%s/%s' % (url, id), **data)

def validate_new(cls, name, data, url='new'):
    try:
        return cls(**data)
    except Exception, e:
        flash(_(u'No se pudo crear el nuevo %s (error: %s).') % (name, e))
        raise redirect(url, **data)

