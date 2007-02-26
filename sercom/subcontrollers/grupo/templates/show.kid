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
        <th>Curso:</th>
        <td><span py:replace="record.curso">curso</span></td>
    </tr>
    <tr>
        <th>Docente:</th>
	<td><span py:replace="record.docente">docente</span></td>
    </tr>
    <tr>
        <th>Corrige:</th>
	<td><span py::replace="record.numero">numero</span></td>
    </tr>
    <tr>
        <th>Descripcion:</th>
				<td><span py:if="record.corrige">SI</span></td>
				<td><span py:if="not record.corrige">NO</span></td>
    </tr>
</table>

<br/>
<a href="${tg.url('/docente_inscripto/edit/%d' % record.id)}">Editar</a> |
<a href="${tg.url('/docente_inscripto/list')}">Volver</a>

</body>
</html>
