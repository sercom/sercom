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

<h1>Cálculo de Correcciones</h1>

<div py:replace="form(value=vfilter, options=options, action=tg.url('/correccion/calculo_correcciones'), submit_text=_(u'Simular'))">Simular</div>


 <table class="list">
    <tr>
        <th>Entregador</th>
        <th>Nota Actual</th>
        <th>Corrector Actual</th>
        <th>Nota Simulada</th>
        <th>Observaciones</th>
        <th>
 <a py:if="records" href="${tg.url('/correccion/aplicar_calculo_correcciones')}">Aplicar Todas</a>
</th>
    </tr>
    <tr py:for="record in records">
        <?python
          entregador = record.entregador
        ?>
        <td><span py:replace="record.entregador">entregador</span></td>
        <td><span py:if="record.correccion_actual" py:replace="record.correccion_actual.nota">nota actual</span></td>
        <td><span py:if="record.correccion_actual" py:replace="record.correccion_actual.corrector">corrector actual</span></td>
        <td><span py:replace="record.nota_calculada">nota simulada</span></td>
        <td><span py:replace="record.observaciones">observaciones</span></td>
        <td nowrap="true">
            <a href="${tg.url('/correccion/aplicar_calculo_correcciones?entregadorId=%d' % record.entregador.id)}">Aplicar Alumno</a>
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
