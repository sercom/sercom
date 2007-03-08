# vim: set et sw=4 sts=4 encoding=utf-8 foldmethod=marker :

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

__all__ = ('Curso', 'Usuario', 'Docente', 'Alumno', 'CasoDePrueba')

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
        if isinstance(value, basestring) or value is None:
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
        elif isinstance(value, basestring) or value is None:
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

#{{{ Clases

def srepr(obj): #{{{
    if obj is not None:
        return obj.shortrepr()
    return obj
#}}}

class Curso(SQLObject): #{{{
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

    def __init__(self, docentes=[], ejercicios=[], alumnos=[], **kw):
        super(Curso, self).__init__(**kw)
        for d in docentes:
            self.add_docente(d)
        for (n, e) in enumerate(ejercicios):
            self.add_ejercicio(n, e)
        for a in alumnos:
            self.add_alumno(a)

    def set(self, docentes=None, ejercicios=None, alumnos=None, **kw):
        super(Curso, self).set(**kw)
        if docentes is not None:
            for d in DocenteInscripto.selectBy(curso=self):
                d.destroySelf()
            for d in docentes:
                self.add_docente(d)
        if ejercicios is not None:
            for e in Ejercicio.selectBy(curso=self):
                e.destroySelf()
            for (n, e) in enumerate(ejercicios):
                self.add_ejercicio(n+1, e)
        if alumnos is not None:
            for a in AlumnoInscripto.selectBy(curso=self):
                a.destroySelf()
            for a in alumnos:
                self.add_alumno(a)

    def add_docente(self, docente, **kw):
        if isinstance(docente, Docente):
            kw['docente'] = docente
        else:
            kw['docenteID'] = docente
        return DocenteInscripto(curso=self, **kw)

    def remove_docente(self, docente):
        if isinstance(docente, Docente):
            docente = docente.id
        # FIXME esto deberian arreglarlo en SQLObject y debería ser
        # DocenteInscripto.pk.get(self, docente).destroySelf()
        DocenteInscripto.pk.get(self.id, docente).destroySelf()

    def add_alumno(self, alumno, **kw):
        if isinstance(alumno, Alumno):
            kw['alumno'] = alumno
        else:
            kw['alumnoID'] = alumno
        return AlumnoInscripto(curso=self, **kw)

    def remove_alumno(self, alumno):
        if isinstance(alumno, Alumno):
            alumno = alumno.id
        # FIXME esto deberian arreglarlo en SQLObject
        AlumnoInscripto.pk.get(self.id, alumno).destroySelf()

    def add_grupo(self, nombre, **kw):
        return Grupo(curso=self, nombre=unicode(nombre), **kw)

    def remove_grupo(self, nombre):
        # FIXME esto deberian arreglarlo en SQLObject
        Grupo.pk.get(self.id, nombre).destroySelf()

    def add_ejercicio(self, numero, enunciado, **kw):
        if isinstance(enunciado, Enunciado):
            kw['enunciado'] = enunciado
        else:
            kw['enunciadoID'] = enunciado
        return Ejercicio(curso=self, numero=numero, **kw)

    def remove_ejercicio(self, numero):
        # FIXME esto deberian arreglarlo en SQLObject
        Ejercicio.pk.get(self.id, numero).destroySelf()

    def __repr__(self):
        return 'Curso(id=%s, anio=%s, cuatrimestre=%s, numero=%s, ' \
            'descripcion=%s)' \
                % (self.id, self.anio, self.cuatrimestre, self.numero,
                    self.descripcion)

    def shortrepr(self):
        return '%s.%s.%s' \
            % (self.anio, self.cuatrimestre, self.numero)
#}}}

