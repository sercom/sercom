# vim: set et sw=4 sts=4 encoding=utf-8 :

from datetime import datetime
from turbogears.database import PackageHub
from sqlobject import *
from sqlobject.sqlbuilder import *
from sqlobject.inheritance import InheritableSQLObject
from sqlobject.col import PickleValidator, UnicodeStringValidator
from turbogears import identity
from turbogears.identity import encrypt_password as encryptpw
from sercom.validators import params_to_list, ParseError
from formencode import Invalid

hub = PackageHub("sercom")
__connection__ = hub

__all__ = ('Curso', 'Usuario', 'Docente', 'Alumno', 'Tarea', 'CasoDePrueba')

#{{{ Custom Columns

class TupleValidator(PickleValidator):
    """
    Validator for tuple types.  A tuple type is simply a pickle type
    that validates that the represented type is a tuple.
    """
    def to_python(self, value, state):
        value = super(TupleValidator, self).to_python(value, state)
        if value is None:
            return None
        if isinstance(value, tuple):
            return value
        raise Invalid("expected a tuple in the TupleCol '%s', got %s %r instead" % \
            (self.name, type(value), value), value, state)
    def from_python(self, value, state):
        if value is None:
            return None
        if not isinstance(value, tuple):
            raise Invalid("expected a tuple in the TupleCol '%s', got %s %r instead" % \
                (self.name, type(value), value), value, state)
        return super(TupleValidator, self).from_python(value, state)

class SOTupleCol(SOPickleCol):
    def createValidators(self):
        return [TupleValidator(name=self.name)] \
            + super(SOPickleCol, self).createValidators()

class TupleCol(PickleCol):
    baseClass = SOTupleCol

class ParamsValidator(UnicodeStringValidator):
    def to_python(self, value, state):
        if isinstance(value, basestring):
            value = super(ParamsValidator, self).to_python(value, state)
            try:
                value = params_to_list(value)
            except ParseError, e:
                raise Invalid("invalid parameters in the ParamsCol '%s', parse "
                    "error: %s" % (self.name, e), value, state)
        elif not isinstance(value, (list, tuple)):
            raise Invalid("expected a tuple, list or valid string in the "
                "ParamsCol '%s', got %s %r instead"
                    % (self.name, type(value), value), value, state)
        return value
    def from_python(self, value, state):
        if isinstance(value, (list, tuple)):
            value = ' '.join([repr(p) for p in value])
        elif isinstance(value, basestring):
            value = super(ParamsValidator, self).to_python(value, state)
            try:
                params_to_list(value)
            except ParseError, e:
                raise Invalid("invalid parameters in the ParamsCol '%s', parse "
                    "error: %s" % (self.name, e), value, state)
        else:
            raise Invalid("expected a tuple, list or valid string in the "
                "ParamsCol '%s', got %s %r instead"
                    % (self.name, type(value), value), value, state)
        return value

class SOParamsCol(SOUnicodeCol):
    def createValidators(self):
        return [ParamsValidator(db_encoding=self.dbEncoding, name=self.name)] \
            + super(SOParamsCol, self).createValidators()

class ParamsCol(UnicodeCol):
    baseClass = SOParamsCol

#}}}

#{{{ Tablas intermedias

# BUG en SQLObject, SQLExpression no tiene cálculo de hash pero se usa como
# key de un dict. Workarround hasta que lo arreglen.
SQLExpression.__hash__ = lambda self: hash(str(self))

instancia_tarea_t = table.instancia_tarea

enunciado_tarea_t = table.enunciado_tarea

dependencia_t = table.dependencia

#}}}

#{{{ Clases

def srepr(obj): #{{{
    if obj is not None:
        return obj.shortrepr()
    return obj
#}}}

class ByObject(object): #{{{
    @classmethod
    def by(cls, **kw):
        try:
            return cls.selectBy(**kw)[0]
        except IndexError:
            raise SQLObjectNotFound, "The object %s with columns %s does not exist" % (cls.__name__, kw)
#}}}

