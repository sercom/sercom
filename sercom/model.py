# vim: set et sw=4 sts=4 encoding=utf-8 foldmethod=marker :

from turbojson import jsonify
from datetime import datetime
from turbogears.database import PackageHub
from sqlobject import *
from sqlobject.sqlbuilder import *
from sqlobject.inheritance import InheritableSQLObject
from sqlobject.col import PickleValidator, UnicodeStringValidator
from turbogears import identity
from turbogears.identity import encrypt_password as encryptpw
from formencode import Invalid
from ziputil import *
from domain import *

hub = PackageHub("sercom")
__connection__ = hub

__all__ = ('Curso', 'Usuario', 'Docente', 'Alumno', 'CasoDePrueba')

BLOB_SIZE = (1 << 24) - 1 # 16MB (MEDIUMBLOB)

#{{{ Custom Columns


# TODO Esto debería implementarse con CSV para mayor legibilidad
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
        return [TupleValidator(name=self.name, pickleProtocol=self.pickleProtocol)]

class TupleCol(PickleCol):
    baseClass = SOTupleCol

#}}}

#{{{ Clases

def validate_in(values): #{{{
    if values:
        return [-1] + values
    else:
        return [-1]
#}}}


def srepr(obj): #{{{
    if obj is not None:
        return obj.shortrepr()
    return obj
#}}}


#{{{ Modulo Examenes
class ExamenFinal(SQLObject): #{{{
    class sqlmeta:
        defaultOrder='-fecha'

    # Clave
    anio             = IntCol(notNone=True)
    cuatrimestre     = IntCol(notNone=True)
    oportunidad      = IntCol(notNone=True)
    pk               = DatabaseIndex(anio, cuatrimestre, oportunidad, unique=True)
    # Campos
    fecha            = DateTimeCol(notNone=True, default=DateTimeCol.now)
    # Joins
    preguntas        = MultipleJoin('PreguntaExamen', joinColumn='examen_id', orderBy='numero')

    def periodo(self):
        return "%d.%d" % (self.anio,self.cuatrimestre)

    def str_fecha(self):
        return self.fecha.strftime("%d/%m/%Y")

    def __sort_preguntas(self):
        def comparar(pregunta1, pregunta2):
            return pregunta1.numero - pregunta2.numero
        return self.preguntas

    def update_pregunta(self, numero, dto):
        for pregunta in self.preguntas:
            if pregunta.numero == numero:
                pregunta.update(dto)

    def __str__(self):
        return "%s.%d (%s)" % (self.periodo(),self.oportunidad, self.str_fecha()) 

#}}}

class DTOPregunta:
        def __init__(self,texto,tipo,tema):
                self.texto = texto
                self.tipo = tipo
                self.tema = tema

