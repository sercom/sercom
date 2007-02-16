<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:py="http://purl.org/kid/ns#"
    py:extends="'../../../templates/master.kid'">
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" py:replace="''"/>
<title>list</title>
</head>
<body>

<h1>Administración de <span py:replace="namepl">Objetos</span></h1>

<table>
    <tr>
        <th title="Activo">A</th>
        <th>Usuario</th>
        <th>Nombre</th>
        <th>E-Mail</th>
        <th>Teléfono</th>
        <th>Nombrado</th>
        <th>Observaciones</th>
        <th>Enunciados</th>
        <th>Operaciones</th>
    </tr>
    <tr py:for="record in records">
        <td><input type="checkbox" onclick="var f =
            document.createElement('form'); this.parentNode.appendChild(f);
            f.method = 'POST'; f.action = '${tg.url('/docente/activate/%d/%d' % (record.id, int(not record.activo)))}';
            f.submit(); return false;" py:attrs="checked=tg.checker(record.activo)" /></td>
        <td><a href="${tg.url('/docente/show/%d' % record.id)}"><span py:replace="record.usuario">usuario</span></a></td>
        <td><span py:replace="record.nombre">nombre</span></td>
        <td><a py:if="record.email" href="mailto:${record.email}"><span py:replace="record.email">email</span></a></td>
        <td><span py:replace="tg.summarize(record.telefono, 10)">telefono</span></td>
        <td><span py:replace="record.nombrado">nombrado</span></td>
        <td><span py:replace="tg.summarize(record.observaciones, 20)">observaciones</span></td>
        <td><a py:if="len(record.enunciados)" href="${tg.url('/enunciado/list/%d' % record.id)}"><span
                    py:replace="len(record.enunciados)">cant</span></a></td>
        <td><a href="${tg.url('/docente/edit/%d' % record.id)}">Editar</a>
            <a href="${tg.url('/docente/delete/%d' % record.id)}" onclick="if (confirm('${_(u'Estás seguro? Tal vez sólo quieras desactivarlo mejor...')}')) { var f = document.createElement('form'); this.parentNode.appendChild(f); f.method = 'POST'; f.action = this.href; f.submit(); };return false;">Eliminar</a></td>
    </tr>
</table>

<br/>
<a href="${tg.url('/docente/new')}">Agregar</a>

<div py:for="page in tg.paginate.pages">
    <a py:if="page != tg.paginate.current_page"
        href="${tg.paginate.get_href(page)}">${page}</a>
    <b py:if="page == tg.paginate.current_page">${page}</b>
</div>

</body>
</html>

<!-- vim: set et sw=4 sts=4 : -->