class Curso(SQLObject, ByObject): #{{{
    # Clave
    anio            = IntCol(notNone=True)
    cuatrimestre    = IntCol(notNone=True)
    numero          = IntCol(notNone=True)
    pk              = DatabaseIndex(anio, cuatrimestre, numero, unique=True)
    # Campos
    descripcion     = UnicodeCol(length=255, default=None)
    # Joins
    docentes        = MultipleJoin('DocenteInscripto')
    alumnos         = MultipleJoin('AlumnoInscripto')
    grupos          = MultipleJoin('Grupo')
    ejercicios      = MultipleJoin('Ejercicio', orderBy='numero')

    def __init__(self, anio=None, cuatrimestre=None, numero=None,
            descripcion=None, docentes=[], ejercicios=[], **kargs):
        SQLObject.__init__(self, anio=anio, cuatrimestre=cuatrimestre,
            numero=numero, descripcion=descripcion, **kargs)
        for d in docentes:
            self.add_docente(d)
        for (n, e) in enumerate(ejercicios):
            self.add_ejercicio(n, e)

    def add_docente(self, docente, *args, **kargs):
        return DocenteInscripto(self, docente, *args, **kargs)

    def add_alumno(self, alumno, *args, **kargs):
        return AlumnoInscripto(self, alumno, *args, **kargs)

    def add_grupo(self, nombre, *args, **kargs):
        return Grupo(self, unicode(nombre), *args, **kargs)

    def add_ejercicio(self, numero, enunciado, *args, **kargs):
        return Ejercicio(self, numero, enunciado, *args, **kargs)

    def __repr__(self):
        return 'Curso(id=%s, anio=%s, cuatrimestre=%s, numero=%s, ' \
            'descripcion=%s)' \
                % (self.id, self.anio, self.cuatrimestre, self.numero,
                    self.descripcion)

    def shortrepr(self):
        return '%s.%s.%s' \
            % (self.anio, self.cuatrimestre, self.numero)
#}}}

class Usuario(InheritableSQLObject, ByObject): #{{{
    # Clave (para docentes puede ser un nombre de usuario arbitrario)
    usuario         = UnicodeCol(length=10, alternateID=True)
    # Campos
    contrasenia     = UnicodeCol(length=255, default=None)
    nombre          = UnicodeCol(length=255, notNone=True)
    email           = UnicodeCol(length=255, default=None)
    telefono        = UnicodeCol(length=255, default=None)
    creado          = DateTimeCol(notNone=True, default=DateTimeCol.now)
    observaciones   = UnicodeCol(default=None)
    activo          = BoolCol(notNone=True, default=True)
    # Joins
    roles           = RelatedJoin('Rol')

    def _get_user_name(self): # para identity
        return self.usuario

    @classmethod
    def by_user_name(cls, user_name): # para identity
        user = cls.byUsuario(user_name)
        if not user.activo:
            raise SQLObjectNotFound, "The object %s with user_name %s is " \
                "not active" % (cls.__name__, user_name)
        return user

    def _get_groups(self): # para identity
        return self.roles

    def _get_permissions(self): # para identity
        perms = set()
        for r in self.roles:
            perms.update(r.permisos)
        return perms

    _get_permisos = _get_permissions

    def _set_password(self, cleartext_password): # para identity
        self.contrasenia = encryptpw(cleartext_password)

    def _get_password(self): # para identity
        return self.contrasenia

    def __repr__(self):
        raise NotImplementedError, 'Clase abstracta!'

    def shortrepr(self):
        return '%s (%s)' % (self.usuario, self.nombre)
#}}}

class Docente(Usuario): #{{{
    _inheritable = False
    # Campos
    nombrado        = BoolCol(notNone=True, default=True)
    # Joins
    enunciados      = MultipleJoin('Enunciado', joinColumn='autor_id')
    inscripciones   = MultipleJoin('DocenteInscripto')

    def __init__(self, usuario=None, nombre=None, password=None, email=None,
            telefono=None, nombrado=True, activo=False, observaciones=None,
            roles=[], **kargs):
        passwd = password and encryptpw(password)
        InheritableSQLObject.__init__(self, usuario=usuario, nombre=nombre,
            contrasenia=passwd, email=email, telefono=telefono,
            nombrado=nombrado, activo=activo, observaciones=observaciones,
            **kargs)
        for r in roles:
            self.addRol(r)

    def add_entrega(self, instancia, *args, **kargs):
        return Entrega(instancia, *args, **kargs)

    def add_enunciado(self, nombre, *args, **kargs):
        return Enunciado(nombre, self, *args, **kargs)

    def __repr__(self):
        return 'Docente(id=%s, usuario=%s, nombre=%s, password=%s, email=%s, ' \
            'telefono=%s, activo=%s, creado=%s, observaciones=%s)' \
                % (self.id, self.usuario, self.nombre, self.password,
                    self.email, self.telefono, self.activo, self.creado,
                    self.observaciones)
#}}}

