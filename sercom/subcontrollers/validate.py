# vim: set et sw=4 sts=4 encoding=utf-8 :

__all__ = ('validate_get', 'validate_set', 'validate_new')

from turbogears import redirect

def validate_get(cls, name, id, url='../list'):
    try:
        id = int(id)
    except ValueError:
        raise redirect(url, tg_flash=_(u'Identificador inválido: %s.') % id)
    try:
        return cls.get(id)
    except LookupError:
        raise redirect(url, tg_flash=_(u'No existe %s con identificador %d')
            % (name, id))

def validate_set(cls, name, id, data, url='../edit'):
    r = validate_get(cls, name, id)
    try:
        r.set(**data)
    except Exception, e:
        raise redirect('%s/%s' % (url, id), tg_flash=_(u'No se pudo ' \
            'modificar el %s (error: %s).') % (name, e), **data)

def validate_new(cls, name, data, url='new'):
    try:
        return cls(**data)
    except Exception, e:
        raise redirect(url, tg_flash=_(u'No se pudo crear el nuevo %s ' \
            '(error: %s).') % (name, e), **data)

