import string
from decimal import *
import math

class ResultadoCalculoNota:
    def __init__(self, entregador, correccion_actual, nota_calculada, observaciones):
        self.correccion_actual = correccion_actual
        self.entregador = entregador
        self.nota_calculada = nota_calculada
        self.observaciones = observaciones
        self.puede_ser_aplicada = (nota_calculada and not observaciones)

class NotasAlumno:
    def __init__(self, alumno, grupos):
        self.padron = alumno.padron
        self.nombre = alumno.nombre
        self.grupos = string.join((g.nombre for g in grupos), ' ')
        self.notas = {}
    def __setitem__(self, inst_nota, nota):
        self.notas[inst_nota] = nota
    def __getitem__(self, inst_nota):
        return self.notas[inst_nota]

class ResumenNotas:

    def __init__(self):
        self.instancias_nota = []
        self.notas_alumnos = []

    def calcular(self, curso):
        # Armo las columnas del listado
        correcciones_por_inst = {}
        for ins in curso.instancias_examinacion_a_corregir:
            self.instancias_nota.append(ins)
            correcciones_por_inst[ins] = ins.correcciones

        for ai in curso.alumnos:
            alumno = ai.alumno
            grupos = alumno.get_grupos(curso)
            id_entregadores = set( [e.id for e in alumno.get_entregadores(curso)] ) 
            notas = NotasAlumno(alumno, grupos)

            for ins in curso.instancias_examinacion_a_corregir:
                correcciones = [c for c in correcciones_por_inst[ins] if (c.entregadorID in id_entregadores)]
                if len(correcciones) > 0 and correcciones[0].nota:
                    nota = str(correcciones[0].nota)
                else:
                    nota = ""
                notas[ins] = nota
            self.notas_alumnos.append(notas)

class CalculoNotaException (Exception):
    def __init__(self, observaciones):
        self.observaciones = observaciones

class TerminoPromedio:
    def __init__(self, factor, promedio_calculado):
        self.factor = factor
        self.promedio_calculado = promedio_calculado

class CalculadorNotas:
    def __init__(self, curso, instancia_examinacion_destino):
        self.curso = curso
        self.instancia_destino = instancia_examinacion_destino

    def simular(self):
        resultados = []
        correcciones_por_entregador = dict([(e, list()) for e in self.curso.alumnos + self.curso.grupos])
        for i in self.curso.instancias_examinacion_a_corregir:
            for c in i.correcciones:
                correcciones_por_entregador[c.entregador].append(c)

        for ai in self.curso.alumnos:
            correcciones = []
            for e in ai.alumno.get_entregadores(self.curso):
                correcciones += correcciones_por_entregador[e]

            try:
                nota = self.calcular_nota_entregador(correcciones)
                observaciones = None
            except CalculoNotaException, e:
                nota = None
                observaciones = e.observaciones
            correccion_actual = ai.correccion_de(self.instancia_destino)
            resultados.append(ResultadoCalculoNota(ai, correccion_actual, nota, observaciones))
        return resultados

class CalculadorPromedioEjercicios (CalculadorNotas):
    def __init__(self, curso, instancia_examinacion_destino):
        CalculadorNotas.__init__(self, curso, instancia_examinacion_destino)

    def calcular_nota_entregador(self, correcciones):
        if not correcciones:
            raise CalculoNotaException('No hay correcciones para aplicar un promedio')
        sin_nota = [c.instancia for c in correcciones if not c.nota]
        if sin_nota:
            raise CalculoNotaException('Las correcciones de las siguientes instancias aun no poseen nota: ' + ','.join([i.shortrepr() for i in sin_nota]))

        no_aprobados = self.__ejercicios_no_aprobados(correcciones)
        if no_aprobados:
            raise CalculoNotaException('Los siguientes ejercicios no fueron aprobados con las correcciones encontradas: ' + ','.join([str(e.numero) for e in no_aprobados]))

        terminos_prom_para_nota = self.__get_terminos_prom_para_nota(correcciones)
        return sum([t.factor*t.promedio_calculado for t in terminos_prom_para_nota])

    def __get_terminos_prom_para_nota(self, correcciones):
        ejercicios_individuales = [e for e in self.__get_ejercicios_a_aprobar() if not e.grupal]

        notas_indiv_a_promediar = []
        for e in ejercicios_individuales:
            for c in e.notas_a_promediar(correcciones):
                notas_indiv_a_promediar.append(c)


        suma_individual = sum([n for n in notas_indiv_a_promediar])
        cant_individual = len(notas_indiv_a_promediar)
        term_individual = TerminoPromedio(Decimal('0.4'), suma_individual / cant_individual)
        term_grupal = TerminoPromedio(Decimal('0.6'), self.__get_nota_ejercicio_grupal(correcciones))
        return [term_individual, term_grupal]

    def __ejercicios_no_aprobados(self, correcciones):
        no_aprobados = []
        for e in self.__get_ejercicios_a_aprobar():
            if not e.fue_aprobado(correcciones):
                no_aprobados.append(e)
        return no_aprobados

    def __get_nota_ejercicio_grupal(self, correcciones):
        ejercicios_grupales = [e for e in self.__get_ejercicios_a_aprobar() if e.grupal]
        if len(ejercicios_grupales) != 1:
            raise CalculoNotaException('El calculador requiere un ejercicio grupal unico en el curso.')

        notas_grupales = ejercicios_grupales[0].notas_a_promediar(correcciones)
        if len(notas_grupales) != 1:
            raise CalculoNotaException('El calculador requiere nota unica para el ejercicio grupal del curso.')

        return notas_grupales[0]

    def __get_ejercicios_a_aprobar(self):
        return [e for e in self.curso.ejercicios if 
                                             len([i for i in e.instancias if i.activo]) > 0
               ]

class CalculadorPromedioEjerciciosConConcepto (CalculadorPromedioEjercicios):
    def __init__(self, curso, instancia_destino, instancia_concepto):
        CalculadorPromedioEjercicios.__init__(self, curso, instancia_destino)

        self.instancia_concepto = instancia_concepto
        self.modificadores_promedio = dict([(41,lambda prom: self.__nota_aprobada(math.ceil(prom) + 1)),
                                           (42,lambda prom: self.__nota_aprobada(math.ceil(prom))),
                                           (43,lambda prom: self.__nota_aprobada(math.floor(prom))),
                                           (44,lambda prom: 2)
                                           ])

    def __nota_aprobada(self, nota):
        if nota > 10:
            return 10
        elif nota < 4:
            return 4
        else:
            return nota

    def __find(self, f, seq):
        for item in seq:
            if f(item):
                return item
        return None

    def calcular_nota_entregador(self, correcciones):
        correccion_concepto = self.__find(lambda c: c.instancia == self.instancia_concepto, correcciones)
        if not correccion_concepto:
            raise CalculoNotaException('No se encuentra la nota de concepto esperada.')
        else:
            nota_concepto = correccion_concepto.nota

        promedio = CalculadorPromedioEjercicios.calcular_nota_entregador(self, correcciones)

        try:
            return self.modificadores_promedio[nota_concepto](promedio)
        except KeyError:
            mapeos_disponibles = ','.join([str(m) for m in self.modificadores_promedio.keys()])
            raise CalculoNotaException('La nota de concepto "%s" no fue encontrada entre los mapeos disponibles: %s' % (nota_concepto,mapeos_disponibles))