class Alumno(Usuario): #{{{
    _inheritable = False
    # Campos
    nota            = DecimalCol(size=3, precision=1, default=None)
    # Joins
    inscripciones   = MultipleJoin('AlumnoInscripto')

    def __init__(self, padron=None, nombre=None, password=None, email=None,
            telefono=None, activo=False, observaciones=None, roles=[], **kargs):
        passwd = password and encryptpw(password)
        InheritableSQLObject.__init__(self, usuario=padron, nombre=nombre,
            email=email, contrasenia=passwd, telefono=telefono, activo=activo,
            observaciones=observaciones, **kargs)
        for r in roles:
            self.addRol(r)

    def _get_padron(self): # alias para poder referirse al alumno por padron
        return self.usuario

    def _set_padron(self, padron):
        self.usuario = padron

    def __repr__(self):
        return 'Alumno(id=%s, padron=%s, nombre=%s, password=%s, email=%s, ' \
            'telefono=%s, activo=%s, creado=%s, observaciones=%s)' \
                % (self.id, self.padron, self.nombre, self.password, self.email,
                    self.telefono, self.activo, self.creado, self.observaciones)
#}}}

class Tarea(InheritableSQLObject, ByObject): #{{{
    # Clave
    nombre          = UnicodeCol(length=30, alternateID=True)
    # Campos
    descripcion     = UnicodeCol(length=255, default=None)
    # Joins

    def __init__(self, nombre=None, descripcion=None, dependencias=(), **kargs):
        InheritableSQLObject.__init__(self, nombre=nombre,
            descripcion=descripcion, **kargs)
        if dependencias:
            self.dependencias = dependencias

    def _get_dependencias(self):
        OtherTarea = Alias(Tarea, 'other_tarea')
        self.__dependencias = tuple(Tarea.select(
            AND(
                Tarea.q.id == dependencia_t.hijo_id,
                OtherTarea.q.id == dependencia_t.padre_id,
                self.id == dependencia_t.padre_id,
            ),
            clauseTables=(dependencia_t,),
            orderBy=dependencia_t.orden,
        ))
        return self.__dependencias

    def _set_dependencias(self, dependencias):
        orden = {}
        for i, t in enumerate(dependencias):
            orden[t.id] = i
        new = frozenset([t.id for t in dependencias])
        old = frozenset([t.id for t in self.dependencias])
        dependencias = dict([(t.id, t) for t in dependencias])
        for tid in old - new: # eliminadas
            self._connection.query(str(Delete(dependencia_t, where=AND(
                dependencia_t.padre_id == self.id,
                dependencia_t.hijo_id == tid))))
        for tid in new - old: # creadas
            self._connection.query(str(Insert(dependencia_t, values=dict(
                padre_id=self.id, hijo_id=tid, orden=orden[tid]
            ))))
        for tid in new & old: # actualizados
            self._connection.query(str(Update(dependencia_t,
                values=dict(orden=orden[tid]), where=AND(
                    dependencia_t.padre_id == self.id,
                    dependencia_t.hijo_id == tid,
                ))))

    def __repr__(self):
        return 'Tarea(id=%s, nombre=%s, descripcion=%s)' \
                % (self.id, self.nombre, self.descripcion)

    def shortrepr(self):
        return self.nombre
#}}}

class Enunciado(SQLObject, ByObject): #{{{
    # Clave
    nombre          = UnicodeCol(length=60, alternateID=True)
    cuatrimestre    = IntCol(notNone=True)
    numero          = IntCol(notNone=True)
    # Campos
    autor           = ForeignKey('Docente')
    descripcion     = UnicodeCol(length=255, default=None)
    creado          = DateTimeCol(notNone=True, default=DateTimeCol.now)
    archivo         = BLOBCol(default=None)
    archivo_name    = UnicodeCol(length=255, default=None)
    archivo_type    = UnicodeCol(length=255, default=None)
    # Joins
    ejercicios      = MultipleJoin('Ejercicio')
    casos_de_prueba = MultipleJoin('CasoDePrueba')

    def __init__(self, nombre=None, autor=None, descripcion=None, tareas=(),
            **kargs):
        SQLObject.__init__(self, nombre=nombre, autorID=autor and autor.id,
            descripcion=descripcion, **kargs)
        if tareas:
            self.tareas = tareas

    def selectByCurso(self, curso):
        return Enunciado.selectBy(cuatrimestre=curso.cuatrimestre, numero=curso.numero)

    def add_caso_de_prueba(self, nombre, *args, **kargs):
        return CasoDePrueba(self, nombre, *args, **kargs)

    def _get_tareas(self):
        self.__tareas = tuple(Tarea.select(
            AND(
                Tarea.q.id == enunciado_tarea_t.tarea_id,
                Enunciado.q.id == enunciado_tarea_t.enunciado_id,
                Enunciado.q.id == self.id
            ),
            clauseTables=(enunciado_tarea_t, Enunciado.sqlmeta.table),
            orderBy=enunciado_tarea_t.orden,
        ))
        return self.__tareas

    def _set_tareas(self, tareas):
        orden = {}
        for i, t in enumerate(tareas):
            orden[t.id] = i
        new = frozenset([t.id for t in tareas])
        old = frozenset([t.id for t in self.tareas])
        tareas = dict([(t.id, t) for t in tareas])
        for tid in old - new: # eliminadas
            self._connection.query(str(Delete(enunciado_tarea_t, where=AND(
                enunciado_tarea_t.enunciado_id == self.id,
                enunciado_tarea_t.tarea_id == tid))))
        for tid in new - old: # creadas
            self._connection.query(str(Insert(enunciado_tarea_t, values=dict(
                enunciado_id=self.id, tarea_id=tid, orden=orden[tid]
            ))))
        for tid in new & old: # actualizados
            self._connection.query(str(Update(enunciado_tarea_t,
                values=dict(orden=orden[tid]), where=AND(
                    enunciado_tarea_t.enunciado_id == self.id,
                    enunciado_tarea_t.tarea_id == tid,
                ))))

    def __repr__(self):
        return 'Enunciado(id=%s, autor=%s, nombre=%s, descripcion=%s, ' \
            'creado=%s)' \
                % (self.id, srepr(self.autor), self.nombre, self.descripcion, \
                    self.creado)

    def shortrepr(self):
        return self.nombre
