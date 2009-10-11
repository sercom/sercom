<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<?python from sercom.model import Grupo, AlumnoInscripto ?>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:py="http://purl.org/kid/ns#"
    py:extends="'../../../../../templates/master.kid'">
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" py:replace="''"/>
<title>list</title>
</head>
<body>

<h1>Entregas Realizadas</h1>
<h2>Enunciado: <span py:replace="ejercicio.enunciado">Nombre Enunciado</span> (instancia: <span py:replace="instancia.numero">Nombre Enunciado</span>)</h2>

<table class="list">
    <tr>
				<th>Entregador</th>
        <th>Estado</th>
        <th>InicioTareas</th>
        <th>FinTareas</th>
        <th>Observaciones</th>
				<th>Operaciones</th>
    </tr>
		<tr py:for="record in records">
				<?python
					if not record.aceptada:
                                            color = "red"
                                        elif not record.correcta:
                                            color = "yellow"
                                        else:
                                            color = "green"
				?>
	<td style="background:${color};">
	    <span py:if="record.entregador" py:replace="record.entregador"></span>
        </td>
        <td style="background:${color};"><span py:replace="record.estadorepr()">estado</span></td>
        <td style="background:${color};"><span py:replace="record.inicio">inicio</span></td>
        <td style="background:${color};"><span py:replace="record.fin">fin</span></td>
        <td style="background:${color};"><span py:replace="record.observaciones">observaciones</span></td>
				<td>
					<a href="${tg.url('/mis_entregas/corrida/%d' % record.id)}">Corrida</a>
					<a href="${tg.url('/mis_entregas/get_archivo/%d' % record.id)}">Bajar Archivo</a>
				</td>
    </tr>
</table>

<br/>

<div>
<a href="javascript:window.history.go(-1);">Volver</a>
<span py:for="page in tg.paginate.pages">
    <a py:if="page != tg.paginate.current_page"
        href="${tg.paginate.get_href(page)}">${page}</a>
    <b py:if="page == tg.paginate.current_page">${page}</b>
</span>
</div>

</body>
</html>

<!-- vim: set et sw=4 sts=4 : -->