class PreguntaExamen(SQLObject): #{{{
    # Clave
    numero           = IntCol(notNone=True)
    examen           = ForeignKey('ExamenFinal', cascade=True)
    pk               = DatabaseIndex(examen, numero, unique=True)
    # Campos
    texto            = UnicodeCol(length=500, default=None)
    # Joins
    tema             = ForeignKey('TemaPregunta', cascade=False, default = None)
    tipo             = ForeignKey('TipoPregunta', cascade=False, default = None)
    solucion         = ForeignKey('Solucion', cascade='null', default=None)


    def __init__(self, dto = None, **kw):
        if not dto is None:
            kw['texto'] = (dto.texto,'')[dto.texto is None]
            kw['temaID'] = dto.tema
            kw['tipoID'] = dto.tipo
	super(PreguntaExamen, self).__init__(**kw)

    def __str__(self):
        return '%s)%s' % (self.numero,self.texto)

    def update(self, dto):
        self.texto = dto.texto
        self.temaID = dto.tema
        self.tipoID = dto.tipo    

    def parse_preguntas(texto_preguntas, separador_num_preguntas):
        """
        separador_num_preguntas indica el string que viene luego de un numero de pregunta y antes del texto.
        Por ejemplo: ')', ' - ', '-', etc
	"""

        import re
        regex = re.compile('(\d+)' + re.escape(separador_num_preguntas))
        preguntas = {}
        indices_numero_texto = []
        
        for match in regex.finditer(texto_preguntas):
            indices_numero_texto.append( (match.start(),match.end()) )
        
        cant_preguntas = len(indices_numero_texto)
        for i in range(0,cant_preguntas):
            inicio_numero = indices_numero_texto[i][0]
            inicio_texto = indices_numero_texto[i][1]
            numero = int(texto_preguntas[inicio_numero:inicio_texto-1])
            if i+1 == cant_preguntas:
                fin_texto = len(texto_preguntas)
            else:
                fin_texto = indices_numero_texto[i+1][0]
            preguntas[numero] = texto_preguntas[inicio_texto:fin_texto]
        return preguntas
    
    def import_preguntas(archivo_preguntas,encoding_archivo,encoding_salida):
        """ 
        Se espera :
        fecha(dd/mm/yyy),anio,cuatrimestre,oportunidad,numero_pregunta,texto_pregunta,tipo.tema
        """
    
        import csv
        lineas = archivo_preguntas.read().split('\n')
        ok = []
        fail = []
        examenes = {}
        temas = dict([(t.descripcion, t) for t in TemaPregunta.select()])
        tipos = dict([(t.descripcion, t) for t in TipoPregunta.select()])
        for linea in lineas:
            for row in csv.reader([linea]):
                if row == []:
                    continue
                try:
                    fecha = datetime.strptime(row[0], "%d/%m/%Y")
                    anio = int(row[1])
                    cuatrimestre = int(row[2])
                    oportunidad = int(row[3])
                    numero = int(row[4])
                    texto = PreguntaExamen.__normalize_texto(row[5], encoding_archivo, encoding_salida)
                    descripcion_tipo = PreguntaExamen.__normalize_texto(row[6],encoding_archivo, encoding_salida)
                    descripcion_tema = PreguntaExamen.__normalize_texto(row[7],encoding_archivo, encoding_salida)
                    
                    examen = PreguntaExamen.__find_examen(fecha, anio, cuatrimestre, oportunidad, examenes)
                    tipo = PreguntaExamen.__find_tipo(descripcion_tipo, tipos)
                    tema = PreguntaExamen.__find_tema(descripcion_tema, temas)
                    u = PreguntaExamen(texto=texto, examen = examen, numero=numero, tipo=tipo, tema=tema)
                    ok.append(row)
                except Exception, e:
                    row.append(str(e))
                    fail.append(row)
        return (ok, fail)   

    def __normalize_texto(texto, encoding_entrada, encoding_salida):
        texto_unicode = texto.decode(encoding_entrada)
	return texto_unicode.encode(encoding_salida,'xmlcharrefreplace')
 
    def __find_examen(fecha, anio, cuatrimestre, oportunidad, examenes):
        key = (anio, cuatrimestre, oportunidad)
        examen = examenes.get(key)
        if examen is None:
            examen = ExamenFinal(fecha = fecha, anio = anio, cuatrimestre = cuatrimestre, oportunidad = oportunidad)
            examenes[key] = examen
        return examen

    def __find_tipo(descripcion, tipos):
        tipo = tipos.get(descripcion)
        if tipo is None:
            tipo = TipoPregunta(descripcion=descripcion)
            tipos[descripcion] = tipo
        return tipo

    def __find_tema(descripcion, temas):
        tema = temas.get(descripcion)
        if tema is None:
            tema = TemaPregunta(descripcion=descripcion)
            temas[descripcion] = tema
        return tema

    parse_preguntas = staticmethod(parse_preguntas)
    import_preguntas = staticmethod(import_preguntas)
    __normalize_texto = staticmethod(__normalize_texto)
    __find_examen = staticmethod(__find_examen)
    __find_tipo = staticmethod(__find_tipo)
    __find_tema = staticmethod(__find_tema)


#}}}

class TemaPregunta(SQLObject): #{{{
    # Clave
    descripcion            = UnicodeCol(length=100, default=None)
    pk              = DatabaseIndex(descripcion, unique=True)

#}}}

class TipoPregunta(SQLObject): #{{{
    # Clave
    descripcion            = UnicodeCol(length=100, default=None)
    pk              = DatabaseIndex(descripcion, unique=True)

#}}}

class Solucion(SQLObject): #{{{
    # Clave
    #pk              = DatabaseIndex(anio, cuatrimestre, numero, unique=True)
    # Campos
    descripcion     = UnicodeCol(length=1000, default=None)
    # Joins
    preguntas       = MultipleJoin('PreguntaExamen')


#}}}

#}}}

class Curso(SQLObject): #{{{
    orderByClause = '-anio'
    class sqlmeta:
        defaultOrder='-anio,-cuatrimestre,numero'

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
            self.add_ejercicio(n+1, e)
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

    def get_grupos_con_alumno(self, alumno):
        #workaround para evitar problemas con relacion Miembro-AlumnoInscripto durante armado de query.
        inscriptos = AlumnoInscripto.select(AND(AlumnoInscripto.q.cursoID == self.id, AlumnoInscripto.q.alumnoID == alumno.id))
        return Grupo.select(AND(Grupo.q.cursoID == self.id,
            Miembro.q.grupoID == Grupo.q.id, 
            IN(Miembro.q.alumnoID, validate_in([i.id for i in inscriptos]) ),
            Miembro.q.baja == None
            ))

    @classmethod
    def activos(cls):
        now = datetime.now()
        if 3 <= now.month <= 7: # marzo a junio inclusive
            cuatrimestre = 1
        else: # agosto a febrero inclusive
            cuatrimestre = 2
        return cls.selectBy(anio=now.year, cuatrimestre=cuatrimestre)

    def __unicode__(self):
        return u'%s.%s.%s' % (self.anio, self.cuatrimestre, self.numero)

    def __repr__(self):
        return 'Curso(id=%r, anio=%r, cuatrimestre=%r, numero=%r, ' \
            'descripcion=%r)' \
                % (self.id, self.anio, self.cuatrimestre, self.numero,
                    self.descripcion)

    def shortrepr(self):
        return '%r.%r.%r' % (self.anio, self.cuatrimestre, self.numero)

    def __cmp__(self,other):
        cmpAnio = cmp(self.anio, other.anio)
        if cmpAnio == 0:
            return cmp(self.cuatrimestre, other.cuatrimestre)
        else:
            return cmpAnio
#}}}