#}}}

class CasoDePrueba(SQLObject): #{{{
    # Clave
    enunciado       = ForeignKey('Enunciado')
    nombre          = UnicodeCol(length=40, notNone=True)
    pk              = DatabaseIndex(enunciado, nombre, unique=True)
    # Campos
#    privado         = IntCol(default=None) TODO iria en instancia_de_entrega_caso_de_prueba
    parametros      = ParamsCol(length=255, default=None)
    retorno         = IntCol(default=None)
    tiempo_cpu      = FloatCol(default=None)
    descripcion     = UnicodeCol(length=255, default=None)
    # Joins
    pruebas         = MultipleJoin('Prueba')

    def __init__(self, enunciado=None, nombre=None, parametros=None,
            retorno=None, tiempo_cpu=None, descripcion=None, **kargs):
        SQLObject.__init__(self, enunciadoID=enunciado and enunciado.id,
            nombre=nombre, parametros=parametros, retorno=retorno,
            tiempo_cpu=tiempo_cpu, descripcion=descripcion, **kargs)

    def __repr__(self):
        return 'CasoDePrueba(enunciado=%s, nombre=%s, parametros=%s, ' \
            'retorno=%s, tiempo_cpu=%s, descripcion=%s)' \
                % (srepr(self.enunciado), self.nombre, self.parametros,
                    self.retorno, self.tiempo_cpu, self.descripcion)

    def shortrepr(self):
        return '%s:%s' % (self.enunciado.shortrepr(), self.nombre)
#}}}

class Ejercicio(SQLObject, ByObject): #{{{
    # Clave
    curso           = ForeignKey('Curso', notNone=True)
    numero          = IntCol(notNone=True)
    pk              = DatabaseIndex(curso, numero, unique=True)
    # Campos
    enunciado       = ForeignKey('Enunciado', notNone=True)
    grupal          = BoolCol(notNone=True, default=False)
    # Joins
    instancias      = MultipleJoin('InstanciaDeEntrega')

    def __init__(self, curso=None, numero=None, enunciado=None, grupal=False,
            **kargs):
        if curso and enunciado:
            SQLObject.__init__(self, cursoID=curso.id, numero=numero,
                enunciadoID=enunciado.id, grupal=grupal, **kargs)

    def add_instancia(self, numero, inicio, fin, *args, **kargs):
        return InstanciaDeEntrega(self, numero, inicio, fin, *args, **kargs)

    def __repr__(self):
        return 'Ejercicio(id=%s, curso=%s, numero=%s, enunciado=%s, ' \
            'grupal=%s)' \
                % (self.id, self.curso.shortrepr(), self.numero,
                    self.enunciado.shortrepr(), self.grupal)

    def shortrepr(self):
        return '(%s, %s, %s)' \
            % (self.curso.shortrepr(), str(self.numero), \
                self.enunciado.shortrepr())
#}}}

