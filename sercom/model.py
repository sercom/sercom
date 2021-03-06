# vim: set et sw=4 sts=4 encoding=utf-8 foldmethod=marker :

from turbojson import jsonify
from datetime import datetime
from turbogears.database import PackageHub
from sqlobject import *
from sqlobject.sqlbuilder import *
from sqlobject.inheritance import InheritableSQLObject
from sqlobject.col import PickleValidator, UnicodeStringValidator
from turbogears import identity, config
from turbogears.identity import encrypt_password as encryptpw
from formencode import Invalid
from ziputil import *
from domain import *
import hashlib

hub = PackageHub("sercom")
__connection__ = hub

__all__ = ('Curso', 'Usuario', 'Docente', 'Alumno', 'CasoDePrueba', 'Grupo')

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

class Imagen(SQLObject): #{{{
    #Clave
    nombre           = UnicodeCol(length=200, unique=True, notNone=True)
    pk               = DatabaseIndex(nombre, unique=True)

    #Campos
    tamanio          = IntCol(notNone=True)
    fecha            = DateTimeCol(notNone=True, default=DateTimeCol.now)
    nombre_archivo   = UnicodeCol(length=255, notNone=True)
    tipo_de_contenido= UnicodeCol(length=255, notNone=True)
    contenido        = BLOBCol(notNone=True, length=BLOB_SIZE)
 #}}}

class PreguntaExamen(SQLObject): #{{{
    # Clave
    numero           = IntCol(notNone=True)
    examen           = ForeignKey('ExamenFinal', cascade=True)
    pk               = DatabaseIndex(examen, numero, unique=True)
    # Campos
    texto            = UnicodeCol(length=5000, default=None)
    # Joins
    tema             = ForeignKey('TemaPregunta', cascade=False, default = None)
    tipo             = ForeignKey('TipoPregunta', cascade=False, default = None)
    respuestas       = MultipleJoin('Respuesta', joinColumn='pregunta_id')


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

    def tiene_respuestas_por_usuario(self, usuario):
        return (len(self.get_respuestas_por_usuario(usuario)) > 0)
 
    def get_respuestas_por_usuario(self, usuario):
        if usuario and usuario.has_any_permiso(Permiso.examen.respuesta.revisar):
            return list(self.respuestas)
        else:
            return list(r for r in self.respuestas if r.revisada or r.autor == usuario)

    def add_respuesta(self, texto, usuario):
        autor = usuario
        respuesta = Respuesta(texto=texto, pregunta=self, revisada=False, autor=autor)
        self.respuestas.append(respuesta)

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

class Respuesta(SQLObject): #{{{
    # Campos
    texto           = UnicodeCol(length=5000, notNone=True)
    # Joins
    pregunta        = ForeignKey('PreguntaExamen', cascade=True, notNone=True)
    revisada        = BoolCol(notNone=True)
    autor           = ForeignKey('Usuario', cascade=False, notNone=True)

    @classmethod
    def get_pendientes_de_revision(cls):
        return cls.selectBy(revisada = False)

    def puede_ser_editado_por_usuario(self, usuario):
        return usuario and (self.autor == usuario or usuario.has_any_permiso(Permiso.examen.respuesta.revisar))

    def validar_acceso(self, usuario):
        if not self.puede_ser_editado_por_usuario(usuario):
            raise UsuarioSinPermisos(usuario)

    def revisar(self, revisada):
        self.revisada = revisada

    def change_texto(self, texto, usuario):
        self.texto = texto
        if not usuario.has_any_permiso(Permiso.examen.respuesta.revisar):
            self.revisada = False

#}}}

#}}}