class Usuario(InheritableSQLObject): #{{{
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
    roles           = RelatedJoin('Rol', addRemoveName='_rol')

    def __init__(self, password=None, roles=[], **kw):
        if password is not None:
            kw['contrasenia'] = encryptpw(password)
        super(Usuario, self).__init__(**kw)
        for r in roles:
            self.add_rol(r)

    def set(self, password=None, roles=None, **kw):
        if password is not None:
            kw['contrasenia'] = encryptpw(password)
        super(Usuario, self).set(**kw)
        if roles is not None:
            for r in self.roles:
                self.remove_rol(r)
            for r in roles:
                self.add_rol(r)

    def _get_user_name(self): # para identity
        return self.usuario

    @classmethod
    def by_user_name(cls, user_name): # para identity
        user = cls.byUsuario(user_name)
        if not user.activo:
            raise SQLObjectNotFound(_(u'El %s está inactivo' % cls.__name__))
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
        raise NotImplementedError(_(u'Clase abstracta!'))

    def shortrepr(self):
        return '%s (%s)' % (self.usuario, self.nombre)
#}}}

class Docente(Usuario): #{{{
    _inheritable = False
    # Campos
    nombrado    = BoolCol(notNone=True, default=True)
    # Joins
    enunciados  = MultipleJoin('Enunciado', joinColumn='autor_id')
    cursos      = MultipleJoin('DocenteInscripto')

    def add_entrega(self, instancia, **kw):
        return Entrega(instancia=instancia, **kw)

    def add_enunciado(self, nombre, anio, cuatrimestre, **kw):
        return Enunciado(nombre=nombre, anio=anio, cuatrimestre=cuatrimestre,
            autor=self, **kw)

    def remove_enunciado(self, nombre, anio, cuatrimestre):
        Enunciado.pk.get(nombre, anio, cuatrimestre).destroySelf()

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

    def __init__(self, padron=None, **kw):
        if padron: kw['usuario'] = padron
        super(Alumno, self).__init__(**kw)

    def set(self, padron=None, **kw):
        if padron: kw['usuario'] = padron
        super(Alumno, self).set(**kw)

    def _get_padron(self): # alias para poder referirse al alumno por padron
        return self.usuario

    def _set_padron(self, padron):
        self.usuario = padron

    @classmethod
    def byPadron(cls, padron):
        return cls.byUsuario(unicode(padron))

    def __repr__(self):
        return 'Alumno(id=%s, padron=%s, nombre=%s, password=%s, email=%s, ' \
            'telefono=%s, activo=%s, creado=%s, observaciones=%s)' \
                % (self.id, self.padron, self.nombre, self.password, self.email,
                    self.telefono, self.activo, self.creado, self.observaciones)
#}}}

class Tarea(InheritableSQLObject): #{{{
    # Clave
    nombre              = UnicodeCol(length=30, alternateID=True)
    # Campos
    descripcion         = UnicodeCol(length=255, default=None)
    terminar_si_falla   = BoolCol(notNone=True, default=True)
    rechazar_si_falla   = BoolCol(notNone=True, default=True)
    # Joins
    enunciados          = RelatedJoin('Enunciado', addRemoveName='_enunciado')

    def __repr__(self):
        raise NotImplementedError('Tarea es una clase abstracta')

    def shortrepr(self):
        return self.nombre
#}}}

class TareaFuente(Tarea): #{{{
    # Joins
    comandos    = MultipleJoin('ComandoFuente', joinColumn='tarea_id')

    def add_comando(self, orden, comando, **kw):
        return ComandoFuente(tarea=self, orden=orden, comando=comando, **kw)

    def remove_comando(self, orden):
        ComandoFuente.pk.get(self.id, orden).destroySelf()

    def __repr__(self):
        return 'TareaFuente(id=%s, nombre=%s, descripcion=%s)' \
                % (self.id, self.nombre, self.descripcion)
#}}}

class TareaPrueba(Tarea): #{{{
    # Joins
    comandos    = MultipleJoin('ComandoPrueba', joinColumn='tarea_id')

    def add_comando(self, orden, comando, **kw):
        return ComandoPrueba(tarea=self, orden=orden, comando=comando, **kw)

    def remove_comando(self, orden):
        ComandoPrueba.pk.get(self.id, orden).destroySelf()

    def __repr__(self):
        return 'TareaPrueba(id=%s, nombre=%s, descripcion=%s)' \
                % (self.id, self.nombre, self.descripcion)
