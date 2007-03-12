<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<?python from sercom.model import Grupo, AlumnoInscripto ?>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:py="http://purl.org/kid/ns#"
    py:extends="'../../../templates/master.kid'">
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" py:replace="''"/>
<title>list</title>
</head>
<body>

<h1>Entregas realizadas</h1>

<table class="list">
    <tr>
				<th width="20%">Fecha</th>
        <th width="5%" title="Correcta?">Ok?</th>
        <th width="25%">Observaciones</th>
        <th width="50%">Tareas Ejecutadas</th>
    </tr>
    <tr py:for="record in records">
        <td><span py:replace="record.fecha">usuario</span></td>
				<td align="center">
					<span py:replace="tg.strbool(record.exito)">Si</span>
				</td>
        <td><span py:replace="record.observaciones">fecha corregido</span></td>
				<td>
					<table width="100%;">
						<tr>
							<th><strong>Tarea</strong></th>
							<th><strong>Desde</strong></th>
							<th><strong>Hasta</strong></th>
							<th><strong>Correcta</strong></th>
							<th><strong>Obs</strong></th>
						</tr>
						<tr py:for="i in record.tareas">
							<td >${i.tarea.shortrepr()}</td>
							<td>${i.inicio}</td>
							<td>${i.fin}</td>
							<td align="center">
								<span py:replace="tg.strbool(i.exito)">Si</span>
							</td>
							<td>${i.observaciones}</td>
						</tr>
					</table>
				</td>
    </tr>
</table>
<br />
<a href="/correccion/list">Volver</a>
<div py:for="page in tg.paginate.pages">
    <a py:if="page != tg.paginate.current_page"
        href="${tg.paginate.get_href(page)}">${page}</a>
    <b py:if="page == tg.paginate.current_page">${page}</b>
</div>

</body>
</html>

<!-- vim: set et sw=4 sts=4 : -->