class InstanciaDeEntrega(SQLObject, ByObject): #{{{
    # Clave
    ejercicio       = ForeignKey('Ejercicio', notNone=True)
    numero          = IntCol(notNone=True)
    # Campos
    inicio          = DateTimeCol(notNone=True)
    fin             = DateTimeCol(notNone=True)
    procesada       = BoolCol(notNone=True, default=False)
    observaciones   = UnicodeCol(default=None)
    activo          = BoolCol(notNone=True, default=True)
    # Joins
    entregas        = MultipleJoin('Entrega', joinColumn='instancia_id')
    correcciones    = MultipleJoin('Correccion', joinColumn='instancia_id')
    casos_de_prueba = RelatedJoin('CasoDePrueba') # TODO CasoInstancia -> private

    def __init__(self, ejercicio=None, numero=None, inicio=None, fin=None,
            observaciones=None, activo=True, tareas=(), **kargs):
        if ejercicio:
            SQLObject.__init__(self, ejercicioID=ejercicio.id, numero=numero,
                fin=fin, inicio=inicio, observaciones=observaciones, activo=activo,
                **kargs)
        if tareas:
            self.tareas = tareas

    def _get_tareas(self):
        self.__tareas = tuple(Tarea.select(
            AND(
                Tarea.q.id == instancia_tarea_t.tarea_id,
                InstanciaDeEntrega.q.id == instancia_tarea_t.instancia_id,
                InstanciaDeEntrega.q.id == self.id,
            ),
            clauseTables=(instancia_tarea_t, InstanciaDeEntrega.sqlmeta.table),
            orderBy=instancia_tarea_t.orden,
        ))
        return self.__tareas

    def _set_tareas(self, tareas):
        orden = {}
        for i, t in enumerate(tareas):
            orden[t.id] = i
        new = frozenset([t.id for t in tareas])
        old = frozenset([t.id for t in self.tareas])
        tareas = dict([(t.id, t) for t in tareas])
        for tid in old - new: # eliminadas
            self._connection.query(str(Delete(instancia_tarea_t, where=AND(
                instancia_tarea_t.instancia_id == self.id,
                instancia_tarea_t.tarea_id == tid))))
        for tid in new - old: # creadas
            self._connection.query(str(Insert(instancia_tarea_t, values=dict(
                instancia_id=self.id, tarea_id=tid, orden=orden[tid]
            ))))
        for tid in new & old: # actualizados
            self._connection.query(str(Update(instancia_tarea_t,
                values=dict(orden=orden[tid]), where=AND(
                    instancia_tarea_t.instancia_id == self.id,
                    instancia_tarea_t.tarea_id == tid,
                ))))

    def __repr__(self):
        return 'InstanciaDeEntrega(id=%s, numero=%s, inicio=%s, fin=%s, ' \
            'procesada=%s, observaciones=%s, activo=%s)' \
                % (self.id, self.numero, self.inicio, self.fin,
                    self.procesada, self.observaciones, self.activo)

    def shortrepr(self):
        return self.numero
#}}}

class DocenteInscripto(SQLObject, ByObject): #{{{
    # Clave
    curso           = ForeignKey('Curso', notNone=True)
    docente         = ForeignKey('Docente', notNone=True)
    pk              = DatabaseIndex(curso, docente, unique=True)
    # Campos
    corrige         = BoolCol(notNone=True, default=True)
    observaciones   = UnicodeCol(default=None)
    # Joins
    alumnos         = MultipleJoin('AlumnoInscripto', joinColumn='tutor_id')
    tutorias        = MultipleJoin('Tutor', joinColumn='docente_id')
    entregas        = MultipleJoin('Entrega', joinColumn='instancia_id')
    correcciones    = MultipleJoin('Correccion', joinColumn='corrector_id')

    def __init__(self, curso=None, docente=None, corrige=True,
            observaciones=None, **kargs):
        SQLObject.__init__(self, cursoID=curso.id, docenteID=docente.id,
            corrige=corrige, observaciones=observaciones, **kargs)

    def add_correccion(self, entrega, *args, **kargs):
        return Correccion(entrega.instancia, entrega.entregador, entrega,
            self, *args, **kargs)

    def __repr__(self):
        return 'DocenteInscripto(id=%s, docente=%s, corrige=%s, ' \
            'observaciones=%s' \
                % (self.id, self.docente.shortrepr(), self.corrige,
                    self.observaciones)

    def shortrepr(self):
        return self.docente.shortrepr()
#}}}

