<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:py="http://purl.org/kid/ns#"
    py:extends="'../../../templates/master.kid'">
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" py:replace="''"/>
<title>list</title>
</head>
<body>

<h1>Administración de <span py:replace="namepl">Objetos</span></h1>

<?python from sercom.kidutil import resume ?>

<!-- ?python
def minimize(text, size=15):
    if text is not None and len(text) > size:
        text = text[:size] + '...'
    return text
? -->

<table>
    <tr>
        <th>Usuario</th>
        <th>Nombre</th>
        <th>E-Mail</th>
        <th>Teléfono</th>
        <th>Nombrado</th>
        <th>Activo</th>
        <th>Observaciones</th>
        <th>Operaciones</th>
    </tr>
    <tr py:for="record in records">
        <td><span py:replace="record.usuario">usuario</span></td>
        <td><span py:replace="record.nombre">nombre</span></td>
        <td><span py:replace="record.email">email</span></td>
        <td><span py:replace="resume(record.telefono, 10)">telefono</span></td>
        <td><span py:replace="record.nombrado">nombrado</span></td>
        <td><span py:replace="record.activo">activo</span></td>
        <td><span py:replace="resume(record.observaciones, 20)">observaciones</span></td>
        <td><a href="show/${record.id}">Ver</a>
            <a href="edit/${record.id}">Editar</a>
            <a href="delete/${record.id}" onclick="if (confirm('${_(u'Estás seguro? Tal vez sólo quieras desactivarlo mejor...')}')) { var f = document.createElement('form'); this.parentNode.appendChild(f); f.method = 'POST'; f.action = this.href; f.submit(); };return false;">Eliminar</a></td>
    </tr>
</table>

<br/>
<a href="new">Agregar</a>

<div py:for="page in tg.paginate.pages">
    <a py:if="page != tg.paginate.current_page"
        href="${tg.paginate.get_href(page)}">${page}</a>
    <b py:if="page == tg.paginate.current_page">${page}</b>
</div>

</body>
</html>