class Curso(SQLObject): #{{{
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
    instancias_de_evaluacion_alumno = MultipleJoin('InstanciaDeEvaluacionAlumno')

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

    def _get_inscripcion_abierta(self):
        return bool(config.get('inscripcion_abierta'))

    def add_docente(self, docente, **kw):
        if isinstance(docente, Docente):
            kw['docente'] = docente
        else:
            kw['docenteID'] = docente
        return DocenteInscripto(curso=self, **kw)

    def remove_docente(self, docente):
        if isinstance(docente, Docente):
            docente = docente.id
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
        AlumnoInscripto.pk.get(self.id, alumno).destroySelf()

    def add_grupo(self, nombre, **kw):
        return Grupo(curso=self, nombre=unicode(nombre), **kw)

    def remove_grupo(self, nombre):
        Grupo.pk.get(self.id, nombre).destroySelf()

    def add_ejercicio(self, numero, enunciado, **kw):
        if isinstance(enunciado, Enunciado):
            kw['enunciado'] = enunciado
        else:
            kw['enunciadoID'] = enunciado
        return Ejercicio(curso=self, numero=numero, **kw)

    def remove_ejercicio(self, numero):
        Ejercicio.pk.get(self.id, numero).destroySelf()

    def _get_ejercicios_activos(self):
        return [e for e in self.ejercicios if e.instancias_a_entregar.count() > 0]

    def _get_instancias_examinacion_a_corregir(self):
        return [i for i in self.instancias_de_evaluacion_alumno + self.instancias_de_entrega if i.activo]

    def _get_instancias_de_entrega(self):
        return list(InstanciaExaminacion.select(
                        AND(
                            InstanciaDeEntrega.q.ejercicioID == Ejercicio.q.id,
                            Ejercicio.q.cursoID == self.id
                        )))

    def get_cursos_anteriores(self):
        return list(Curso.select(
                        OR(
                            AND(
                                Curso.q.anio == self.anio,
                                Curso.q.cuatrimestre < self.cuatrimestre
                            ),
                            Curso.q.anio < self.anio
                        )))

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
        """ ordena los cursos por fecha de aparicion descendiente """
        cmpAnio = cmp(other.anio, self.anio)
        if cmpAnio == 0:
            return cmp(other.cuatrimestre, self.cuatrimestre)
        else:
            return cmpAnio
#}}}

class Lenguaje(SQLObject): #{{{
    # Clave
    nombre          = UnicodeCol(length=50, notNone=True)
    pk              = DatabaseIndex(nombre, unique=True)
    # Campos
    mossnet_id      = UnicodeCol(length=30, default=None)

    def __unicode__(self):
        return unicode(self.nombre)

    def __repr__(self):
        return 'Lenguaje(id=%r, nombre=%s)' % (self.id, nombre)

    def shortrepr(self):
        return nombre
#}}}

class Usuario(InheritableSQLObject): #{{{
    # Clave (para docentes puede ser un nombre de usuario arbitrario)
    usuario         = UnicodeCol(length=10, alternateID=True,
                        alternateMethodName='by_usuario')
    # Campos
    contrasenia     = UnicodeCol(length=255, default=None)
    nombre          = UnicodeCol(length=255, notNone=True)
    email           = StringCol(length=255, default=None, 
                        alternateMethodName='by_email')
    telefono        = UnicodeCol(length=255, default=None)
    creado          = DateTimeCol(notNone=True, default=DateTimeCol.now)
    observaciones   = UnicodeCol(default=None)
    activo          = BoolCol(notNone=True, default=True)
    hash            = StringCol(length=255, default=None, 
                        alternateMethodName='by_hash')
    hash_ip         = StringCol(length=32, default=None)
    hash_ts         = DateTimeCol(default=None)
    paginador       = IntCol(default=50)

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

    def set_hash(self, ip):
        m = hashlib.sha1()
        m.update('SER%sCOM:%s' % (self.email, datetime.now()))
        self.hash = m.hexdigest()
        self.hash_ip = ip
        self.hash_ts = datetime.now()
        return self.hash
    def reset_password(self, newpass=None):
        if newpass == None:
            m = hashlib.md5()
            m.update('SER%sCOM' % datetime.now())
            newpass = m.hexdigest()[:8]
        self.hash = None
        self._set_password(newpass)
        return newpass

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

    def has_any_permiso(self, *permisos):
        for p in self.permisos:
            if p in permisos:
                return True
        return False
    
    def equals_password(self, cleartext_password):
        return self.contrasenia == encryptpw(cleartext_password)

    def __unicode__(self):
        return u'%s (%s)' % (self.usuario, self.nombre)

    def __repr__(self):
        raise NotImplementedError(_(u'Clase abstracta!'))

    def shortrepr(self):
        return u'%s (%s)' % (self.usuario, self.nombre)
