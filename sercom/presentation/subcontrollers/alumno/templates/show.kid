<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<?python
    from sercom.model import Permiso
?>

<html xmlns="http://www.w3.org/1999/xhtml" xmlns:py="http://purl.org/kid/ns#"
    py:extends="'../../../templates/master.kid'">
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" py:replace="''"/>
<title>show</title>
</head>
<body>

<table class="show">
    <tr>
        <th>Padrón:</th>
        <td><span py:replace="record.padron">padrón</span></td>
    </tr>
    <tr>
        <th>Nombre:</th>
	<td><span py:replace="record.nombre">nombre</span></td>
    </tr>
    <tr>
        <th>E-Mail:</th>
	<td><span py:replace="record.email">email</span></td>
    </tr>
    <tr>
        <th>Teléfono:</th>
	<td><span py:replace="record.telefono">telefono</span></td>
    </tr>
    <tr>
        <th>Activo:</th>
	<td><span py:replace="record.activo">activo</span></td>
    </tr>
    <tr>
        <th>Observaciones:</th>
	<td><span py:replace="XML(record.obs)">observaciones</span></td>
    </tr>
    <tr>
        <th>Cursos en que esta<br/>o estuvo Inscripto:</th>
	<td><ul><li py:for="i in record.inscripciones" ><span>${str(i.curso.descripcion)}</span>
		<table border="1">
			<tr>
			<th>Ejercicio</th>
			<th>Instancia</th>
			<th>Nota</th>
			<th>Corrector</th>
			</tr>
			<tr py:for="c in i.correcciones">
			<td>${c.entrega.instancia.ejercicio.numero}</td>
			<td>${c.entrega.instancia.numero}</td>
			<td>${c.nota}</td>
			<td>${c.corrector.docente.nombre}</td>
			</tr>
		</table>
        </li></ul></td>
    </tr>
</table>

<br/>
<span py:if="Permiso.alumno_editar.nombre in tg.identity.permissions">
<a href="${tg.url('/alumno/edit/%d' % record.id)}">Editar</a> |</span>
<a href="${tg.url('/alumno/list')}">Volver</a>

</body>
</html>
