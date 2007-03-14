# vim: set et sw=4 sts=4 encoding=utf-8 foldmethod=marker :

from sercom.model import InstanciaDeEntrega
import logging

log = logging.getLogger('sercom.finalizer')

error_interno = _(u'\n**Hubo un error interno al finalizar la instancia.**\n')

class Finalizer(object): #{{{

    def __init__(self, name, queue): #{{{ y properties
        self.name = name
        self.queue = queue
    #}}}

    def run(self): #{{{
        instancia_id = self.queue.get() # blocking
        while instancia_id is not None:
            instancia = InstanciaDeEntrega.get(instancia_id)
            log.debug(_(u'Nueva instancia para procesar en finalizer %s: %s'),
                self.name, instancia)
            self.finalize(instancia)
            log.debug(_(u'Fin de proceso de instancia: %s'), instancia)
            instancia_id = self.queue.get() # blocking
    #}}}

    def finalize(self, instancia): #{{{
        log.debug(_(u'Finalizer.finalize(instancia=%s)'), instancia)
        instancia.inicio_proceso = datetime.now()
        try:
            try:
                instancia.finalizar()
            except Exception, e:
                if isinstance(e, SystemExit): raise
                instancia.observaciones += error_interno
                log.exception(_('Hubo una excepcion inesperada')) # FIXME encoding
            except:
                entrega.observaciones += error_interno
                log.exception(_('Hubo una excepcion inesperada desconocida')) # FIXME encoding
            else:
                log.info(_(u'Instancia de entrega finalizada bien: %s'), instancia)
        finally:
            instancia.fin_proceso = datetime.now()
    #}}}

#}}}

def instancia_finalizar(self): #{{{
    log.debug(_(u'InstanciaDeEntrega.finalizar()'))
    curso = self.ejercicio.curso
    docentes = [di.docente for di in curso.docentes if di.corrige]
    curr_docente = 0
    for ai in curso.alumnos:
        mejor_entrega = None
        for entrega in Entrega.selectBy(instancia=self, entregador=ai).orderBy(-Entrega.q.fecha):
            if not mejor_entrega or not mejor_entrega.exito and entrega.exito:
                mejor_entrega = entrega
        if mejor_entrega:
            mejor_entrega.make_correccion(docentes[curr_docente])
            curr_docente = (curr_docente + 1) % len(docentes)
        else:
            log.info(_(u'El alumno inscripto %s no entregó', ai))

InstanciaDeEntrega.finalizar = instancia_finalizar
#}}}

