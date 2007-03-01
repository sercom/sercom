<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:py="http://purl.org/kid/ns#"
    py:extends="'../../../templates/master.kid'">
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" py:replace="''"/>
<title>list</title>
</head>
<body>

<h1>Administración de <span py:replace="namepl">Objetos</span></h1>

<table class="list">
    <tr>
        <th>Instancia de Entrega</th>
        <th>Entregador</th>
        <th>Entregas</th>
        <th>Corrector</th>
        <th>Asignado</th>
        <th>Corregido</th>
        <th>Corregido</th>
				<th>Nota</th>
    </tr>
    <tr py:for="record in records">
        <td><span py:replace="record.instancia.shortrepr()">usuario</span></td>
        <td><span py:replace="record.entregador.shortrepr()">nombre</span></td>
        <td><span py:replace="len(record.entregas)">email</span></td>
        <td><span py:replace="record.corrector.shortrepr()">telefono</span></td>
        <td><span py:replace="record.asignado">nota</span></td>
        <td><span py:replace="record.corregido">observaciones</span></td>
        <td><span py:replace="record.nota">observaciones</span></td>
				<td>
					<a py:if="not record.corregido and not record.nota" href="${tg.url('/correccion/edit/%d' % record.id)}">Corregir</a>
					<a py:if="record.corregido and record.nota" href="${tg.url('/correccion/edit/%d' % record.id)}">Editar</a>
				</td>
    </tr>
</table>

<div py:for="page in tg.paginate.pages">
    <a py:if="page != tg.paginate.current_page"
        href="${tg.paginate.get_href(page)}">${page}</a>
    <b py:if="page == tg.paginate.current_page">${page}</b>
</div>

</body>
</html>

<!-- vim: set et sw=4 sts=4 : -->
