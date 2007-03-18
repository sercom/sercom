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
        <th>Orden</th>
        <th>Comando</th>
        <th>Operaciones</th>
    </tr>
    <tr py:for="record in records">
        <td><span py:replace="record.orden">telefono</span></td>
        <td><span py:replace="record.comando">telefono</span></td>
				<td>
						<a href="${tg.url('/tarea_prueba/comandos/show/%d' % record.id)}">Ver</a>
        		<a href="${tg.url('/tarea_prueba/comandos/edit/%d' % record.id)}">Editar</a>
            <a href="${tg.url('/tarea_prueba/comandos/delete/%d' % record.id)}" onclick="if (confirm('${_(u'EstÃ¡s seguro? Tal vez sÃ³lo quieras desactivarlo mejor...')}')) { var f = document.createElement('form'); this.parentNode.appendChild(f); f.method = 'POST'; f.action = this.href; f.submit(); };return false;">Eliminar</a></td>
    </tr>
</table>

<br/>
<a href="${tg.url('/tarea_prueba/comandos/new/%d' % tareaID)}">Agregar</a> |
<a href="${tg.url('/tarea_prueba/list/')}">Volver</a>

<div py:for="page in tg.paginate.pages">
    <a py:if="page != tg.paginate.current_page"
        href="${tg.paginate.get_href(page)}">${page}</a>
    <b py:if="page == tg.paginate.current_page">${page}</b>
</div>

</body>
</html>

<!-- vim: set et sw=4 sts=4 : -->