class Usuario(InheritableSQLObject): #{{{
    # Clave (para docentes puede ser un nombre de usuario arbitrario)
    usuario         = UnicodeCol(length=10, alternateID=True,
                        alternateMethodName='by_usuario')
    # Campos
    contrasenia     = UnicodeCol(length=255, default=None)
    nombre          = UnicodeCol(length=255, notNone=True)
    email           = StringCol(length=255, default=None)
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

    def get_curso_default(self):
        cursos = self.cursos
        if len(cursos) == 0:
            return None
        else:
            return cursos[0]

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
    def byUsuario(cls, usuario): # TODO eliminar, backward compat
        return cls.by_usuario(usuario)

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

    def __unicode__(self):
        return u'%s (%s)' % (self.usuario, self.nombre)

    def __repr__(self):
        raise NotImplementedError(_(u'Clase abstracta!'))

    def shortrepr(self):
        return '%r (%r)' % (self.usuario, self.nombre)
#}}}

class Docente(Usuario): #{{{
    _inheritable = False
    # Campos
    nombrado        = BoolCol(notNone=True, default=True)
    # Joins
    enunciados      = MultipleJoin('Enunciado', joinColumn='autor_id')
    inscripciones   = MultipleJoin('DocenteInscripto')

    def _get_cursos(self):
        return list(Curso.select(
                AND(Curso.q.id == DocenteInscripto.q.cursoID,
                    self.id == DocenteInscripto.q.docenteID
                )).orderBy(Curso.orderByClause))

    def _get_inscripciones_activas(self):
        return list(DocenteInscripto.select(
                AND(
                    IN(Curso.q.id, [0]+[c.id for c in Curso.activos()]),
                    Curso.q.id == DocenteInscripto.q.cursoID,
                    self.id == DocenteInscripto.q.docenteID,
                )))
   #TODO ver si se utiliza, borrar si no es asi. Chequear InstanciaDeEntrega.activas tmb 
    def _get_instancias_a_corregir(self):
        cursos = [di.curso for di in self.inscripciones_activas]
        return InstanciaDeEntrega.activas(cursos)

    def get_inscripcion(self, curso):
        return DocenteInscripto.pk.get(curso,self)

    def corregir(self, entregador, instancia):
        curso = instancia.ejercicio.curso

        # Veo si ya existe una Correccion
        try:
            return Correccion.pk.get(instancia=instancia, entregador=entregador)
        except SQLObjectNotFound:
            # Si no existe, trato de crear una
            entregas = entregador.entregas_de(instancia)
            if not entregas:
                # TODO: soportar correcciones sin entregas (puede pasar)
                raise AlumnoSinEntregas(entregador,instancia)
            corrector = self.get_inscripcion(curso)
            return Correccion(entregador=entregador,
                    instancia=instancia, entrega=entregas[0],
                    corrector=corrector,
                    asignado=DateTimeCol.now())
    
    def add_entrega(self, instancia, **kw):
        return Entrega(instancia=instancia, **kw)

    def add_enunciado(self, nombre, anio, cuatrimestre, **kw):
        return Enunciado(nombre=nombre, anio=anio, cuatrimestre=cuatrimestre,
            autor=self, **kw)

    def remove_enunciado(self, nombre, anio, cuatrimestre):
        Enunciado.pk.get(nombre, anio, cuatrimestre).destroySelf()

    def __repr__(self):
        return 'Docente(id=%r, usuario=%r, nombre=%r, password=%r, email=%r, ' \
            'telefono=%r, activo=%r, creado=%r, observaciones=%r)' \
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

    def _get_cursos(self):
        return list(Curso.select(
                AND(Curso.q.id == AlumnoInscripto.q.cursoID,
                    self.id == AlumnoInscripto.q.alumnoID
                )).orderBy(Curso.orderByClause))

    def _get_padron(self): # alias para poder referirse al alumno por padron
        return self.usuario

    def _set_padron(self, padron):
        self.usuario = padron

    @classmethod
    def byPadron(cls, padron): # TODO eliminar, backward compat
        return cls.byUsuario(unicode(padron))

    @classmethod
    def by_padron(cls, padron):
        return cls.by_usuario(unicode(padron))

    def __cmp__(self,other):
        return cmp(self.padron,other.padron)

    def __repr__(self):
        return 'Alumno(id=%r, padron=%r, nombre=%r, password=%r, email=%r, ' \
            'telefono=%r, activo=%r, creado=%r, observaciones=%r)' \
                % (self.id, self.padron, self.nombre, self.password, self.email,
                    self.telefono, self.activo, self.creado, self.observaciones)
#}}}

class Tarea(InheritableSQLObject): #{{{
    # Clave
    nombre              = UnicodeCol(length=30, alternateID=True)
    # Campos
    descripcion         = UnicodeCol(length=255, default=None)
    # Joins
    enunciados          = RelatedJoin('Enunciado', addRemoveName='_enunciado')

    def __unicode__(self):
        return self.nombre

    def __repr__(self):
        raise NotImplementedError('Tarea es una clase abstracta')

    def shortrepr(self):
        return repr(self.nombre)
#}}}

class TareaFuente(Tarea): #{{{
    _inheritable = False
    # Joins
    comandos    = MultipleJoin('ComandoFuente', joinColumn='tarea_id')

    def add_comando(self, orden, comando, **kw):
        return ComandoFuente(tarea=self, orden=orden, comando=comando, **kw)

    def remove_comando(self, orden):
        ComandoFuente.pk.get(self.id, orden).destroySelf()

    def __repr__(self):
        return 'TareaFuente(id=%r, nombre=%r, descripcion=%r)' \
                % (self.id, self.nombre, self.descripcion)
