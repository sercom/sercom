<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<?python from sercom.model import Grupo, AlumnoInscripto ?>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:py="http://purl.org/kid/ns#"
    py:extends="'../../../templates/master.kid'">
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" py:replace="''"/>
<title>list</title>
</head>
<body>

<h1>Administración de <span py:replace="namepl">Objetos</span></h1>

<table class="list">
    <tr>
				<th>Entregador</th>
				<th>Ejercicio</th>
				<th><span title="Instancia de Entrega">IE</span></th>
        <th>OK?</th>
        <th>Fecha</th>
        <th>InicioTareas</th>
        <th>FinTareas</th>
        <th>Observaciones</th>
				<th>Operaciones</th>
    </tr>
    <tr py:for="record in records">
        <td><span py:if="record.entregador" py:replace="record.entregador">usuario</span></td>
        <td><span py:replace="record.instancia.ejercicio.enunciado.nombre">usuario</span></td>
        <td><span py:replace="record.instancia">usuario</span></td>
        <td><span py:replace="record.exito">fecha asignado</span></td>
        <td><span py:replace="record.fecha">fecha corregido</span></td>
        <td><span py:replace="record.inicio">fecha corregido</span></td>
        <td><span py:replace="record.fin">fecha corregido</span></td>
        <td><span py:replace="record.observaciones">nota</span></td>
				<td>
					<a href="${tg.url('/mis_entregas/corrida/%d' % record.id)}">Corrida</a>
					<a href="${tg.url('/mis_entregas/get_archivo/%d' % record.id)}">Bajar Archivo</a>
				</td>
    </tr>
</table>

<br/>
<a href="${tg.url('/mis_entregas/new')}">Agregar</a>

<div py:for="page in tg.paginate.pages">
    <a py:if="page != tg.paginate.current_page"
        href="${tg.paginate.get_href(page)}">${page}</a>
    <b py:if="page == tg.paginate.current_page">${page}</b>
</div>

</body>
</html>

<!-- vim: set et sw=4 sts=4 : -->
