# A JSON-based API(view) for your app.
# Most rules would look like:
# @jsonify.when("isinstance(obj, YourClass)")
# def jsonify_yourclass(obj):
#     return [obj.val1, obj.val2]
# @jsonify can convert your objects to following types:
# lists, dicts, numbers and strings

from turbojson.jsonify import jsonify #, jsonify_sqlobject
from sercom.model import SQLObject, Rol, Usuario, Permiso

#@jsonify.when('isinstance(obj, SQLObject')
def jsonify_sqlobject(obj):
    result = {}
    result['id'] = obj.id
    cls = obj.sqlmeta.soClass
    for name in cls.sqlmeta.columns.keys():
        if name != 'childName':
            result[name] = getattr(obj, name)
    while cls.sqlmeta.parentClass:
        cls = cls.sqlmeta.parentClass
        for name in cls.sqlmeta.columns.keys():
            if name != 'childName':
                result[name] = getattr(obj, name)
    return result

@jsonify.when('isinstance(obj, Rol)')
def jsonify_rol(obj):
    result = jsonify_sqlobject(obj)
    result["usuarios"] = [u.usuario for u in obj.usuarios]
    result["permisos"] = [p.nombre for p in obj.permisos]
    return result

@jsonify.when('isinstance(obj, Usuario)')
def jsonify_user(obj):
    result = jsonify_sqlobject(obj)
    del result['contrasenia']
    result["roles"] = [r.nombre for r in obj.roles]
    result["permisos"] = [p.nombre for p in obj.permisos]
    return result

@jsonify.when('isinstance(obj, Permiso)')
def jsonify_permission(obj):
    return dict(nombre=obj.nombre, descripcion=obj.descripcion)