#}}}

class Comando(SQLObject): #{{{
    # Campos
    comando             = ParamsCol(length=255, notNone=True)
    descripcion         = UnicodeCol(length=255, default=None)
    retorno             = IntCol(default=None)
    terminar_si_falla   = BoolCol(notNone=True, default=True)
    rechazar_si_falla   = BoolCol(notNone=True, default=True)
    archivos_entrada    = BLOBCol(default=None) # ZIP con archivos de entrada
                                                # stdin es caso especial
    archivos_salida     = BLOBCol(default=None) # ZIP con archivos de salida
                                                # stdout y stderr son especiales

    def __repr__(self):
        raise NotImplementedError('Comando es una clase abstracta')

    def shortrepr(self):
        return self.nombre
#}}}

class ComandoFuente(Comando): #{{{
    # Clave
    tarea       = ForeignKey('TareaFuente', notNone=True, cascade=True)
    orden       = IntCol(notNone=True)
    pk          = DatabaseIndex(tarea, orden, unique=True)
    # Campos
    tiempo_cpu  = FloatCol(default=None)

    def ejecutar(self): pass # TODO

    def __repr__(self):
        return 'ComandoFuente(tarea=%s, orden=%s, comando=%s, descripcion=%s, ' \
            'retorno=%s, tiempo_cpu=%s, terminar_si_falla=%s, ' \
            'rechazar_si_falla=%s)' \
                % (srepr(self.tarea), self.orden, self.comando, self.descripcion,
                    self.retorno, self.tiempo_cpu, self.terminar_si_falla,
                    self.rechazar_si_falla)
#}}}

class ComandoPrueba(Comando): #{{{
    # Clave
    tarea               = ForeignKey('TareaPrueba', notNone=True, cascade=True)
    orden               = IntCol(notNone=True)
    pk                  = DatabaseIndex(tarea, orden, unique=True)
    # Campos
    multipl_tiempo_cpu  = FloatCol(notNone=True, default=1.0)

    def ejecutar(self): pass # TODO

    def __repr__(self):
        return 'ComandoPrueba(tarea=%s, orden=%s, comando=%s, descripcion=%s, ' \
            'retorno=%s, tiempo_cpu=%s, terminar_si_falla=%s, ' \
            'rechazar_si_falla=%s)' \
                % (srepr(self.tarea), self.orden, self.comando, self.descripcion,
                    self.retorno, self.tiempo_cpu, self.terminar_si_falla,
                    self.rechazar_si_falla)
#}}}

