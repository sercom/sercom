import string

class ResumenNotas:

    def __init__(self):
        self.cols = []
        self.rows = []

    def calcular(self, curso):
        # Armo las columnas del listado
        self.cols.append("Padron")
        self.cols.append("Nombre")
        self.cols.append("Grupos")

        correcciones_por_inst = {}
        for ins in curso.instancias_examinacion_a_corregir:
            if ins.activo:
                self.cols.append(ins.shortrepr())
                correcciones_por_inst[ins] = ins.correcciones

        for ai in curso.alumnos:
            grupos = ai.alumno.get_grupos(curso)
            id_entregadores = set( [g.id for g in grupos] + [ai.id] ) 
            col = {}
            col["Padron"] = ai.alumno.padron
            col["Nombre"] = ai.alumno.nombre
            col["Grupos"] = string.join((g.nombre for g in grupos), ' ')
            correctas = 0
            for ins in curso.instancias_examinacion_a_corregir:
                if ins.activo:
                    correcciones = [c for c in correcciones_por_inst[ins] if (c.entregadorID in id_entregadores)]
                    if len(correcciones) > 0 and correcciones[0].nota:
                        nota = str(correcciones[0].nota)
                    else:
                        nota = ""
                    col[ins.shortrepr()] = nota
            self.rows.append(col)