#}}}

class TareaPrueba(Tarea): #{{{
    _inheritable = False
    # Joins
    comandos    = MultipleJoin('ComandoPrueba', joinColumn='tarea_id')

    def add_comando(self, orden, comando='', **kw):
        return ComandoPrueba(tarea=self, orden=orden, comando=comando, **kw)

    def remove_comando(self, orden):
        ComandoPrueba.pk.get(self.id, orden).destroySelf()

    def __repr__(self):
        return 'TareaPrueba(id=%r, nombre=%r, descripcion=%r)' \
                % (self.id, self.nombre, self.descripcion)
#}}}

class Comando(InheritableSQLObject): #{{{
    # Tipos de retorno especiales
    RET_ANY = None
    RET_FAIL = -256
    # Archivos especiales
    STDIN = '__stdin__'
    STDOUT = '__stdout__'
    STDERR = '__stderr__'
    STDOUTERR = '__stdouterr__'
    # Campos
    comando             = UnicodeCol(length=255, notNone=True)
    descripcion         = UnicodeCol(length=255, default=None)
    retorno             = IntCol(default=None) # Ver RET_XXX y si es negativo
                                               # se espera una señal
    max_tiempo_cpu      = IntCol(default=None) # En segundos
    max_memoria         = IntCol(default=None) # En MB
    max_tam_archivo     = IntCol(default=None) # En MB
    max_cant_archivos   = IntCol(default=None)
    max_cant_procesos   = IntCol(default=None)
    max_locks_memoria   = IntCol(default=None)
    terminar_si_falla   = BoolCol(notNone=True, default=True)
    rechazar_si_falla   = BoolCol(notNone=True, default=True)
    publico             = BoolCol(notNone=True, default=True)
    # ZIP con archivos de entrada __stdin__ es caso especial Si un caso de
    # prueba tiene comandos que tiene algún archivo de entrada (incluyendo
    # stdin) con los propios, se usa el archivo del caso de prueba, no del
    # comando.
    archivos_entrada    = BLOBCol(default=None, length=BLOB_SIZE)
    # ZIP con archivos de salida __stdout__, __stderr__ y __stdouterr__ (ambos
    # juntos) son casos especiales Si un caso de prueba tiene comandos que
    # tiene algún archivo a comparar (incluyendo stdout/err) con los propios,
    # se compara contra el archivo del caso de prueba, no del comando.
    archivos_a_comparar = BLOBCol(default=None, length=BLOB_SIZE)
    # TODO FrozenSetCol __stdout__, __stderr__ y __stdouterr__ (ambos juntos)
    # son casos especiales
    archivos_a_guardar  = TupleCol(notNone=True, default=(), length=BLOB_SIZE)
    activo              = BoolCol(notNone=True, default=True)

    def __unicode__(self):
        return u'%s (%s)' % (self.comando, self.descripcion)

    def __repr__(self, clave='', mas=''):
        return ('%s(%s comando=%r, descripcion=%r, retorno=%r, '
            'max_tiempo_cpu=%r, max_memoria=%r, max_tam_archivo=%r, '
            'max_cant_archivos=%r, max_cant_procesos=%r, max_locks_memoria=%r, '
            'terminar_si_falla=%r, rechazar_si_falla=%r%s)'
                % (self.__class__.__name__, clave, self.comando,
                    self.descripcion, self.retorno, self.max_tiempo_cpu,
                    self.max_memoria, self.max_tam_archivo,
                    self.max_cant_archivos, self.max_cant_procesos,
                    self.max_locks_memoria, self.terminar_si_falla,
                    self.rechazar_si_falla, mas))

    def shortrepr(self):
        return '%r (%r)' % (self.comando, self.descripcion)
#}}}

class ComandoFuente(Comando): #{{{
    _inheritable = False
    # Clave
    tarea       = ForeignKey('TareaFuente', notNone=True, cascade=True)
    orden       = IntCol(notNone=True)
    pk          = DatabaseIndex(tarea, orden, unique=True)

    def __unicode__(self):
        return u'%s:%s (%s)' % (self.tarea, self.orden, self.comando)

    def __repr__(self):
        return super(ComandoFuente, self).__repr__('tarea=%s, orden=%r'
            % (srepr(self.tarea), self.orden))

    def shortrepr(self):
        return '%s:%r (%r)' % (srepr(self.tarea), self.orden, self.comando)
#}}}