class Enunciado(SQLObject): #{{{
    # Clave
    nombre          = UnicodeCol(length=60)
    anio            = IntCol(notNone=True)
    cuatrimestre    = IntCol(notNone=True)
    pk              = DatabaseIndex(nombre, anio, cuatrimestre, unique=True)
    # Campos
    descripcion     = UnicodeCol(length=255, default=None)
    autor           = ForeignKey('Docente', cascade='null')
    creado          = DateTimeCol(notNone=True, default=DateTimeCol.now)
    archivo         = BLOBCol(default=None)
    archivo_name    = UnicodeCol(length=255, default=None)
    archivo_type    = UnicodeCol(length=255, default=None)
    # Joins
    ejercicios      = MultipleJoin('Ejercicio')
    casos_de_prueba = MultipleJoin('CasoDePrueba')
    tareas          = RelatedJoin('Tarea', addRemoveName='_tarea')

    def __init__(self, tareas=[], **kw):
        super(Enunciado, self).__init__(**kw)
        for tarea in tareas:
            self.add_tarea(tarea)

    def set(self, tareas=None, **kw):
        super(Enunciado, self).set(**kw)
        if tareas is not None:
            for tarea in self.tareas:
                self.remove_tarea(tarea)
            for tarea in tareas:
                self.add_tarea(tarea)

    @classmethod
    def selectByCurso(self, curso):
        return Enunciado.selectBy(cuatrimestre=curso.cuatrimestre, anio=curso.anio)

    def add_caso_de_prueba(self, nombre, **kw):
        return CasoDePrueba(enunciado=self, nombre=nombre, **kw)

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
    enunciado           = ForeignKey('Enunciado', cascade=True)
    nombre              = UnicodeCol(length=40, notNone=True)
    pk                  = DatabaseIndex(enunciado, nombre, unique=True)
    # Campos
    descripcion         = UnicodeCol(length=255, default=None)
    terminar_si_falla   = BoolCol(notNone=True, default=False)
    rechazar_si_falla   = BoolCol(notNone=True, default=True)
    parametros          = ParamsCol(length=255, default=None)
    retorno             = IntCol(default=None)
    tiempo_cpu          = FloatCol(default=None)
    archivos_entrada    = BLOBCol(default=None) # ZIP con archivos de entrada
                                                # stdin es caso especial
    archivos_salida     = BLOBCol(default=None) # ZIP con archivos de salida
                                                # stdout y stderr son especiales
    activo              = BoolCol(notNone=True, default=True)
    # Joins
    pruebas             = MultipleJoin('Prueba')

    def __repr__(self):
        return 'CasoDePrueba(enunciado=%s, nombre=%s, parametros=%s, ' \
            'retorno=%s, tiempo_cpu=%s, descripcion=%s)' \
                % (srepr(self.enunciado), self.nombre, self.parametros,
                    self.retorno, self.tiempo_cpu, self.descripcion)

    def shortrepr(self):
        return '%s:%s' % (self.enunciado.shortrepr(), self.nombre)
#}}}

class Ejercicio(SQLObject): #{{{
    # Clave
    curso           = ForeignKey('Curso', notNone=True, cascade=True)
    numero          = IntCol(notNone=True)
    pk              = DatabaseIndex(curso, numero, unique=True)
    # Campos
    enunciado       = ForeignKey('Enunciado', notNone=True, cascade=False)
    grupal          = BoolCol(default=False) # None es grupal o individual
    # Joins
    instancias      = MultipleJoin('InstanciaDeEntrega')

    def add_instancia(self, numero, inicio, fin, **kw):
        return InstanciaDeEntrega(ejercicio=self, numero=numero, inicio=inicio,
            fin=fin, **kw)

    def remove_instancia(self, numero):
        # FIXME self.id
        InstanciaDeEntrega.pk.get(self.id, numero).destroySelf()

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

class InstanciaDeEntrega(SQLObject): #{{{
    # Clave
    ejercicio       = ForeignKey('Ejercicio', notNone=True, cascade=True)
    numero          = IntCol(notNone=True)
    pk              = DatabaseIndex(ejercicio, numero, unique=True)
    # Campos
    inicio          = DateTimeCol(notNone=True)
    fin             = DateTimeCol(notNone=True)
    procesada       = BoolCol(notNone=True, default=False)
    observaciones   = UnicodeCol(default=None)
    activo          = BoolCol(notNone=True, default=True)
    # Joins
    entregas        = MultipleJoin('Entrega', joinColumn='instancia_id')
    correcciones    = MultipleJoin('Correccion', joinColumn='instancia_id')

    def __repr__(self):
        return 'InstanciaDeEntrega(id=%s, numero=%s, inicio=%s, fin=%s, ' \
            'procesada=%s, observaciones=%s, activo=%s)' \
                % (self.id, self.numero, self.inicio, self.fin,
                    self.procesada, self.observaciones, self.activo)

    def shortrepr(self):
        return self.numero
#}}}