class Entregador(InheritableSQLObject, ByObject): #{{{
    # Campos
    nota            = DecimalCol(size=3, precision=1, default=None)
    nota_cursada    = DecimalCol(size=3, precision=1, default=None)
    observaciones   = UnicodeCol(default=None)
    activo          = BoolCol(notNone=True, default=True)
    # Joins
    entregas        = MultipleJoin('Entrega')
    correcciones    = MultipleJoin('Correccion')

    def add_entrega(self, instancia, *args, **kargs):
        return Entrega(instancia, self, *args, **kargs)

    def __repr__(self):
        raise NotImplementedError, 'Clase abstracta!'
#}}}

class Grupo(Entregador): #{{{
    _inheritable = False
    # Clave
    curso           = ForeignKey('Curso', notNone=True)
    nombre          = UnicodeCol(length=20, notNone=True)
    # Campos
    responsable     = ForeignKey('AlumnoInscripto', default=None)
    # Joins
    miembros        = MultipleJoin('Miembro')
    tutores         = MultipleJoin('Tutor')

    def __init__(self, curso=None, nombre=None, responsable=None, **kargs):
        resp_id = responsable and responsable.id
        curso_id = curso and curso.id
        InheritableSQLObject.__init__(self, cursoID=curso_id, nombre=nombre,
            responsableID=resp_id, **kargs)

    def add_alumno(self, alumno, *args, **kargs):
        return Miembro(self, alumno, *args, **kargs)

    def add_docente(self, docente, *args, **kargs):
        return Tutor(self, docente, *args, **kargs)

    def __repr__(self):
        return 'Grupo(id=%s, nombre=%s, responsable=%s, nota=%s, ' \
            'nota_cursada=%s, observaciones=%s, activo=%s)' \
                % (self.id, self.nombre, srepr(self.responsable), self.nota,
                    self.nota_cursada, self.observaciones, self.activo)

    def shortrepr(self):
        return 'grupo:' + self.nombre
#}}}

class AlumnoInscripto(Entregador): #{{{
    _inheritable = False
    # Clave
    curso               = ForeignKey('Curso', notNone=True)
    alumno              = ForeignKey('Alumno', notNone=True)
    pk                  = DatabaseIndex(curso, alumno, unique=True)
    # Campos
    condicional         = BoolCol(notNone=True, default=False)
    tutor               = ForeignKey('DocenteInscripto', default=None)
    # Joins
    responsabilidades   = MultipleJoin('Grupo', joinColumn='responsable_id')
    membresias          = MultipleJoin('Miembro', joinColumn='alumno_id')
    entregas            = MultipleJoin('Entrega', joinColumn='alumno_id')
    correcciones        = MultipleJoin('Correccion', joinColumn='alumno_id')

    def __init__(self, curso=None, alumno=None, condicional=False, tutor=None,
            **kargs):
        tutor_id = tutor and tutor.id
        InheritableSQLObject.__init__(self, cursoID=curso.id, tutorID=tutor_id,
            alumnoID=alumno.id, condicional=condicional, **kargs)

    def __repr__(self):
        return 'AlumnoInscripto(id=%s, alumno=%s, condicional=%s, nota=%s, ' \
            'nota_cursada=%s, tutor=%s, observaciones=%s, activo=%s)' \
                % (self.id, self.alumno.shortrepr(), self.condicional,
                    self.nota, self.nota_cursada, srepr(self.tutor),
                    self.observaciones, self.activo)

    def shortrepr(self):
        return self.alumno.shortrepr()
#}}}

class Tutor(SQLObject, ByObject): #{{{
    # Clave
    grupo           = ForeignKey('Grupo', notNone=True)
    docente         = ForeignKey('DocenteInscripto', notNone=True)
    pk              = DatabaseIndex(grupo, docente, unique=True)
    # Campos
    alta            = DateTimeCol(notNone=True, default=DateTimeCol.now)
    baja            = DateTimeCol(default=None)

    def __init__(self, grupo=None, docente=None, **kargs):
        SQLObject.__init__(self, grupoID=grupo.id, docenteID=docente.id,
            **kargs)

    def __repr__(self):
        return 'Tutor(docente=%s, grupo=%s, alta=%s, baja=%s)' \
                % (self.docente.shortrepr(), self.grupo.shortrepr(),
                    self.alta, self.baja)

    def shortrepr(self):
        return '%s-%s' % (self.docente.shortrepr(), self.grupo.shortrepr())
#}}}

