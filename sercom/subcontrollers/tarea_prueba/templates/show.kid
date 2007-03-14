<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:py="http://purl.org/kid/ns#"
    py:extends="'../../../templates/master.kid'">
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

<br/>
<a href="${tg.url('/tarea_prueba/edit/%d' % record.id)}">Editar</a> |
<a href="${tg.url('/tarea_prueba/list')}">Volver</a>

</body>
</html>