#}}}

class Docente(Usuario): #{{{
    _inheritable = False
    # Campos
    nombrado        = BoolCol(notNone=True, default=True)
    # Joins
    enunciados      = MultipleJoin('Enunciado', joinColumn='autor_id')
    inscripciones   = MultipleJoin('DocenteInscripto')

    def _get_cursos(self):
        return sorted(list(Curso.select(
                AND(Curso.q.id == DocenteInscripto.q.cursoID,
                    self.id == DocenteInscripto.q.docenteID
                ))))

    def _get_inscripciones_activas(self):
        return list(DocenteInscripto.select(
                AND(
                    IN(Curso.q.id, [0]+[c.id for c in Curso.activos()]),
                    Curso.q.id == DocenteInscripto.q.cursoID,
                    self.id == DocenteInscripto.q.docenteID,
                )))

    def get_inscripcion(self, curso):
        return DocenteInscripto.pk.get(curso,self)

    def corregir(self, entregador, instancia):
                # Veo si ya existe una Correccion
        try:
            return Correccion.pk.get(instancia=instancia, entregador=entregador)
        except SQLObjectNotFound:
            # Si no existe, trato de crear una
            entrega = instancia.find_entrega_a_corregir(entregador)
            corrector = self.get_inscripcion(instancia.curso)
            return Correccion(entregador=entregador,
                    instancia=instancia, entrega=entrega,
                    corrector=corrector,
                    asignado=DateTimeCol.now())

    def eliminar_correccion(self, entregador, instancia):
        # Veo si ya existe una Correccion, y la borro
        c = Correccion.pk.get(instancia=instancia, entregador=entregador)
        c.destroySelf()

    def add_entrega(self, instancia, **kw):
        return Entrega(instancia=instancia, **kw)

    def add_enunciado(self, nombre, anio, cuatrimestre, **kw):
        return Enunciado(nombre=nombre, anio=anio, cuatrimestre=cuatrimestre,
            autor=self, **kw)

    def remove_enunciado(self, nombre, anio, cuatrimestre):
        Enunciado.pk.get(nombre, anio, cuatrimestre).destroySelf()

    def __unicode__(self):
        return u'%s' % (self.nombre)

    def shortrepr(self):
        return u'%s' % (self.nombre)

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
        return sorted(list(Curso.select(
                AND(Curso.q.id == AlumnoInscripto.q.cursoID,
                    self.id == AlumnoInscripto.q.alumnoID
                ))))

    def _get_padron(self): # alias para poder referirse al alumno por padron
        return self.usuario

    def _set_padron(self, padron):
        self.usuario = padron

    @classmethod
    def byPadron(cls, padron): # TODO eliminar, backward compat
        return cls.byUsuario(unicode(padron))

    def get_resumen_entregas(self, curso):
        entregadores_del_alumno = self.get_entregadores(curso)
        instancias = curso.instancias_examinacion_a_corregir

        entregas = dict([ (i,[]) for i in instancias ])
        entregadores = dict([ (i,i.get_entregador_default(self)) for i in instancias ])
        correcciones = dict([ (i,None) for i in instancias ])

        for e in Entrega.select(AND(
                                   IN(Entrega.q.instancia, instancias),
                                   IN(Entrega.q.entregador, entregadores_del_alumno)
                               )):
            entregas[e.instancia].append(e)
            entregadores[e.instancia] = e.entregador

        for c in Correccion.select(AND(
                                   IN(Correccion.q.instancia, instancias),
                                   IN(Correccion.q.entregador, entregadores_del_alumno)
                               )):
            correcciones[c.instancia] = c
            entregadores[c.instancia] = c.entregador

        return [DTOResumenEntregaAlumno(i, entregas[i], entregadores[i], correcciones[i]) for i in instancias]

    def get_inscripcion(self, curso):
        return AlumnoInscripto.pk.get(curso, self)

    def get_entregadores(self, curso):
        entregadores = self.get_grupos(curso)
        inscripcion = self.get_inscripcion(curso)
        if inscripcion:
            entregadores.append(inscripcion)
        return entregadores

    def get_membresias_a_grupos(self,curso):
        return Miembro.select(AND(
                Miembro.q.alumnoID == AlumnoInscripto.q.id,
                AlumnoInscripto.q.alumnoID == self.id,
                AlumnoInscripto.q.cursoID == curso.id))

    def get_grupos(self, curso):
        return list(m.grupo for m in self.get_membresias_a_grupos(curso)) 

    def get_grupos_activos(self, curso):
        return list(m.grupo for m in self.get_membresias_a_grupos(curso) if not m.baja) 

    def get_correcciones(self, curso):
        correcciones = []
        for e in self.get_entregadores(curso):
            correcciones += [c for c in e.correcciones if c.instancia.activo]

        return correcciones

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
    lenguaje        = ForeignKey('Lenguaje', default=None, cascade=False)
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

    def validar_acceso(self, usuario):
        if not self.publico and not usuario.has_any_permiso(Permiso.corregir, Permiso.enunciado_editar):
            raise UsuarioSinPermisos(usuario)


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

    def fue_aprobado(self, correcciones):
        de_ejercicio_actual = filter(lambda c: c.aprobada and c.instancia.de_ejercicio(self), correcciones)
        return len(de_ejercicio_actual) > 0

    def notas_a_promediar(self, correcciones):
        de_ejercicio_actual = filter(lambda c: c.instancia.de_ejercicio(self), correcciones)
        instancias_a_promediar = sorted([i for i in self.instancias if i.activo])

        index = 0
        aprobado_encontrado = False
        notas = []
        while not aprobado_encontrado and index < len(instancias_a_promediar):
            correccion = self.__get_correccion_para(instancias_a_promediar[index], de_ejercicio_actual)
            if not correccion:
                notas.append(3)
            else:
                notas.append(correccion.nota)
                if correccion.aprobada:
                    aprobado_encontrado = True
            index = index + 1
        return notas

    def __get_correccion_para(self, instancia, correcciones):
        para_instancia = filter(lambda c: c.instancia == instancia, correcciones)
        if len(para_instancia) == 0:
            return None
        elif len(para_instancia) == 1:
            return para_instancia[0]
        else:
            raise Exception('No se acepta mas de una correccion para la instancia dada')
            

    def __unicode__(self):
        return u'(%s, %s, %s)' % (self.curso, self.numero, self.enunciado)

    def __repr__(self):
        return 'Ejercicio(id=%r, curso=%s, numero=%r, enunciado=%s, ' \
            'grupal=%r)' \
                % (self.id, srepr(self.curso), self.numero,
                    srepr(self.enunciado), self.grupal)

    def shortrepr(self):
        return u'(%d, %s)' \
            % (self.numero, self.enunciado)