class ComandoPrueba(Comando): #{{{
    _inheritable = False
    RET_PRUEBA = -257 # Espera el mismo retorno que el de la prueba.
    # XXX todos los campos de limitación en este caso son multiplicadores para
    # los valores del caso de prueba.
    # Clave
    tarea               = ForeignKey('TareaPrueba', notNone=True, cascade=True)
    orden               = IntCol(notNone=True)
    pk                  = DatabaseIndex(tarea, orden, unique=True)

    def __unicode__(self):
        return u'%s:%s (%s)' % (self.tarea, self.orden, self.comando)

    def __repr__(self):
        return super(ComandoPrueba, self).__repr__('tarea=%s, orden=%r'
            % (srepr(self.tarea), self.orden))

    def shortrepr(self):
        return '%s:%r (%r)' % (srepr(self.tarea), self.orden, self.comando)
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
    archivos        = BLOBCol(default=None, length=BLOB_SIZE)
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
    def selectByCurso(cls, curso):
        return cls.selectBy(cuatrimestre=curso.cuatrimestre, anio=curso.anio)

    def add_caso_de_prueba(self, nombre, **kw):
        return CasoDePrueba(enunciado=self, nombre=nombre, **kw)

    def __unicode__(self):
        return self.nombre

    def __repr__(self):
        return 'Enunciado(id=%r, autor=%s, nombre=%r, descripcion=%r, ' \
            'creado=%r)' \
                % (self.id, srepr(self.autor), self.nombre, self.descripcion, \
                    self.creado)

    def shortrepr(self):
        return repr(self.nombre)
#}}}

class CasoDePrueba(Comando): #{{{
    _inheritable = False
    # Clave
    enunciado           = ForeignKey('Enunciado', cascade=True)
    nombre              = UnicodeCol(length=40, notNone=True)
    pk                  = DatabaseIndex(enunciado, nombre, unique=True)
    # Joins
    pruebas             = MultipleJoin('Prueba')

    def __unicode__(self):
        return u'%s:%s' % (self.enunciado, self.nombre)

    def __repr__(self):
        return super(CasoDePrueba, self).__repr__('enunciado=%s, nombre=%r'
            % (srepr(self.enunciado), self.nombre))

    def shortrepr(self):
        return '%s:%r' % (srepr(self.enunciado), self.nombre)
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

    def _get_instancias_a_entregar(self):
        now = DateTimeCol.now()
        return InstanciaDeEntrega.select(AND(
                InstanciaDeEntrega.q.ejercicioID == self.id,
                InstanciaDeEntrega.q.activo == True,
                InstanciaDeEntrega.q.inicio <= now,
                InstanciaDeEntrega.q.fin >= now))

    def get_posibles_entregadores(self):
        if self.grupal:
            entregadores = list(self.curso.grupos)
            entregadores.sort(lambda x,y:cmp(x.nombre,y.nombre))
        else:
            entregadores = list(self.curso.alumnos)
            entregadores.sort(lambda x,y:cmp(x.alumno.padron, y.alumno.padron))
        return entregadores

    def __unicode__(self):
        return u'(%s, %s, %s)' % (self.curso, self.numero, self.enunciado)

    def __repr__(self):
        return 'Ejercicio(id=%r, curso=%s, numero=%r, enunciado=%s, ' \
            'grupal=%r)' \
                % (self.id, srepr(self.curso), self.numero,
                    srepr(self.enunciado), self.grupal)

    def shortrepr(self):
        return '(%s, %r, %s)' \
            % (srepr(self.curso), self.numero, srepr(self.enunciado))
#}}}