class DocenteInscripto(SQLObject): #{{{
    # Clave
    curso           = ForeignKey('Curso', notNone=True, cascade=True)
    docente         = ForeignKey('Docente', notNone=True, cascade=True)
    pk              = DatabaseIndex(curso, docente, unique=True)
    # Campos
    corrige         = BoolCol(notNone=True, default=True)
    observaciones   = UnicodeCol(default=None)
    # Joins
    alumnos         = MultipleJoin('AlumnoInscripto', joinColumn='tutor_id')
    tutorias        = MultipleJoin('Tutor', joinColumn='docente_id')
    correcciones    = MultipleJoin('Correccion', joinColumn='corrector_id')

    def add_correccion(self, entrega, **kw):
        return Correccion(instancia=entrega.instancia, entrega=entrega,
            entregador=entrega.entregador, corrector=self, **kw)

    def remove_correccion(self, instancia, entregador):
        # FIXME instancia.id, entregador.id
        Correccion.pk.get(instancia.id, entregador.id).destroySelf()

    def __repr__(self):
        return 'DocenteInscripto(id=%s, docente=%s, corrige=%s, ' \
            'observaciones=%s' \
                % (self.id, self.docente.shortrepr(), self.corrige,
                    self.observaciones)

    def shortrepr(self):
        return self.docente.shortrepr()
#}}}

class Entregador(InheritableSQLObject): #{{{
    # Campos
    nota            = DecimalCol(size=3, precision=1, default=None)
    nota_cursada    = DecimalCol(size=3, precision=1, default=None)
    observaciones   = UnicodeCol(notNone=True, default=u'')
    activo          = BoolCol(notNone=True, default=True)
    # Joins
    entregas        = MultipleJoin('Entrega')
    correcciones    = MultipleJoin('Correccion')

    def add_entrega(self, instancia, **kw):
        return Entrega(instancia=instancia, entregador=self, **kw)

    def __repr__(self):
        raise NotImplementedError, 'Clase abstracta!'
#}}}

class Grupo(Entregador): #{{{
    _inheritable = False
    # Clave
    curso           = ForeignKey('Curso', notNone=True, cascade=True)
    nombre          = UnicodeCol(length=20, notNone=True)
    pk              = DatabaseIndex(curso, nombre, unique=True)
    # Campos
    responsable     = ForeignKey('AlumnoInscripto', default=None, cascade='null')
    # Joins
    miembros        = MultipleJoin('Miembro')
    tutores         = MultipleJoin('Tutor')

    def __init__(self, miembros=[], tutores=[], **kw):
        super(Grupo, self).__init__(**kw)
        for a in miembros:
            self.add_miembro(a)
        for d in tutores:
            self.add_tutor(d)

    def set(self, miembros=None, tutores=None, **kw):
        super(Grupo, self).set(**kw)
        if miembros is not None:
            for m in Miembro.selectBy(grupo=self):
                m.destroySelf()
            for m in miembros:
                self.add_miembro(m)
        if tutores is not None:
            for t in Tutor.selectBy(grupo=self):
                t.destroySelf()
            for t in tutores:
                self.add_tutor(t)

    _doc_alumnos = 'Devuelve una lista de AlumnoInscriptos **activos**.'
    def _get_alumnos(self):
        return list([m.alumno for m in Miembro.selectBy(grupo=self, baja=None)])

    _doc_docentes = 'Devuelve una lista de DocenteInscriptos **activos**.'
    def _get_docentes(self):
        return list([t.docente for t in Tutor.selectBy(grupo=self, baja=None)])

    def add_miembro(self, alumno, **kw):
        if isinstance(alumno, AlumnoInscripto):
            alumno = alumno.id
        return Miembro(grupo=self, alumnoID=alumno, **kw)

    def remove_miembro(self, alumno):
        if isinstance(alumno, AlumnoInscripto):
            alumno = alumno.id
        m = Miembro.selectBy(grupo=self, alumnoID=alumno, baja=None).getOne()
        m.baja = DateTimeCol.now()

    def add_tutor(self, docente, **kw):
        if isinstance(docente, DocenteInscripto):
            docente = docente.id
        return Tutor(grupo=self, docenteID=docente, **kw)

    def remove_tutor(self, docente):
        if isinstance(docente, DocenteInscripto):
            docente = docente.id
        t = Tutor.selectBy(grupo=self, docenteID=docente, baja=None)
        t.baja = DateTimeCol.now()

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
    curso               = ForeignKey('Curso', notNone=True, cascade=True)
    alumno              = ForeignKey('Alumno', notNone=True, cascade=True)
    pk                  = DatabaseIndex(curso, alumno, unique=True)
    # Campos
    condicional         = BoolCol(notNone=True, default=False)
    tutor               = ForeignKey('DocenteInscripto', default=None, cascade='null')
    # Joins
    responsabilidades   = MultipleJoin('Grupo', joinColumn='responsable_id')
    membresias          = MultipleJoin('Miembro', joinColumn='alumno_id')
    entregas            = MultipleJoin('Entrega', joinColumn='alumno_id')
    correcciones        = MultipleJoin('Correccion', joinColumn='alumno_id')

    def _get_nombre(self):
        return self.alumno.padron

    def __repr__(self):
        return 'AlumnoInscripto(id=%s, alumno=%s, condicional=%s, nota=%s, ' \
            'nota_cursada=%s, tutor=%s, observaciones=%s, activo=%s)' \
                % (self.id, self.alumno.shortrepr(), self.condicional,
                    self.nota, self.nota_cursada, srepr(self.tutor),
                    self.observaciones, self.activo)

    def shortrepr(self):
        return self.alumno.shortrepr()
