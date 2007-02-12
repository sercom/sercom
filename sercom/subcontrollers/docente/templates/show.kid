<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:py="http://purl.org/kid/ns#"
    py:extends="'../../../templates/master.kid'">
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" py:replace="''"/>
<title>show</title>
</head>
<body>

<table>
    <tr>
        <th>Usuario:</th>
        <td><span py:replace="record.usuario">usuario</span></td>
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
        <th>Nombrado:</th>
	<td><span py:replace="record.nombrado">nombrado</span></td>
    </tr>
    <tr>
        <th>Activo:</th>
	<td><span py:replace="record.activo">activo</span></td>
    </tr>
    <tr>
        <th>Observaciones:</th>
	<td><span py:replace="XML(record.obs)">observaciones</span></td>
    </tr>
</table>

<br/>
<a href="${tg.url('/docente/edit/%d' % record.id)}">Editar</a> |
<a href="${tg.url('/docente/list')}">Volver</a>

</body>
</html>
