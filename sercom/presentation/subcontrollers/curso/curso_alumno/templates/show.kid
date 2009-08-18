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
        <th>Anio:</th>
        <td><span py:replace="record.anio">anio</span></td>
    </tr>
    <tr>
        <th>Cuatrimestre:</th>
	<td><span py:replace="record.cuatrimestre">cuatrimestre</span></td>
    </tr>
    <tr>
        <th>Numero:</th>
	<td><span py:replace="record.numero">numero</span></td>
    </tr>
    <tr>
        <th>Descripcion:</th>
	<td><span py:replace="record.descripcion">descripcion</span></td>
    </tr>
    <tr>
        <th>Docentes:</th>
	<td><span py:replace="len(record.docentes)">Docentes</span></td>
    </tr>
    <tr>
        <th>Alumnos:</th>
	<td><span py:replace="len(record.alumnos)">alumnos</span></td>
    </tr>
    <tr>
        <th>Grupos:</th>
	<td><span py:replace="len(record.grupos)">grupos</span></td>
    </tr>
    <tr>
        <th>Ejercicios:</th>
	<td><span py:replace="len(record.ejercicios)">ejercicios</span></td>
    </tr>
</table>

<br/>
<a href="${tg.url('/curso/edit/%d' % record.id)}">Editar</a> |
<a href="${tg.url('/curso/list')}">Volver</a>

</body>
</html>
