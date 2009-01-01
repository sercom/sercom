<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:py="http://purl.org/kid/ns#"
    py:extends="'../../../../templates/master.kid'">
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" py:replace="''"/>
<title>list</title>
</head>
<body>

<h1>Administración de <span py:replace="namepl">Objetos</span></h1>

<table class="list">
    <tr>
        <th>Descripcion</th>
        <th>Operaciones</th>
    </tr>
    <tr py:for="record in records">
        <td><span py:replace="record.descripcion">descripcion</span></td>
        <td><a href="${tg.url('/examenes/tema/show/%d' % record.id)}">Ver</a>
            <a href="${tg.url('/examenes/tema/edit/%d' % record.id)}">Editar</a>
            <a href="${tg.url('/examenes/tema/delete/%d' % record.id)}">Eliminar</a>
	</td>
    </tr>
</table>

<br/>
<a href="${tg.url('/examenes/tema/new')}">Agregar</a> | 
<a href="${tg.url('/examenes')}">Volver</a>

<div py:for="page in tg.paginate.pages">
    <a py:if="page != tg.paginate.current_page"
        href="${tg.paginate.get_href(page)}">${page}</a>
    <b py:if="page == tg.paginate.current_page">${page}</b>
</div>

</body>
</html>

<!-- vim: set et sw=4 sts=4 : -->
