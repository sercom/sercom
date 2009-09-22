
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
| <a href="${tg.url('/correccion/resumen_entregas')}">Resumen por Instancia</a>
| Resumen por Alumno


<h1>Resumen por Alumno</h1>

<div py:replace="form(value=vfilter, options=options, action=tg.url('/correccion/resumen_por_alumno'), submit_text=_(u'Filtrar'))">Filtros</div>

<table class="list">
    <tr>
        <th>Instancia</th>
        <th>Entregas Aceptadas</th>
        <th>Entregas Rechazadas</th>
        <th>Corrector</th>
        <th>Nota</th>
        <th>Operaciones</th>
    </tr>
    <tr py:for="record in records">
        <?python
          instancia = record.instancia
          entregador = record.entregador
        ?>
        <td><span py:replace="record.instancia">instancia</span></td>
        <td><span py:replace="record.entregas_aceptadas == 0 and '-' or str(record.entregas_aceptadas)">entregas aceptadas</span></td>
        <td><span py:replace="record.entregas_rechazadas == 0 and '-' or str(record.entregas_rechazadas)">entregas rechazadas</span></td>
        <td><span py:if="record.correccion" py:replace="record.correccion.corrector">corrector</span></td>
        <td><span py:if="record.correccion" py:replace="record.correccion.nota">corrector</span></td>
        <td>
            <a py:if="record.tiene_entregas" href="${tg.url('/curso/ejercicio/instancia/entregas/%s/%d' % (instancia.id, entregador.id))}">Ver Entregas</a>&nbsp;&nbsp;
            <a py:if="record.editar_correccion" href="${tg.url('/correccion/edit', correccionID=record.correccion.id)}">Corregir</a>
            <a py:if="record.agregar_correccion" href="${tg.url('/correccion/new', instanciaID = instancia.id, entregadorID = entregador.id)}">Corregir</a>
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
