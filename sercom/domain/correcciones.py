class DTOResumenEvaluacionAlumno:
    def __init__(self, entregador, correccion):
        self.entregador = entregador
        self.entregas_aceptadas = 0
        self.entregas_rechazadas = 0
        self.correccion = correccion
        self.tiene_entregas = False
        self.editar_correccion = not (correccion is None)
        self.agregar_correccion = (not self.editar_correccion)

class DTOResumenEntrega:
    def __init__(self, entregador, entregas, correccion):
        self.entregador = entregador
        cant_entregas = len(entregas)
        self.entregas_aceptadas = len([e for e in entregas if e.exito])
        self.entregas_rechazadas = cant_entregas-self.entregas_aceptadas
        self.correccion = correccion
        self.tiene_entregas = (cant_entregas > 0)
        self.editar_correccion = not (correccion is None)
        self.agregar_correccion = (not self.editar_correccion) and cant_entregas > 0

class DTOResumenEntregaAlumno:
    def __init__(self, instancia, entregas, entregador, correccion):
        self.instancia = instancia
        self.entregador = entregador
        cant_entregas = len(entregas)
        self.entregas_aceptadas = len([e for e in entregas if e.exito])
        self.entregas_rechazadas = cant_entregas-self.entregas_aceptadas
        self.correccion = correccion
        self.tiene_entregas = (cant_entregas > 0)
        self.editar_correccion = not (correccion is None)
        self.agregar_correccion = (not self.editar_correccion) and (not instancia.requiere_entregas or cant_entregas > 0)