#}}}

class Tutor(SQLObject): #{{{
    # Clave
    grupo           = ForeignKey('Grupo', notNone=True, cascade=True)
    docente         = ForeignKey('DocenteInscripto', notNone=True, cascade=True)
    pk              = DatabaseIndex(grupo, docente, unique=True)
    # Campos
    alta            = DateTimeCol(notNone=True, default=DateTimeCol.now)
    baja            = DateTimeCol(default=None)

    def __repr__(self):
        return 'Tutor(docente=%s, grupo=%s, alta=%s, baja=%s)' \
                % (self.docente.shortrepr(), self.grupo.shortrepr(),
                    self.alta, self.baja)

    def shortrepr(self):
        return '%s-%s' % (self.docente.shortrepr(), self.grupo.shortrepr())
#}}}

class Miembro(SQLObject): #{{{
    # Clave
    grupo           = ForeignKey('Grupo', notNone=True, cascade=True)
    alumno          = ForeignKey('AlumnoInscripto', notNone=True, cascade=True)
    pk              = DatabaseIndex(grupo, alumno, unique=True)
    # Campos
    nota            = DecimalCol(size=3, precision=1, default=None)
    alta            = DateTimeCol(notNone=True, default=DateTimeCol.now)
    baja            = DateTimeCol(default=None)

    def __repr__(self):
        return 'Miembro(alumno=%s, grupo=%s, nota=%s, alta=%s, baja=%s)' \
                % (self.alumno.shortrepr(), self.grupo.shortrepr(),
                    self.nota, self.alta, self.baja)

    def shortrepr(self):
        return '%s-%s' % (self.alumno.shortrepr(), self.grupo.shortrepr())
#}}}