class InstanciaDeEntrega(SQLObject): #{{{
    # Clave
    ejercicio       = ForeignKey('Ejercicio', notNone=True, cascade=True)
    numero          = IntCol(notNone=True)
    pk              = DatabaseIndex(ejercicio, numero, unique=True)
    # Campos
    inicio          = DateTimeCol(notNone=True)
    fin             = DateTimeCol(notNone=True)
    inicio_proceso  = DateTimeCol(default=None)
    fin_proceso     = DateTimeCol(default=None)
    observaciones   = UnicodeCol(notNone=True, default=u'')
    activo          = BoolCol(notNone=True, default=True)
    # Joins
    entregas        = MultipleJoin('Entrega', joinColumn='instancia_id')
    correcciones    = MultipleJoin('Correccion', joinColumn='instancia_id')

    @classmethod
    def activas(cls, cursos=None):
        if cursos is None:
            cursos = Curso.activos()
        now = DateTimeCol.now()
        return list(cls.select(
                AND(
                    cls.q.ejercicioID == Ejercicio.q.id,
                    cls.q.fin <= now,
                    IN(Ejercicio.q.cursoID, [0]+[c.id for c in cursos]),
                )))

    def get_resumen_entregas(self):
        entregadores = self.ejercicio.get_posibles_entregadores()
        entregas = dict([(e,[]) for e in entregadores])
        correcciones = dict([(e,None) for e in entregadores])
        for e in self.entregas:
            entregas[e.entregador].append(e)
        for c in self.correcciones:
            correcciones[c.entregador] = c
        return [DTOResumenEntrega(e, entregas[e], correcciones[e]) for e in entregadores]

    def __unicode__(self):
        return unicode(self.shortrepr())

    def __repr__(self):
        return 'InstanciaDeEntrega(id=%r, numero=%r, inicio=%r, fin=%r, ' \
            'inicio_proceso=%r, fin_proceso=%r, observaciones=%r, activo=%r)' \
                % (self.id, self.numero, self.inicio, self.fin,
                    self.inicio_proceso, self.fin_proceso, self.observaciones,
                    self.activo)

    def longrepr(self):
        return u'Curso: %s - Ejer: %s' % (self.ejercicio.curso,self.shortrepr()) 

    def numerorepr(self):
        return "%s.%s" % (self.ejercicio.numero, self.numero)

    def shortrepr(self):
        return "%s (%s)" % (self.numerorepr(),self.ejercicio.enunciado.nombre)
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

    def __unicode__(self):
        return unicode(self.docente)

    def __repr__(self):
        return 'DocenteInscripto(id=%r, docente=%s, corrige=%r, ' \
            'observaciones=%r' \
                % (self.id, srepr(self.docente), self.corrige,
                    self.observaciones)

    def shortrepr(self):
        return srepr(self.docente)
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

    def entregas_de(self, instancia, order_by=None):
        if order_by is None:
            order_by = -Entrega.q.fecha
        return list(Entrega.selectBy(entregador=self, instancia=instancia)
                .orderBy(order_by))

    def correccion_de(self, instancia):
        try:
            return Correccion.selectBy(entregador=self, instancia=instancia) \
                    .getOne()
        except SQLObjectNotFound:
            return None

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

    def tiene_acceso(self, usuario):
        #chequamos si el usuario es alguno de los alumnos en la lista de alumnoincriptos
        return usuario in [a.alumno for a in self.alumnos]

    def add_miembro(self, alumno, **kw):
        if isinstance(alumno, AlumnoInscripto):
            alumno = alumno.id
        # FIXME acá habría que sacarle la unicidad a Miembro.pk para que
        # un alumno pueda ser miembro varias veces del mismo grupo, de
        # manera de tener la historia completa, pero hay que tener cuidad
        # y arreglar todos los lugares donde se asume esa unicidad
        try:
            m = Miembro.selectBy(grupo=self, alumnoID=alumno).getOne()
            m.baja = None # si ya existía, le sacamos la fecha de baja
            return m
        except SQLObjectNotFound: # creo uno nuevo
            return Miembro(grupo=self, alumnoID=alumno, **kw)

    def remove_miembro(self, alumno):
        if isinstance(alumno, AlumnoInscripto):
            alumno = alumno.id
        m = Miembro.selectBy(grupo=self, alumnoID=alumno, baja=None).getOne()
        m.baja = DateTimeCol.now()

    def add_tutor(self, docente, **kw):
        if isinstance(docente, DocenteInscripto):
            docente = docente.id
        # FIXME ídem add_miembro()
        try:
            t = Tutor.selectBy(grupo=self, docenteID=docente).getOne()
            t.baja = None # si ya existía, le sacamos la fecha de baja
            return t
        except SQLObjectNotFound: # creo uno nuevo
            return Tutor(grupo=self, docenteID=docente, **kw)

    def remove_tutor(self, docente):
        if isinstance(docente, DocenteInscripto):
            docente = docente.id
        t = Tutor.selectBy(grupo=self, docenteID=docente, baja=None)
        t.baja = DateTimeCol.now()

    @classmethod
    def selectByAlumno(self, alumno):
        #TODO falta filtrar por grupo
        return Miembro.select(AND(Miembro.q.alumnoID == AlumnoInscripto.q.id,
                AlumnoInscripto.q.alumnoID == alumno.id, Miembro.q.baja == None))

    def __unicode__(self):
        return unicode(self.shortrepr())

    def __repr__(self):
        return 'Grupo(id=%r, nombre=%r, responsable=%s, nota=%r, ' \
            'nota_cursada=%r, observaciones=%r, activo=%r)' \
                % (self.id, self.nombre, srepr(self.responsable), self.nota,
                    self.nota_cursada, self.observaciones, self.activo)

    def shortrepr(self):
        return '%s (grupo)' % self.nombre
#}}}

class AlumnoInscripto(Entregador): #{{{
    _inheritable = False
    # Clave
    curso               = ForeignKey('Curso', notNone=True, cascade=True)
    alumno              = ForeignKey('Alumno', notNone=True, cascade=True)
    pk                  = DatabaseIndex(curso, alumno, unique=True)
    # Campos
    condicional         = BoolCol(notNone=True, default=False)
    tutor               = ForeignKey('DocenteInscripto', default=None,
                                        cascade='null')
    # Joins
    responsabilidades   = MultipleJoin('Grupo', joinColumn='responsable_id')
    membresias          = MultipleJoin('Miembro', joinColumn='alumno_id')
    entregas            = MultipleJoin('Entrega', joinColumn='alumno_id')
    correcciones        = MultipleJoin('Correccion', joinColumn='alumno_id')
    # Notas de la cursada
    nota_practica       = DecimalCol(size=3, precision=1, default=None)
    nota_final          = DecimalCol(size=3, precision=1, default=None)
    nota_libreta        = DecimalCol(size=3, precision=1, default=None)

    def _get_nombre(self):
        return self.alumno.padron

    def _get_padron(self):
        return self.alumno.padron

    def tiene_acceso(self, usuario):
        return self.alumno == usuario

    @classmethod
    def selectByAlumno(self, alumno):
        return AlumnoInscripto.select(AlumnoInscripto.q.alumnoID
                                        == alumno.id).getOne()

    def __unicode__(self):
        return unicode(self.alumno)

    def __repr__(self):
        return 'AlumnoInscripto(id=%r, alumno=%s, condicional=%r, nota=%r, ' \
            'nota_cursada=%r, tutor=%s, observaciones=%r, activo=%r)' \
                % (self.id, srepr(self.alumno), self.condicional,
                    self.nota, self.nota_cursada, srepr(self.tutor),
                    self.observaciones, self.activo)

    def shortrepr(self):
        return srepr(self.alumno)
