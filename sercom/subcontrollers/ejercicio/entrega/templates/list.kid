<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:py="http://purl.org/kid/ns#"
    py:extends="'../../../../templates/master.kid'">
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" py:replace="''"/>
<title>list</title>
</head>
<body>

<h1>Administración de <span py:replace="namepl">Objetos</span></h1>

<table>
    <tr>
        <th>Nro</th>
        <th>Inicio</th>
        <th>Fin</th>
        <th>Procesada?</th>
        <th>Activa?</th>
        <th>Observaciones</th>
        <th>Operaciones</th>
    </tr>
    <tr py:for="record in records">
        <td><span py:replace="record.numero">numero</span></td>
        <td><span py:replace="record.inicio">inicio</span></td>
        <td><span py:replace="record.fin">fin</span></td>
        <td><span py:replace="record.procesada">procesada</span></td>
        <td><span py:replace="record.activo">activa</span></td>
        <td><span py:replace="record.observaciones">obs</span></td>
        <td>
            <a href="${tg.url('/entrega/delete/%d' % record.id)}" onclick="if (confirm('${_(u'Estás seguro? Yo creo que no...')}')) { var f = document.createElement('form'); this.parentNode.appendChild(f); f.method = 'POST'; f.action = this.href; f.submit(); };return false;">Eliminar</a>
        </td>
    </tr>
</table>

<br/>
<a href="${tg.url('/entrega/new/'+parcial)}">Agregar</a>
<a href="${tg.url('/ejercicio/list')}">Volver a Ejericicios</a>

<div py:for="page in tg.paginate.pages">
    <a py:if="page != tg.paginate.current_page"
        href="${tg.paginate.get_href(page)}">${page}</a>
    <b py:if="page == tg.paginate.current_page">${page}</b>
</div>

</body>
</html>

<!-- vim: set et sw=4 sts=4 : -->