#}}}

class InstanciaExaminacion(InheritableSQLObject): #{{{
    # Campos
    inicio          = DateTimeCol(notNone=True)
    fin             = DateTimeCol(notNone=True)
    observaciones   = UnicodeCol(notNone=True, default=u'')
    activo          = BoolCol(notNone=True, default=True)
    # Joins
    correcciones    = MultipleJoin('Correccion', joinColumn='instancia_id')

    def _get_abierta(self):
        now = DateTimeCol.now()
        return self.activo and self.inicio <= now and self.fin >= now

    def _get_cant_aprobados(self):
        return len([c for c in self.correcciones if c.aprobada])

    def get_posibles_correctores(self):
        return self.curso.docentes

    def get_promedio_correcciones(self):
        notas = [c.nota for c in self.correcciones if c.nota]
        if len(notas) == 0:
            return None
        else:
            return sum(notas) / len(notas)

    def get_instancias_cursos_anteriores(self):
        cursos = self.curso.get_cursos_anteriores()
        instancias = []
        for c in cursos:
            instancias += [i for i in c.instancias_examinacion_a_corregir
                             if i.equivalente_a(self)]
        return instancias

    def __cmp__(self, other):
        cmp_curso = cmp(self.curso, other.curso)
        if cmp_curso != 0:
            return -cmp_curso
        else:
            return self.cmp_specific(other)
 #}}}