#}}}

class Tutor(SQLObject): #{{{
    # Clave
    grupo           = ForeignKey('Grupo', notNone=True, cascade=True)
    docente         = ForeignKey('DocenteInscripto', notNone=True, cascade=True)
    pk              = DatabaseIndex(grupo, docente, unique=True)
    # Campos
    alta            = DateTimeCol(notNone=True, default=DateTimeCol.now)
    baja            = DateTimeCol(default=None)

    def __unicode__(self):
        return u'%s-%s' % (self.docente, self.grupo)

    def __repr__(self):
        return 'Tutor(docente=%s, grupo=%s, alta=%r, baja=%r)' \
                % (srepr(self.docente), srepr(self.grupo), self.alta, self.baja)

    def shortrepr(self):
        return '%s-%s' % (srepr(self.docente), srepr(self.grupo))
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

    def __unicode__(self):
        return u'%s-%s' % (self.alumno, self.grupo)

    def __repr__(self):
        return 'Miembro(alumno=%s, grupo=%s, nota=%r, alta=%r, baja=%r)' \
                % (srepr(self.alumno), srepr(self.grupo), self.nota, self.alta,
                        self.baja)

    def shortrepr(self):
        return '%s-%s' % (srepr(self.alumno), srepr(self.grupo))
#}}}

class Ejecucion(InheritableSQLObject): #{{{
    # Campos
    inicio          = DateTimeCol(default=None)
    fin             = DateTimeCol(default=None)
    exito           = IntCol(default=None)
    observaciones   = UnicodeCol(notNone=True, default=u'')
    archivos        = BLOBCol(default=None, length=BLOB_SIZE) # ZIP con archivos

    def _get_duracion(self):
        """retorna un timedelta con la duracion de la tarea"""
        if self.fin:
            return self.fin - self.inicio;
        else:
            return None #timedelta()

    def get_archivos_nombres(self):
       return unzip_filenames(self.archivos)

    def __repr__(self, clave='', mas=''):
        return ('%s(%s inicio=%r, fin=%r, exito=%r, observaciones=%r%s)'
            % (self.__class__.__name__, clave, self.inicio, self.fin,
            self.exito, self.observaciones, mas))
#}}}

class Entrega(Ejecucion): #{{{
    class sqlmeta:
        defaultOrder = '-fecha'

    _inheritable = False
    # Clave
    instancia           = ForeignKey('InstanciaDeEntrega', notNone=True, cascade=False)
    entregador          = ForeignKey('Entregador', default=None, cascade=False)
    fecha               = DateTimeCol(notNone=True, default=DateTimeCol.now)
    pk                  = DatabaseIndex(instancia, entregador, fecha, unique=True)
    # Joins
    comandos_ejecutados = MultipleJoin('ComandoFuenteEjecutado')
    pruebas             = MultipleJoin('Prueba')

    def _get_pruebas_publicas(self):
        return Prueba.select(AND(Prueba.q.entregaID == self.id, Prueba.q.caso_de_pruebaID == CasoDePrueba.q.id, CasoDePrueba.q.publico == True))

    def get_pruebas_visibles(self,usuario):
        if Permiso.admin in usuario.permisos:
            return self.pruebas
        else:
            return self.pruebas_publicas

    def validar_acceso(self, usuario):
        if Permiso.admin not in usuario.permisos:
            if not self.entregador.tiene_acceso(usuario):
                raise UsuarioSinPermisos(usuario)
 

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

    def make_correccion(self, corrector, **kw):
        return Correccion(instancia=self.instancia, entregador=self.entregador,
            entrega=self, corrector=corrector, **kw)

    def __unicode__(self):
        return u'%s-%s-%s' % (self.instancia, self.entregador, self.fecha)

    def __repr__(self):
        return super(Entrega, self).__repr__('instancia=%s, entregador=%s, '
            'fecha=%r' % (srepr(self.instancia), srepr(self.entregador),
                self.fecha))

    def shortrepr(self):
        return '%s-%s-%r' % (srepr(self.instancia), srepr(self.entregador),
                self.fecha)
#}}}

class Correccion(SQLObject): #{{{
    # Clave
    instancia       = ForeignKey('InstanciaDeEntrega', notNone=True, cascade=False)
    entregador      = ForeignKey('Entregador', notNone=True, cascade=False) 
    pk              = DatabaseIndex(instancia, entregador, unique=True)
    # Campos
    entrega         = ForeignKey('Entrega', notNone=True, cascade=False)
    corrector       = ForeignKey('DocenteInscripto', notNone=True, cascade=False)
    asignado        = DateTimeCol(notNone=True, default=DateTimeCol.now)
    corregido       = DateTimeCol(default=None)
    nota            = DecimalCol(size=3, precision=1, default=None)
    observaciones   = UnicodeCol(default=None)

    def _get_entregas(self):
        return list(Entrega.selectBy(instancia=self.instancia,
                entregador=self.entregador).orderBy(-Entrega.q.fecha))

    def __unicode__(self):
        if not self.corrector:
            return u'%s' % self.entrega
        return u'%s,%s' % (self.entrega, self.corrector)

    def __repr__(self):
        return 'Correccion(instancia=%s, entregador=%s, entrega=%s, ' \
            'corrector=%r, asignado=%r, corregido=%r, nota=%r, ' \
            'observaciones=%r)' \
                % (srepr(self.instancia), srepr(self.entregador),
                    srepr(self.entrega), self.corrector, self.asignado,
                    self.corregido, self.nota, self.observaciones)

    def shortrepr(self):
        if not self.corrector:
            return '%s' % srepr(self.entrega)
        return '%s,%s' % (srepr(self.entrega), srepr(self.corrector))