class Entrega(SQLObject): #{{{
    # Clave
    instancia           = ForeignKey('InstanciaDeEntrega', notNone=True, cascade=False)
    entregador          = ForeignKey('Entregador', default=None, cascade=False) # Si es None era un Docente
    fecha               = DateTimeCol(notNone=True, default=DateTimeCol.now)
    pk                  = DatabaseIndex(instancia, entregador, fecha, unique=True)
    # Campos
    archivos            = BLOBCol(notNone=True) # ZIP con fuentes de la entrega
    correcta            = BoolCol(default=None) # None es que no se sabe qué pasó
    inicio_tareas       = DateTimeCol(default=None) # Si es None no se procesó
    fin_tareas          = DateTimeCol(default=None) # Si es None pero inicio no, se está procesando
    observaciones       = UnicodeCol(notNone=True, default=u'')
    # Joins
    comandos_ejecutados = MultipleJoin('ComandoFuenteEjecutado')
    pruebas             = MultipleJoin('Prueba')

    def add_comando_ejecutado(self, comando, **kw):
        return ComandoFuenteEjecutado(entrega=self, comando=comando, **kw)

    def remove_comando_ejecutado(self, comando):
        if isinstance(comando, ComandoFuente):
            comando = comando.id
        # FIXME self.id
        ComandoFuenteEjecutado.pk.get(self.id, comando).destroySelf()

    def add_prueba(self, caso_de_prueba, **kw):
        return Prueba(entrega=self, caso_de_prueba=caso_de_prueba, **kw)

    def remove_prueba(self, caso_de_prueba):
        if isinstance(caso_de_prueba, CasoDePrueba):
            caso_de_prueba = caso_de_prueba.id
        # FIXME self.id, caso_de_prueba
        Prueba.pk.get(self.id, caso_de_prueba).destroySelf()

    def __repr__(self):
        return 'Entrega(id=%s, instancia=%s, entregador=%s, fecha=%s, ' \
            'correcta=%s, inicio_tareas=%s, fin_tareas=%s, observaciones=%s)' \
                % (self.id, self.instancia.shortrepr(), srepr(self.entregador),
                    self.fecha, self.inicio_tareas, self.fin_tareas,
                    self.correcta, self.observaciones)

    def shortrepr(self):
        return '%s-%s-%s' % (self.instancia.shortrepr(),
            srepr(self.entregador), self.fecha)
#}}}

class Correccion(SQLObject): #{{{
    # Clave
    instancia       = ForeignKey('InstanciaDeEntrega', notNone=True, cascade=False)
    entregador      = ForeignKey('Entregador', notNone=True, cascade=False) # Docente no tiene
    pk              = DatabaseIndex(instancia, entregador, unique=True)
    # Campos
    entrega         = ForeignKey('Entrega', notNone=True, cascade=False)
    corrector       = ForeignKey('DocenteInscripto', default=None, cascade='null')
    asignado        = DateTimeCol(notNone=True, default=DateTimeCol.now)
    corregido       = DateTimeCol(default=None)
    nota            = DecimalCol(size=3, precision=1, default=None)
    observaciones   = UnicodeCol(default=None)

    def _get_entregas(self):
        return list(Entrega.selectBy(instancia=self.instancia, entregador=self.entregador))

    def __repr__(self):
        return 'Correccion(instancia=%s, entregador=%s, entrega=%s, ' \
            'corrector=%s, asignado=%s, corregido=%s, nota=%s, ' \
            'observaciones=%s)' \
                % (self.instancia.shortrepr(), self.entregador.shortrepr(),
                    self.entrega.shortrepr(), self.corrector, self.asignado,
                    self.corregido, self.nota, self.observaciones)

    def shortrepr(self):
        if not self.corrector:
            return '%s' % self.entrega.shortrepr()
        return '%s,%s' % (self.entrega.shortrepr(), self.corrector.shortrepr())
#}}}

class ComandoEjecutado(InheritableSQLObject): #{{{
    # Campos
    inicio          = DateTimeCol(notNone=True, default=DateTimeCol.now)
    fin             = DateTimeCol(default=None)
    exito           = IntCol(default=None)
    observaciones   = UnicodeCol(notNone=True, default=u'')

    def __repr__(self):
        raise NotImplementedError('ComandoEjecutado es una clase abstracta')
#}}}

class ComandoFuenteEjecutado(ComandoEjecutado): #{{{
    # Clave
    comando = ForeignKey('ComandoFuente', notNone=True, cascade=False)
    entrega = ForeignKey('Entrega', notNone=True, cascade=False)
    pk      = DatabaseIndex(comando, entrega, unique=True)

    def __repr__(self):
        return 'ComandoFuenteEjecutado(comando=%s, entrega=%s, inicio=%s, ' \
            'fin=%s, exito=%s, observaciones=%s)' \
                % (self.comando.shortrepr(), self.entrega.shortrepr(),
                    self.inicio, self.fin, self.exito, self.observaciones)

    def shortrepr(self):
        return '%s-%s' % (self.tarea.shortrepr(), self.entrega.shortrepr())
