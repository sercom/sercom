import string
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
            raise CalculoNotaException('Las correcciones de las siguientes instancias aun no poseen nota: ' + ','.join([i.shortrepr() for i in sin_nota]))

        no_aprobadas = self.__instancias_no_aprobadas(correcciones)
        if no_aprobadas:
            raise CalculoNotaException('Las siguientes instancias no fueron aprobadas con las correcciones encontradas: ' + ','.join([i.shortrepr() for i in no_aprobadas]))

        correcciones_a_promediar = self.__get_correcciones_a_promediar(correcciones)
        suma = sum([c.nota for c in correcciones_a_promediar])
        return suma / len(correcciones_a_promediar)

    def __instancias_no_aprobadas(self, correcciones):
        no_aprobadas = []
        for i in self.get_instancias_a_promediar():
            if not i.fue_aprobada(correcciones):
                no_aprobadas.append(i)
        return no_aprobadas

    def __get_correcciones_a_promediar(self, correcciones):
        a_promediar = self.get_instancias_a_promediar()
        return [c for c in correcciones if c.instancia in a_promediar]

    def get_instancias_a_promediar(self):
        a_promediar = list(self.curso.instancias_examinacion_a_corregir)
        a_promediar.remove(self.instancia_destino)
        return a_promediar

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

    def get_instancias_a_promediar(self):
        a_promediar = CalculadorNotasPromedio.get_instancias_a_promediar(self)
        a_promediar.remove(self.instancia_concepto)
        return a_promediar

    def calcular_nota_entregador(self, correcciones):
        correccion_concepto = self.find(lambda c: c.instancia == self.instancia_concepto, correcciones)
        if not correccion_concepto:
            raise CalculoNotaException('No se encuentra la nota de concepto esperada.')
        else:
            nota_concepto = correccion_concepto.nota

        promedio = CalculadorNotasPromedio.calcular_nota_entregador(self, correcciones)

        try:
            return self.modificadores_promedio[nota_concepto](promedio)
        except KeyError:
            mapeos_disponibles = ','.join([str(m) for m in self.modificadores_promedio.keys()])
            raise CalculoNotaException('La nota de concepto "%s" no fue encontrada entre los mapeos disponibles: %s' % (nota_concepto,mapeos_disponibles))


