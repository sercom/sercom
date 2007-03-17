<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<?python import turbogears as tg ?>
<?python from sercom.model import Grupo, AlumnoInscripto ?>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:py="http://purl.org/kid/ns#"
    py:extends="'../../../templates/master.kid'">
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" py:replace="''"/>
<title>corrida</title>
</head>
<body>

<h1>Corrida</h1>

<h2>Comandos Ejecutados</h2>
<table>
    <tr>
        <th>#</th>
        <th>Tarea</th>
        <th>Comando</th>
        <th>Inicio</th>
        <th>Fin</th>
        <th>Exito?</th>
        <th>Observaciones</th>
        <th>Diferencias</th>
        <th>Archivos Guardados</th>
    </tr>
		<!-- TODO : Solo mostrar con ce.comando.publico == True -->
		<tr py:for="ce in entrega.comandos_ejecutados" py:if="ce.comando.publico">
        <td py:content="ce.comando.orden" />
        <td py:content="ce.comando.tarea.shortrepr()" />
        <td py:content="ce.comando.comando" />
        <td py:content="ce.inicio" />
        <td py:content="ce.fin" />
        <td py:content="tg.strbool(ce.exito)" align="center" />
        <td py:content="ce.observaciones" />
				<td align="center"><a href="${tg.url('/mis_entregas/diff/%d' % ce.id)}" py:if="ce.diferencias">Bajar</a></td>
        <td align="center"><a href="${tg.url('/mis_entregas/file/%d' % ce.id)}" py:if="ce.archivos">Bajar</a></td>
    </tr>
	</table>
<h2>Pruebas Realizadas</h2>
<div py:for="p in entrega.pruebas" py:strip="True">
	<?python
		if p.exito:
			color = "pruebaok"
		else:
			color = "pruebafail"
	?>
	<div>
    <h3 py:content="p.caso_de_prueba.shortrepr()" />
		<table border="1" class="${color}">
    <tr>
        <th>#</th>
        <th>Tarea</th>
        <th>Comando</th>
        <th>Inicio</th>
        <th>Fin</th>
        <th>Exito?</th>
        <th>Observaciones</th>
        <th>Diferencias</th>
        <th>Archivos Guardados</th>
    </tr>
		<!-- TODO : Solo mostrar con ce.comando.publico == True -->
		<tr py:for="ce in p.comandos_ejecutados" py:if="ce.comando.publico">
        <td py:content="ce.comando.orden" />
        <td py:content="ce.comando.tarea.shortrepr()" />
        <td py:content="ce.comando.comando" />
        <td py:content="ce.inicio" />
        <td py:content="ce.fin" />
        <td py:content="tg.strbool(ce.exito)" align="center" />
        <td py:content="ce.observaciones" />
				<td align="center"><a href="${tg.url('/mis_entregas/diff/%d' % ce.id)}" py:if="ce.diferencias">Bajar</a></td>
        <td align="center"><a href="${tg.url('/mis_entregas/file/%d' % ce.id)}" py:if="ce.archivos">Bajar</a></td>
			</tr>
	</table>
</div>
</div>

<a href="javascript:window.history.go(-1);">Volver</a>

</body>
</html>

<!-- vim: set et sw=4 sts=4 : -->
