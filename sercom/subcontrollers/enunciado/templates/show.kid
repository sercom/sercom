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
        <th>Nombre:</th>
        <td><span py:replace="record.nombre">nombre</span></td>
    </tr>
    <tr>
        <th>Descripción:</th>
	<td><span py:replace="XML(record.desc)">descripcion</span></td>
    </tr>
    <tr>
        <th>Autor:</th>
	<td><a py:if="record.autorID is not None"
			href="${tg.url('/docente/show/%d' % record.autor.id)}"><span py:replace="record.autor.shortrepr()">autor</span></a></td>
    </tr>
</table>

<br/>
<a href="${tg.url('/enunciado/edit/%d' % record.id)}">Editar</a> |
<a href="${tg.url('/enunciado/list')}">Volver</a>

</body>
</html>