class InstanciaDeEvaluacionAlumno(InstanciaExaminacion): #{{{
    # Clave
    curso           = ForeignKey('Curso', notNone=True)
    tipo            = UnicodeCol(length=255, notNone=True)
    pk              = DatabaseIndex(curso, tipo, unique=True)

    def _get_requiere_entregas(self):
        return False

    def de_ejercicio(self, ejercicio):
        return False

    def preparar_correccion_forzada(self, entregador):
        pass

    def get_instancia_anterior(self):
        return None
 
    def find_entrega_a_corregir(self, entregador):
        return None

    def get_posibles_entregadores(self):
        return self.curso.alumnos

    def get_entregador_default(self, alumno):
        return alumno.get_inscripcion(self.curso)
 
    def get_resumen_entregas(self):
        entregadores = self.curso.alumnos
        correcciones = dict([(e,None) for e in entregadores])
        for c in self.correcciones:
            correcciones[c.entregador] = c
        return [DTOResumenEvaluacionAlumno(e, correcciones[e]) for e in entregadores]

    def equivalente_a(self, instancia):
        if isinstance(instancia, self.__class__):
            return self.tipo == instancia.tipo
        else:
            return False 

    def longrepr(self):
        return self.tipo

    def shortrepr(self):
        return self.tipo

    def __unicode__(self):
        return unicode(self.shortrepr())

    def cmp_specific(self, other):
        if isinstance(other, self.__class__):
            return cmp(self.tipo, other.tipo)
        else:
            return 1

#}}}
 
