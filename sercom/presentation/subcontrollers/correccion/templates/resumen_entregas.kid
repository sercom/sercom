<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<?python
from sercom.model import Grupo, AlumnoInscripto
from sercom.domain.correcciones import DTOResumenEntrega
?>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:py="http://purl.org/kid/ns#"
    py:extends="'../../../templates/master.kid'">
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" py:replace="''"/>
<title>list</title>
</head>
<body>


<a href="${tg.url('/correccion/mis_correcciones')}">Mis correcciones</a>
| Resumen de Entregas
| <a href="${tg.url('/correccion/resumen_por_alumno')}">Resumen por Alumno</a>

<h1>Resumen de Entregas</h1>

<div py:replace="form(value=vfilter, options=options, action=tg.url('/correccion/resumen_entregas'), submit_text=_(u'Filtrar'))">Filtros</div>

<div>
    <a href="${tg.url('/correccion/get_mis_fuentes_instancia/%s' % instanciaID)}" title="Fuentes, de las entregas a corregir, asignadas al docente actual.">Bajar mis fuentes</a><br />
    <a href="${tg.url('/correccion/get_fuentes_instancia/%s' % instanciaID)}" title="Fuentes, de las entregas a corregir, correspondientes a esta instancia.">Bajar todos los fuentes</a>
</div>

<table class="list">
    <tr>
        <th>Entregador</th>
        <th>OK</th>
        <th>Rechazadas</th>
        <th>Nota anterior</th>
        <th>Corrector</th>
        <th>Nota</th>
        <th>Operaciones</th>
    </tr>
    <tr py:for="record in records">
        <?python
          entregador = record.entregador
        ?>
        <td><span py:replace="record.entregador">entregador</span></td>
        <td><span py:replace="record.entregas_aceptadas == 0 and '-' or str(record.entregas_aceptadas)">entregas aceptadas</span></td>
        <td><span py:replace="record.entregas_rechazadas == 0 and '-' or str(record.entregas_rechazadas)">entregas rechazadas</span></td>
        <td><span py:if="record.corrector_anterior != None">${record.corrector_anterior}</span><span py:if="record.nota_anterior != None"> -&gt; ${record.nota_anterior}</span></td>
        <td><span py:if="record.correccion" py:replace="record.correccion.corrector">corrector</span></td>
        <td align="center"><span py:if="record.correccion and (record.correccion.corrector.docente.id != docenteActual or record.correccion.nota != None)" py:replace="record.correccion.nota">corrector</span>
        <span class="error" py:if="record.correccion and record.correccion.corrector.docente.id == docenteActual and record.correccion.nota == None">X</span></td>
        <td nowrap="true">
            <a py:if="record.tiene_entregas" href="${tg.url('/curso/ejercicio/instancia/entregas/%s/%d' % (instanciaID, entregador.id))}">Ver Entregas</a>
            <a py:if="record.agregar_correccion" href="${tg.url('/correccion/new', instanciaID = instanciaID, entregadorID = entregador.id, justAssign=True)}" title="Asigna esta entrega al docente actual.">Asignar</a>
            <a py:if="record.editar_correccion and record.correccion.nota == None" href="${tg.url('/correccion/delete', instanciaID = instanciaID, entregadorID = entregador.id, justAssign=True)}" title="Libera esta entrega.">Desasignar</a>
            <a py:if="record.editar_correccion and ('admin' in tg.identity.groups or 'JTP' in tg.identity.groups or record.correccion.corrector.docente.id == docenteActual)" href="${tg.url('/correccion/edit', correccionID=record.correccion.id)}">Corregir</a>
       </td>
    </tr>
</table>

<div py:for="page in tg.paginate.pages" py:strip="True">
    <a py:if="page != tg.paginate.current_page"
        href="${tg.paginate.get_href(page)}">${page}</a>
    <b py:if="page == tg.paginate.current_page">${page}</b>
</div>


</body>
</html>

<!-- vim: set et sw=4 sts=4 : -->
