import string
import math

class ResultadoCalculoNota:
    def __init__(self, entregador, correccion_actual, nota_calculada, observaciones):
        self.correccion_actual = correccion_actual
        self.entregador = entregador
        self.nota_calculada = nota_calculada
        self.observaciones = observaciones

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

class CalculadorNotasPromedio (CalculadorNotas):
    def __init__(self, curso, instancia_examinacion_destino):
        CalculadorNotas.__init__(self, curso, instancia_examinacion_destino)

    def calcular_nota_entregador(self, correcciones):
        if not correcciones:
            raise CalculoNotaException('No hay correcciones para aplicar un promedio')
        sin_nota = [c.instancia for c in correcciones if not c.nota]
        if sin_nota:
            raise CalculoNotaException('No se encuentran notas para las siguientes instancias: ' + ','.join([i.shortrepr() for i in sin_nota]))

        suma = sum([c.nota for c in correcciones])
        return suma / len(correcciones)

class CalculadorNotasPromedioConConcepto (CalculadorNotasPromedio):
    def __init__(self, curso, instancia_destino, instancia_concepto):
        CalculadorNotasPromedio.__init__(self, curso, instancia_destino)

        self.instancia_concepto = instancia_concepto
        self.modificadores_promedio = dict([(41,lambda prom: math.ceil(prom) + 1),
                                           (42,lambda prom: math.ceil(prom)),
                                           (43,lambda prom: math.floor(prom)),
                                           (44,lambda prom: 2)
                                           ])

    def find(self, f, seq):
        for item in seq:
            if f(item):
                return item
        return None

    def calcular_nota_entregador(self, correcciones):
        correccion_concepto = self.find(lambda c: c.instancia == self.instancia_concepto, correcciones)
        if not correccion_concepto:
            raise CalculoNotaException('No se encuentra la nota de concepto esperada.')
        else:
            nota_concepto = correccion_concepto.nota

        correcciones_a_promediar = [c for c in correcciones if c != correccion_concepto]
        promedio = CalculadorNotasPromedio.calcular_nota_entregador(self, correcciones_a_promediar)

        try:
            return self.modificadores_promedio[nota_concepto](promedio)
        except KeyError:
            mapeos_disponibles = ','.join([str(m) for m in self.modificadores_promedio.keys()])
            raise CalculoNotaException('La nota de concepto "%d" no fue encontrada entre los mapeos disponibles: %s' % (nota_concepto,mapeos_disponibles))


