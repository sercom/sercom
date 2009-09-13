
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

<h1>Resumen de Entregas</h1>

<div py:replace="form(value=vfilter, options=options, action=tg.url('/correccion/resumen_entregas'), submit_text=_(u'Filtrar'))">Filtros</div>

<table class="list">
    <tr>
        <th>Entregador</th>
        <th>Entregas Exitosas</th>
        <th>Entregas Fallidas</th>
        <th>Corrector</th>
        <th>Nota</th>
        <th>Operaciones</th>
    </tr>
    <tr py:for="record in records">
        <?python
          entregador = record.entregador
        ?>
        <td><span py:replace="record.entregador">entregador</span></td>
        <td><span py:replace="record.entregas_exitosas == 0 and '-' or str(record.entregas_exitosas)">entregas exitosas</span></td>
        <td><span py:replace="record.entregas_fallidas == 0 and '-' or str(record.entregas_fallidas)">entregas fallidas</span></td>
        <td><span py:if="record.correccion" py:replace="record.correccion.corrector">corrector</span></td>
        <td><span py:if="record.correccion" py:replace="record.correccion.nota">corrector</span></td>
        <td>
            <a py:if="record.tiene_entregas" href="${tg.url('/curso/ejercicio/instancia/entregas/%s/%d' % (instanciaID, entregador.id))}">Ver Entregas</a>&nbsp;&nbsp;
            <a py:if="record.editar_correccion" href="${tg.url('/corregir/edit', correccionID=record.correccion.id)}">Corregir</a>
            <a py:if="record.agregar_correccion" href="${tg.url('/corregir/new', instanciaID = instanciaID, entregadorID = entregador.id)}">Corregir</a>
       </td>
    </tr>
</table>

<div py:for="page in tg.paginate.pages" py:strip="True">
    <a py:if="page != tg.paginate.current_page"
        href="${tg.paginate.get_href(page)}">${page}</a>
    <b py:if="page == tg.paginate.current_page">${page}</b>
</div>

<br/>
<br/>
<a href="${tg.url('/correccion/mis_correcciones')}">Mis correcciones</a>
<br/>

</body>
</html>

<!-- vim: set et sw=4 sts=4 : -->