#}}}

class ComandoEjecutado(Ejecucion): #{{{
    # Campos
    # ZIP con archivos guardados
    diferencias = BLOBCol(default=None, length=BLOB_SIZE)

    def __repr__(self, clave='', mas=''):
        return super(ComandoEjecutado, self).__repr__(clave, mas)
#}}}

class ComandoFuenteEjecutado(ComandoEjecutado): #{{{
    _inheritable = False
    # Clave
    comando = ForeignKey('ComandoFuente', notNone=True, cascade=False)
    entrega = ForeignKey('Entrega', notNone=True, cascade=False)
    pk      = DatabaseIndex(comando, entrega, unique=True)

    def validar_acceso(self, usuario):
        self.entrega.validar_acceso(usuario)

    def __unicode__(self):
        return u'%s-%s' % (self.comando, self.entrega)

    def __repr__(self):
        return super(ComandoFuenteEjecutado, self).__repr__(
            'comando=%s, entrega=%s' % (srepr(self.comando),
                srepr(self.entrega)))

    def shortrepr(self):
        return '%s-%s' % (srepr(self.comando), srepr(self.entrega))
#}}}

class ComandoPruebaEjecutado(ComandoEjecutado): #{{{
    _inheritable = False
    # Clave
    comando = ForeignKey('ComandoPrueba', notNone=True, cascade=True)
    prueba  = ForeignKey('Prueba', notNone=True, cascade=True)
    pk      = DatabaseIndex(comando, prueba, unique=True)

    def validar_acceso(self, usuario):
        self.prueba.validar_acceso(usuario)

    def __unicode__(self):
        return u'%s:%s:%s' % (self.tarea, self.prueba, self.caso_de_prueba)

    def __repr__(self):
        return super(ComandoPruebaEjecutado, self).__repr__(
            'comando=%s, prueba=%s' % (srepr(self.comando),
                srepr(self.prueba)))

    def shortrepr(self):
        return '%s:%s:%s' % (srepr(self.tarea), srepr(self.prueba),
            srepr(self.caso_de_prueba))
#}}}

class Prueba(ComandoEjecutado): #{{{
    _inheritable = False
    # Clave
    entrega             = ForeignKey('Entrega', notNone=True, cascade=False)
    caso_de_prueba      = ForeignKey('CasoDePrueba', notNone=True, cascade=True)
    pk                  = DatabaseIndex(entrega, caso_de_prueba, unique=True)
    # Joins
    comandos_ejecutados = MultipleJoin('ComandoPruebaEjecutado')

    def validar_acceso(self, usuario):
        self.entrega.validar_acceso(usuario)

    def add_comando_ejecutado(self, comando, **kw):
        if isinstance(comando, ComandoPrueba):
            comando = comando.id
        return ComandoPruebaEjecutado(prueba=self, comandoID=comando, **kw)

    def remove_comando_ejecutado(self, comando):
        if isinstance(comando, ComandoPrueba):
            comando = comando.id
        # FIXME self.id, comando.id
        ComandoPruebaEjecutado.pk.get(self.id, comando).destroySelf()

    def __unicode__(self):
        return u'%s:%s' % (self.entrega, self.caso_de_prueba)

    def __repr__(self):
        return super(Prueba, self).__repr__('entrega=%s, caso_de_prueba=%s'
            % (srepr(self.entrega), srepr(self.caso_de_prueba)))

    def shortrepr(self):
        return '%s:%s' % (srepr(self.entrega), srepr(self.caso_de_prueba))
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
    permisos    = TupleCol(notNone=True, length=BLOB_SIZE)
    # Joins
    usuarios    = RelatedJoin('Usuario', addRemoveName='_usuario')

    def by_group_name(self, name): # para identity
        return self.by_nombre(name)
    
    def _get_group_name(self): # alias para identity
        return self.nombre

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

    def __eq__(self, other):
        return self.valor == other.valor

    def __ne__(self, other):
        return not self.__eq__(other)

    def __hash__(self):
        return hash(self.valor)

    def __repr__(self):
        return repr(self.nombre)

Permiso.entregar_tp = Permiso(u'entregar', u'Permite entregar trabajos prácticos')
Permiso.admin = Permiso(u'admin', u'Permite hacer ABMs arbitrarios')
Permiso.corregir = Permiso(u'corregir', u'Permite corregir ejercicios')
Permiso.alumno_editar = Permiso(u'alumno_editar', u'Permite editar datos de alumnos')
Permiso.alumno_eliminar = Permiso(u'alumno_eliminar', u'Permite eliminar alumnos')
Permiso.enunciado_editar = Permiso(u'enunciado_editar', u'Permite editar datos de enunciados')
Permiso.enunciado_eliminar = Permiso(u'enunciado_eliminar', u'Permite eliminar enunciados')

#}}}

#}}} Identity

#}}} Clases