class InstanciaDeEntrega(InstanciaExaminacion): #{{{
    _inheritable    = False
    # Clave
    ejercicio       = ForeignKey('Ejercicio', notNone=True, cascade=True)
    numero          = IntCol(notNone=True)
    pk              = DatabaseIndex(ejercicio, numero, unique=True)
    # Joins
    entregas        = MultipleJoin('Entrega', joinColumn='instancia_id')

    def _get_requiere_entregas(self):
        return True

    def _get_curso(self):
        return self.ejercicio.curso

    def de_ejercicio(self, ejercicio):
        return self.ejercicio == ejercicio

    def preparar_correccion_forzada(self, entregador):
        entregas = entregador.entregas_de(self)
        if not entregas:
            Entrega(instancia=self, entregador=entregador,
                inicio=datetime.now(), fin=datetime.now(),
                exito=1)

    def get_instancia_anterior(self):
        if (self.numero <= 1):
            return None
        return InstanciaDeEntrega.selectBy(ejercicio=self.ejercicio, numero=self.numero-1).getOne()

    def find_entrega_a_corregir(self, entregador):
        entregas = entregador.entregas_de(self)
        if not entregas:
            # TODO: soportar correcciones sin entregas (puede pasar)
            raise AlumnoSinEntregas(entregador,self)
        else:
            for e in entregas:
                if e.aceptada:
                    return e
            #else
            return entregas[0]

    def get_posibles_entregadores(self):
        return self.ejercicio.get_posibles_entregadores()

    def get_entregador_default(self, alumno):
        curso = self.ejercicio.curso
        if self.ejercicio.grupal:
            grupos = alumno.get_grupos(curso)
            return len(grupos)>0 and grupos[0] or None
        else:
            return alumno.get_inscripcion(curso)

    def get_resumen_entregas(self):
        entregadores = self.ejercicio.get_posibles_entregadores()
        entregas = dict([(e,[]) for e in entregadores])
        correcciones = dict([(e,None) for e in entregadores])
        for e in self.entregas:
            entregas[e.entregador].append(e)
        for c in self.correcciones:
            correcciones[c.entregador] = c
        return [DTOResumenEntrega(e, entregas[e], correcciones[e]) for e in entregadores]

    def equivalente_a(self, instancia):
        if isinstance(instancia, self.__class__):
            return self.ejercicio.numero == instancia.ejercicio.numero
        else:
            return False 

    def cmp_specific(self, other):
        if isinstance(other, self.__class__):
            self_key = (self.ejercicio.numero, self.numero)
            other_key = (other.ejercicio.numero, other.numero)
            return cmp(self_key, other_key)
        else:
            return -1

    def __unicode__(self):
        return unicode(self.shortrepr())

    def __repr__(self):
        return 'InstanciaDeEntrega(id=%r, numero=%r, inicio=%r, fin=%r, observaciones=%r, activo=%r)' \
                % (self.id, self.numero, self.inicio, self.fin,
                   self.observaciones, self.activo)

    def longrepr(self):
        return "%s (%s)" % (self.shortrepr(),self.ejercicio.enunciado.nombre)

    def shortrepr(self):
        return "%s.%s" % (self.ejercicio.numero, self.numero)
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

    def __cmp__(self,other):
        """ ordena los alumnos inscriptos por nombre de usuario """
        return cmp(self.alumno.usuario,other.alumno.usuario)
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

    def _get_concluida(self):
        return self.fin is not None

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

    def _get_aceptada(self):
        return self.exito

    def _get_correcta(self):
        return self.aceptada and self.comandos_exitosos and self.pruebas_exitosas

    def _get_pruebas_publicas(self):
        return Prueba.select(AND(Prueba.q.entregaID == self.id, Prueba.q.caso_de_pruebaID == CasoDePrueba.q.id, CasoDePrueba.q.publico == True))

    def _get_comandos_exitosos(self):
        for c in self.comandos_ejecutados:
            if not c.exito:
                return False
        return True

    def _get_pruebas_exitosas(self):
        for p in self.pruebas:
            if not p.comandos_exitosos:
                return False
        return True

    def get_pruebas_visibles(self,usuario):
        if Permiso.corregir in usuario.permisos:
            return self.pruebas
        else:
            return self.pruebas_publicas

    def validar_acceso(self, usuario):
        if Permiso.corregir not in usuario.permisos:
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

    def __unicode__(self):
        return u'%s-%s-%s' % (self.instancia, self.entregador, self.fecha)

    def __repr__(self):
        return super(Entrega, self).__repr__('instancia=%s, entregador=%s, '
            'fecha=%r' % (srepr(self.instancia), srepr(self.entregador),
                self.fecha))

    def estadorepr(self):
        if not self.aceptada:
            return 'Rechazada'
        elif not self.correcta:
            c_totales = len(self.comandos_ejecutados)
            c_pasados = len([c for c in self.comandos_ejecutados if c.exito])
            p_totales = len(self.pruebas)
            p_pasadas = len([p for p in self.pruebas if p.comandos_exitosos])
            return 'Con errores. Pruebas pasadas %d/%d. Fuentes: %d/%d' % (p_pasadas, p_totales, c_pasados, c_totales)
        else:
            return 'Correcta'

    def shortrepr(self):
        return '%s-%s-%r' % (srepr(self.instancia), srepr(self.entregador),
                self.fecha)
#}}}

