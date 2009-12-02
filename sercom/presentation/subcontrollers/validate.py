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

#TODO deprecated tratar de cambiar por create_record
def validate_new(cls, name, data, error_url='list'):
    create_record(cls, name, data, None, error_url)

#TODO deprecated tratar de cambiar por delete_record
def validate_del(cls, name, id):
    try:
        id = int(id)
        r = validate_get(cls, name, id)
        r.destroySelf()
    except Exception, e:
        flash(_(u'No se pudo eliminar el %s: %s' % (name, e)))
        raise redirect('../list')

def update_record(cls, name, id, data, redirect_url, error_url):
    r = validate_get(cls, name, id)
    try:
        r.set(**data)
        flash(_(u'El %s fue actualizado.') % name)
        raise redirect(redirect_url)
    except DuplicateEntryError, e:
        flash(_(u'No se pudo modificar el %s porque no es único (error: %s).')
            % (name, e))
        raise redirect(error_url, **data)
    except TypeError, e:
        flash(_(u'No se pudo modificar el %s porque falta un dato o es '
            u'inválido (error: %s).') % (name, e))
        raise redirect(error_url, **data)

def create_record(cls, name, data, redirect_url, error_url):
    try:
        r = cls(**data)
    except DuplicateEntryError, e:
        flash(_(u'No se pudo crear el %s porque no es único (error: %s).')
            % (name, e))
        raise redirect(error_url, **data)
    except TypeError, e:
        flash(_(u'No se pudo crear el %s porque falta un dato o es '
            u'inválido (error: %s).') % (name, e))
        raise redirect(error_url, **data)
    except Exception, e:
        flash(_(u'No se pudo crear el %s: %s' % (name, e)))
        raise redirect(error_url, **data)
    # si no ocurrieron errores redirijo, no es necesario usar la variable r.
    if redirect_url:
        flash(_(u'Se creó un nuevo %s.' % name))
        raise redirect(redirect_url)

def delete_record(cls, name, id, redirect_url):
    try:
        id = int(id)
        r = validate_get(cls, name, id)
        r.destroySelf()
        flash(_(u'El %s fue eliminado permanentemente.') % name)
    except Exception, e:
        flash(_(u'No se pudo eliminar el %s: %s' % (name, e)))
    finally:
        raise redirect(redirect_url)