#}}}

class ComandoPruebaEjecutado(ComandoEjecutado): #{{{
    # Clave
    comando = ForeignKey('ComandoPrueba', notNone=True, cascade=False)
    prueba  = ForeignKey('Prueba', notNone=True, cascade=False)
    pk      = DatabaseIndex(comando, prueba, unique=True)

    def __repr__(self):
        return 'ComandoPruebaEjecutado(comando=%s, prueba=%s, inicio=%s, ' \
            'fin=%s, exito=%s, observaciones=%s)' \
                % (self.comando.shortrepr(), self.prueba.shortrepr(),
                    self.inicio, self.fin, self.exito, self.observaciones)

    def shortrepr(self):
        return '%s:%s:%s' % (self.tarea.shortrepr(), self.entrega.shortrerp(),
            self.caso_de_prueba.shortrerp())
#}}}

class Prueba(SQLObject): #{{{
    # Clave
    entrega             = ForeignKey('Entrega', notNone=True, cascade=False)
    caso_de_prueba      = ForeignKey('CasoDePrueba', notNone=True, cascade=False)
    pk                  = DatabaseIndex(entrega, caso_de_prueba, unique=True)
    # Campos
    inicio              = DateTimeCol(notNone=True, default=DateTimeCol.now)
    fin                 = DateTimeCol(default=None)
    pasada              = IntCol(default=None)
    observaciones       = UnicodeCol(notNone=True, default=u'')
    # Joins
    comandos_ejecutados = MultipleJoin('ComandoPruebaEjecutado')

    def add_comando_ejecutado(self, comando, **kw):
        if isinstance(comando, ComandoPrueba):
            comando = comando.id
        return ComandoPruebaEjecutado(prueba=self, comandoID=comando, **kw)

    def remove_comando_ejecutado(self, comando):
        if isinstance(comando, ComandoPrueba):
            comando = comando.id
        # FIXME self.id, comando.id
        ComandoPruebaEjecutado.pk.get(self.id, comando).destroySelf()

    def __repr__(self):
        return 'Prueba(entrega=%s, caso_de_prueba=%s, inicio=%s, fin=%s, ' \
            'pasada=%s, observaciones=%s)' \
                % (self.entrega.shortrepr(), self.caso_de_prueba.shortrepr(),
                self.inicio, self.fin, self.pasada, self.observaciones)

    def shortrepr(self):
        return '%s:%s' % (self.entrega.shortrepr(),
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
                    alternateMethodName='by_nombre')
    # Campos
    descripcion = UnicodeCol(length=255, default=None)
    creado      = DateTimeCol(notNone=True, default=datetime.now)
    permisos    = TupleCol(notNone=True)
    # Joins
    usuarios    = RelatedJoin('Usuario', addRemoveName='_usuario')

    def by_group_name(self, name): # para identity
        return self.by_nombre(name)
#}}}

# No es un SQLObject porque no tiene sentido agregar/sacar permisos, están
# hardcodeados en el código
class Permiso(object): #{{{
    max_valor = 1
    def __init__(self, nombre, descripcion):
        self.valor = Permiso.max_valor
        Permiso.max_valor <<= 1
        self.nombre = nombre
        self.descripcion = descripcion

    @classmethod
    def createTable(cls, ifNotExists): # para identity
        pass

    @property
    def permission_name(self): # para identity
        return self.nombre

    def __and__(self, other):
        return self.valor & other.valor

    def __or__(self, other):
        return self.valor | other.valor

    def __repr__(self):
        return self.nombre
#}}}

# TODO ejemplos
entregar_tp = Permiso(u'entregar', u'Permite entregar trabajos prácticos')
admin = Permiso(u'admin', u'Permite hacer ABMs arbitrarios')

#}}} Identity

#}}} Clases