class Miembro(SQLObject, ByObject): #{{{
    # Clave
    grupo           = ForeignKey('Grupo', notNone=True)
    alumno          = ForeignKey('AlumnoInscripto', notNone=True)
    pk              = DatabaseIndex(grupo, alumno, unique=True)
    # Campos
    nota            = DecimalCol(size=3, precision=1, default=None)
    alta            = DateTimeCol(notNone=True, default=DateTimeCol.now)
    baja            = DateTimeCol(default=None)

    def __init__(self, grupo=None, alumno=None, **kargs):
        SQLObject.__init__(self, grupoID=grupo.id, alumnoID=alumno.id, **kargs)

    def __repr__(self):
        return 'Miembro(alumno=%s, grupo=%s, nota=%s, alta=%s, baja=%s)' \
                % (self.alumno.shortrepr(), self.grupo.shortrepr(),
                    self.nota, self.alta, self.baja)

    def shortrepr(self):
        return '%s-%s' % (self.alumno.shortrepr(), self.grupo.shortrepr())
#}}}

class Entrega(SQLObject, ByObject): #{{{
    # Clave
    instancia       = ForeignKey('InstanciaDeEntrega', notNone=True)
    entregador      = ForeignKey('Entregador', default=None) # Si es None era un Docente
    fecha           = DateTimeCol(notNone=True, default=DateTimeCol.now)
    pk              = DatabaseIndex(instancia, entregador, fecha, unique=True)
    # Campos
    correcta        = BoolCol(notNone=True, default=False)
    observaciones   = UnicodeCol(default=None)
    # Joins
    tareas          = MultipleJoin('TareaEjecutada')
    # Para generar código
    codigo_dict     = r'0123456789abcdefghijklmnopqrstuvwxyz_.,*@#+'
    codigo_format   = r'%m%d%H%M%S'

    def __init__(self, instancia=None, entregador=None, observaciones=None,
            **kargs):
        entregador_id = entregador and entregador.id
        SQLObject.__init__(self, instanciaID=instancia.id,
            entregadorID=entregador_id, observaciones=observaciones, **kargs)

    def add_tarea_ejecutada(self, tarea, *args, **kargs):
        return TareaEjecutada(tarea, self, *args, **kargs)

    def _get_codigo(self):
        if not hasattr(self, '_codigo'): # cache
            n = long(self.fecha.strftime(Entrega.codigo_format))
            d = Entrega.codigo_dict
            l = len(d)
            res = ''
            while n:
                    res += d[n % l]
                    n /= l
            self._codigo = res
        return self._codigo

    def _set_fecha(self, fecha):
        self._SO_set_fecha(fecha)
        if hasattr(self, '_codigo'): del self._codigo # bye, bye cache!

    def __repr__(self):
        return 'Entrega(instancia=%s, entregador=%s, codigo=%s, fecha=%s, ' \
            'correcta=%s, observaciones=%s)' \
                % (self.instancia.shortrepr(), srepr(self.entregador),
                    self.codigo, self.fecha, self.correcta, self.observaciones)

    def shortrepr(self):
        return '%s-%s-%s' % (self.instancia.shortrepr(), srepr(self.entregador),
            self.codigo)
#}}}

class Correccion(SQLObject, ByObject): #{{{
    # Clave
    instancia       = ForeignKey('InstanciaDeEntrega', notNone=True)
    entregador      = ForeignKey('Entregador', notNone=True) # Docente no tiene
    pk              = DatabaseIndex(instancia, entregador, unique=True)
    # Campos
    entrega         = ForeignKey('Entrega', notNone=True)
    corrector       = ForeignKey('DocenteInscripto', notNone=True)
    asignado        = DateTimeCol(notNone=True, default=DateTimeCol.now)
    corregido       = DateTimeCol(default=None)
    nota            = DecimalCol(size=3, precision=1, default=None)
    observaciones   = UnicodeCol(default=None)

    def __init__(self, instancia=None, entregador=None, entrega=None,
            corrector=None, observaciones=None, **kargs):
        SQLObject.__init__(self, instanciaID=instancia.id, entregaID=entrega.id,
            entregadorID=entregador.id, correctorID=corrector.id,
            observaciones=observaciones, **kargs)

    def __repr__(self):
        return 'Correccion(instancia=%s, entregador=%s, entrega=%s, ' \
            'corrector=%s, asignado=%s, corregido=%s, nota=%s, ' \
            'observaciones=%s)' \
                % (self.instancia.shortrepr(), self.entregador.shortrepr(),
                    self.entrega.shortrepr(), self.corrector, self.asignado,
                    self.corregido, self.nota, self.observaciones)

    def shortrepr(self):
        return '%s,%s' % (self.entrega.shortrepr(), self.corrector.shortrepr())
#}}}

