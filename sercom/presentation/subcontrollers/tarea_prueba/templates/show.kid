<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:py="http://purl.org/kid/ns#"
    py:extends="'../../../templates/master.kid'">
<?python from turbogears import identity ?>
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" py:replace="''"/>
<title>show</title>
</head>
<body>

<table class="show">
    <tr>
        <th>Nombre:</th>
		<td><span py:replace="record.nombre">nombre</span></td>
    </tr>
    <tr>
        <th>Descripcion:</th>
				<td><span py:replace="record.descripcion">nombre</span></td>
    </tr>
</table>
<h2>Comandos</h2>
<table>
	<tr>
		<th title="Orden">#</th>
		<th>Descripcion</th>
		<th>Comando</th>
		<th title="Código de Retorno">RET</th>
		<th title="Archivos de Entrada">Entrada</th>
		<th title="Archivos a Comparar">Comparar</th>
		<th py:if="'admin' in identity.current.permissions" title="Archivos a Guardar">Guarda</th>
	</tr>
	<tr py:for="i in record.comandos" py:if="'admin' in identity.current.permissions or i.publico">
		<td py:content="i.orden" />
		<td py:content="i.descripcion" />
		<td py:content="i.comando" />
		<td py:content="i.retorno" />
		<td>
			<span py:if="i.archivos_entrada">
				<a href="${tg.url('/tarea_prueba/comandos/file/archivos_entrada/%d' % i.id)}">Bajar</a>
			</span>
			<span py:if="not i.archivos_entrada">No tiene</span>
		</td>
		<td>
			<span py:if="i.archivos_a_comparar">
				<a href="${tg.url('/tarea_prueba/comandos/file/archivos_a_comparar/%d' % i.id)}">Bajar</a>
			</span>
			<span py:if="not i.archivos_a_comparar">No tiene</span>
		</td>
		<td py:if="'admin' in identity.current.permissions">
			<span py:if="i.archivos_a_guardar" py:content="', '.join(i.archivos_a_guardar)"></span>
			<span py:if="not i.archivos_a_guardar">No Guarda</span>
		</td>
	</tr>
</table>

<br/>
<a py:if="'admin' in identity.current.permissions" href="${tg.url('/tarea_prueba/edit/%d' % record.id)}">Editar</a> |
<a href="javascript:window.history.go(-1);">Volver</a>

</body>
</html>
