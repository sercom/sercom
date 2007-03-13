# vim: set et sw=4 sts=4 encoding=utf-8 foldmethod=marker :

__all__ = ('validate_get', 'validate_set', 'validate_new')

from turbogears import redirect, flash
from cherrypy import NotFound
from sqlobject.dberrors import DuplicateEntryError
from sqlobject import SQLObjectNotFound

def validate_get(cls, name, id, url='../list'):
    try:
        id = int(id)
    except ValueError:
        raise NotFound
    try:
        return cls.get(id)
    except SQLObjectNotFound:
        raise NotFound

def validate_set(cls, name, id, data, url='../edit'):
    r = validate_get(cls, name, id)
    try:
        r.set(**data)
        return r
    except DuplicateEntryError, e:
        flash(_(u'No se pudo modificar el %s porque no es único (error: %s).')
            % (name, e))
        raise redirect('%s/%s' % (url, id), **data)
    except TypeError, e:
        flash(_(u'No se pudo modificar el %s porque falta un dato o es '
            u'inválido (error: %s).') % (name, e))
        raise redirect('%s/%s' % (url, id), **data)

def validate_new(cls, name, data, url='new'):
    try:
        return cls(**data)
    except DuplicateEntryError, e:
        flash(_(u'No se pudo crear el %s porque no es único (error: %s).')
            % (name, e))
        raise redirect(url, **data)
    except TypeError, e:
        flash(_(u'No se pudo crear el %s porque falta un dato o es '
            u'inválido (error: %s).') % (name, e))
        raise redirect(url, **data)

def validate_del(cls, name, id):
    try:
        id = int(id)
        r = validate_get(cls, name, id)
        r.destroySelf()
    except Exception, e:
        flash(_(u'No se pudo eliminar el %s: %s' % (name, e)))
        raise redirect('../list')