class TareaEjecutada(InheritableSQLObject, ByObject): #{{{
    # Clave
    tarea           = ForeignKey('Tarea', notNone=True)
    entrega         = ForeignKey('Entrega', notNone=True)
    pk              = DatabaseIndex(tarea, entrega, unique=True)
    # Campos
    inicio          = DateTimeCol(notNone=True, default=DateTimeCol.now)
    fin             = DateTimeCol(default=None)
    exito           = IntCol(default=None)
    observaciones   = UnicodeCol(default=None)
    # Joins
    pruebas         = MultipleJoin('Prueba')

    def __init__(self, tarea=None, entrega=None, observaciones=None, **kargs):
        InheritableSQLObject.__init__(self, tareaID=tarea.id,
            entregaID=entrega.id, observaciones=observaciones, **kargs)

    def add_prueba(self, caso_de_prueba, *args, **kargs):
        return Prueba(self, caso_de_prueba, *args, **kargs)

    def __repr__(self):
        return 'TareaEjecutada(tarea=%s, entrega=%s, inicio=%s, fin=%s, ' \
            'exito=%s, observaciones=%s)' \
                % (self.tarea.shortrepr(), self.entrega.shortrepr(),
                    self.inicio, self.fin, self.exito, self.observaciones)

    def shortrepr(self):
        return '%s-%s' % (self.tarea.shortrepr(), self.entrega.shortrepr())
#}}}

class Prueba(SQLObject): #{{{
    # Clave
    tarea_ejecutada = ForeignKey('TareaEjecutada', notNone=True)
    caso_de_prueba  = ForeignKey('CasoDePrueba', notNone=True)
    pk              = DatabaseIndex(tarea_ejecutada, caso_de_prueba, unique=True)
    # Campos
    inicio          = DateTimeCol(notNone=True, default=DateTimeCol.now)
    fin             = DateTimeCol(default=None)
    pasada          = IntCol(default=None)
    observaciones   = UnicodeCol(default=None)

    def __init__(self, tarea_ejecutada=None, caso_de_prueba=None,
            observaciones=None, **kargs):
        SQLObject.__init__(self, tarea_ejecutadaID=tarea_ejecutada.id,
            caso_de_pruebaID=caso_de_prueba.id, observaciones=observaciones,
            **kargs)

    def __repr__(self):
        return 'Prueba(tarea_ejecutada=%s, caso_de_prueba=%s, inicio=%s, ' \
            'fin=%s, pasada=%s, observaciones=%s)' \
                % (self.tarea_ejecutada.shortrepr(),
                    self.caso_de_prueba.shortrepr(), self.inicio, self.fin,
                    self.pasada, self.observaciones)

    def shortrepr(self):
        return '%s:%s' % (self.tarea_ejecutada.shortrepr(),
            self.caso_de_prueba.shortrerp())
#}}}

#{{{ Específico de Identity

class Visita(SQLObject): #{{{
    visit_key   = StringCol(length=40, alternateID=True,
                    alternateMethodName="by_visit_key")
    created     = DateTimeCol(notNone=True, default=datetime.now)
    expiry      = DateTimeCol()

    @classmethod
    def lookup_visit(cls, visit_key):
        try:
            return cls.by_visit_key(visit_key)
        except SQLObjectNotFound:
            return None
#}}}

class VisitaUsuario(SQLObject): #{{{
    # Clave
    visit_key   = StringCol(length=40, alternateID=True,
                          alternateMethodName="by_visit_key")
    # Campos
    user_id     = IntCol() # Negrada de identity
#}}}

class Rol(SQLObject): #{{{
    # Clave
    nombre      = UnicodeCol(length=255, alternateID=True,
                    alternateMethodName="by_group_name")
    # Campos
    descripcion = UnicodeCol(length=255, default=None)
    creado      = DateTimeCol(notNone=True, default=datetime.now)
    permisos    = TupleCol(notNone=True)
    # Joins
    usuarios    = RelatedJoin('Usuario')

    def __init__(self, nombre=None, permisos=(), descripcion=None, **kargs):
        SQLObject.__init__(self, nombre=nombre, permisos=permisos,
            descripcion=descripcion, **kargs)
#}}}

# No es un SQLObject porque no tiene sentido agregar/sacar permisos, están
# hardcodeados en el código
class Permiso(object): #{{{
    def __init__(self, nombre, descripcion):
        self.nombre = nombre
        self.descripcion = descripcion

    @classmethod
    def createTable(cls, ifNotExists): # para identity
        pass

    @property
    def permission_name(self): # para identity
        return self.nombre

    def __repr__(self):
        return self.nombre
#}}}

# TODO ejemplos
entregar_tp = Permiso(u'entregar', u'Permite entregar trabajos prácticos')
admin = Permiso(u'admin', u'Permite hacer ABMs arbitrarios')

#}}} Identity

#}}} Clases

