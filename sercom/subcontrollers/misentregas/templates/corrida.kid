<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<?python import turbogears as tg ?>
<?python from sercom.model import Grupo, AlumnoInscripto ?>
<?python from turbogears import identity ?>
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
		<tr py:for="ce in entrega.comandos_ejecutados" py:if="ce.comando.publico or 'admin' in identity.current.permissions">
        <td py:content="ce.comando.orden" />
        <td py:content="ce.comando.tarea" />
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
<div py:for="p in entrega.get_pruebas_visibles(identity.current.user)" py:strip="True">
	<?python
		if p.exito:
			color = "pruebaok"
		else:
			color = "pruebafail"
	?>
	<div style="background:#ddd; border:1px solid black; margin-bottom:10px;">
    <h3 py:content="p.caso_de_prueba" />
			<table class="${color}" border="1" width="100%">
				<tr>
					<td width="20%">Descripcion</td>
					<td width="80%" py:content="p.caso_de_prueba.descripcion"></td>
				</tr>
				<tr>
					<td>Comando</td>
					<td py:content="p.caso_de_prueba.comando"></td>
				</tr>
				<tr>
					<td>Inicio</td>
					<td py:content="p.inicio"></td>
				</tr>
				<tr>
					<td>Fin</td>
					<td py:content="p.fin"></td>
				</tr>
				<tr>
					<td>Observaciones</td>
					<td py:content="p.observaciones"></td>
				</tr>
			</table>
			<h4>Comandos Ejecutados para la Prueba</h4>	
		<table border="1" class="prueba" width="100%">
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
		<tr py:for="ce in p.comandos_ejecutados" py:if="ce.comando.publico or 'admin' in identity.current.permissions">
	<?python
		if ce.exito:
			color = "pruebaok"
		else:
			color = "pruebafail"
	?>
				<td class="${color}" py:content="ce.comando.orden" />
        <td class="${color}"  py:content="ce.comando.tarea" />
        <td class="${color}" py:content="ce.comando.comando" />
        <td class="${color}" py:content="ce.inicio" />
        <td class="${color}" py:content="ce.fin" />
        <td class="${color}" py:content="tg.strbool(ce.exito)" align="center" />
        <td class="${color}" py:content="ce.observaciones" />
        <td class="${color}" align="center">
            <a href="${tg.url('/mis_entregas/diff/%d' % ce.id)}" py:if="ce.diferencias">Bajar</a>
            <a href="${tg.url('/mis_entregas/verdiff/%d' % ce.id)}" py:if="ce.diferencias">Ver</a>
        </td>
        <td class="${color}" align="center"><a href="${tg.url('/mis_entregas/file/%d' % ce.id)}" py:if="ce.archivos">Bajar</a></td>
			</tr>
	</table>
</div>
</div>

<a href="javascript:window.history.go(-1);">Volver</a>

</body>
</html>

<!-- vim: set et sw=4 sts=4 : -->