class Correccion(SQLObject): #{{{
    # Clave
    instancia       = ForeignKey('InstanciaExaminacion', notNone=True, cascade=False)
    entregador      = ForeignKey('Entregador', notNone=True, cascade=False)
    pk              = DatabaseIndex(instancia, entregador, unique=True)
    # Campos
    entrega         = ForeignKey('Entrega', notNone=False, cascade=False)
    corrector       = ForeignKey('DocenteInscripto', notNone=True, cascade=False)
    asignado        = DateTimeCol(notNone=True, default=DateTimeCol.now)
    corregido       = DateTimeCol(default=None)
    nota            = DecimalCol(size=3, precision=1, default=None)
    observaciones   = UnicodeCol(default=None)

    def _get_entregas(self):
        return list(Entrega.selectBy(instancia=self.instancia,
                entregador=self.entregador).orderBy(-Entrega.q.fecha))

    @classmethod
    def get_por_alumnos_e_instancias(cls, alumnos, instancias):
        return cls.select(
                        AND(
                            Correccion.q.entregadorID ==  AlumnoInscripto.q.id,
                            IN(AlumnoInscripto.q.alumno, alumnos),
                            IN(Correccion.q.instancia, instancias)
                        )
                    )

    def __unicode__(self):
        if not self.corrector:
            return u'%s' % self.entrega
        return u'%s,%s' % (self.entrega, self.corrector)

    def __repr__(self):
        return u'Correccion(instancia=%s, entregador=%s, entrega=%s, ' \
            'corrector=%r, asignado=%r, corregido=%r, nota=%r, ' \
            'observaciones=%r)' \
                % (srepr(self.instancia), srepr(self.entregador),
                    srepr(self.entrega), self.corrector, self.asignado,
                    self.corregido, self.nota, self.observaciones)

    def shortrepr(self):
        if not self.corrector:
            return '%s' % srepr(self.entrega)
        return '%s,%s' % (srepr(self.entrega), srepr(self.corrector))

    def _get_aprobada(self):
        return self.nota >= 4
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

    def _get_comandos_exitosos(self):
        for c in self.comandos_ejecutados:
            if not c.exito:
                return False
        return True

    def validar_acceso(self, usuario):
        self.entrega.validar_acceso(usuario)
        if not self.caso_de_prueba.publico and Permiso.corregir not in usuario.permisos:
            raise UsuarioSinPermisos(usuario)

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
        if other.__class__ == Permiso:
            return self.nombre == other.nombre
        else:
            return self.nombre == other

    def __ne__(self, other):
        return not self.__eq__(other)

    def __hash__(self):
        return hash(self.nombre)

    def __repr__(self):
        return repr(self.nombre)

    def __str__(self):
        return self.nombre

class PermisoModulo:

    pass;

Permiso.entregar_tp = Permiso(u'entregar', u'Permite entregar trabajos prácticos')
Permiso.admin = Permiso(u'admin', u'Permite hacer ABMs arbitrarios')
Permiso.corregir = Permiso(u'corregir', u'Permite corregir ejercicios')
Permiso.alumno_editar = Permiso(u'alumno_editar', u'Permite editar datos de alumnos')
Permiso.alumno_eliminar = Permiso(u'alumno_eliminar', u'Permite eliminar alumnos')
Permiso.enunciado_editar = Permiso(u'enunciado_editar', u'Permite editar datos de enunciados')
Permiso.enunciado_eliminar = Permiso(u'enunciado_eliminar', u'Permite eliminar enunciados')

Permiso.examen = PermisoModulo()
Permiso.examen.editar = Permiso(u'examen_editar', u'Creación y edición examenes')
Permiso.examen.eliminar = Permiso(u'examen_eliminar', u'Eliminación de examenes')

Permiso.examen.tema = PermisoModulo()
Permiso.examen.tema.editar = Permiso(u'examen_tema_editar', u'Creación y edición de temas de preguntas en examenes')
Permiso.examen.tema.eliminar = Permiso(u'examen_tema_eliminar', u'Eliminación de temas de preguntas en examenes')

Permiso.examen.tipo = PermisoModulo()
Permiso.examen.tipo.editar = Permiso(u'examen_tipo_editar', u'Creación y edición de tipos de preguntas en examenes')
Permiso.examen.tipo.eliminar = Permiso(u'examen_tipo_eliminar', u'Eliminación de tipos de preguntas en examenes')

Permiso.examen.respuesta = PermisoModulo()
Permiso.examen.respuesta.proponer = Permiso(u'examen_respuesta_proponer', u'Agregado de nuevas propuestas a preguntas de examen')
Permiso.examen.respuesta.revisar = Permiso(u'examen_respuesta_revisar', u'Revisión de respuestas a preguntas de examen')
#}}}

#}}} Identity

#}}} Clases

