<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
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
		<!-- TODO : Solo mostrar con ce.comando.publico == True -->
		<tr py:for="ce in entrega.comandos_ejecutados">
			<td py:content="ce.comando.shortrepr()"></td>
			<td py:content="ce.inicio"></td>
			<td py:content="ce.fin"></td>
			<td py:content="tg.strbool(ce.exito)"></td>
			<td py:content="ce.archivos"></td>
			<td py:content="ce.diferencias"></td>
			<td py:content="ce.observaciones"></td>
		</tr>
	</table>
<h2>Pruebas Realizadas</h2>
<table>
		<!-- TODO : Solo mostrar con ce.caso_de_prueba.publico == True -->
		<tr py:for="p in entrega.pruebas">
			<td py:content="ce.caso_de_prueba.shortrepr()"></td>
			<td py:content="ce.inicio"></td>
			<td py:content="ce.fin"></td>
			<td py:content="tg.strbool(ce.exito)"></td>
			<td py:content="ce.archivos"></td>
			<td py:content="ce.diferencias"></td>
			<td py:content="ce.observaciones"></td>
		</tr>
	</table>

<a href="javascript:window.history.go(-1);">Volver</a>

</body>
</html>

<!-- vim: set et sw=4 sts=4 : -->
