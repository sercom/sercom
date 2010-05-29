<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<?python
    from sercom.model import Permiso
?>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:py="http://purl.org/kid/ns#"
    py:extends="'../../../templates/master.kid'">
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" py:replace="''"/>
<title>list</title>
</head>
<body>

<h1>Administración de <span py:replace="namepl">Objetos</span></h1>

<a href="${tg.url('/alumno/new')}">Agregar</a>
<a href="${tg.url('/alumno/from_file')}">Agregar desde Archivo</a>
<div py:for="page in tg.paginate.pages" py:strip="True">
    <a py:if="page != tg.paginate.current_page" 
        href="${tg.paginate.get_href(page)}">${page}</a>
    <b py:if="page == tg.paginate.current_page">${page}</b>
</div>
<form action="" method="GET">
<table class="list">
    <tr>
        <th>Padrón</th>
        <th>Nombre</th>
        <th>E-Mail</th>
        <th>Teléfono</th>
        <th>Operaciones</th>
    </tr>
    <tr>
        <td><input type="text" id="fpadron" name="padron" value="${filter['padron']}" size="8" class="filter" /></td>
        <td><input type="text" id="fnombre" name="nombre" value="${filter['nombre']}" size="23" class="filter" /></td>
        <td><input type="text" id="fmail" name="mail" value="${filter['mail']}" size="23" class="filter" /></td>
        <td></td>
        <td><input type="submit" value="Filtrar" class="filter" /></td>
    </tr>
    <tr py:for="record in records">
        <td><span py:replace="record.usuario">usuario</span></td>
        <td><span py:replace="record.nombre">nombre</span></td>
        <td><a py:if="record.email" href="mailto:${record.email}"><span py:replace="tg.summarize(record.email, 30)">email</span></a></td>
        <td><span py:replace="tg.summarize(record.telefono, 12)">telefono</span></td>
        <td><a href="${tg.url('/alumno/show/%d' % record.id)}">Ver</a>
            <a py:if="Permiso.alumno_editar.nombre in tg.identity.permissions"  href="${tg.url('/alumno/edit/%d' % record.id)}">Editar</a>
            <a py:if="Permiso.alumno_eliminar.nombre in tg.identity.permissions" href="${tg.url('/alumno/delete/%d' % record.id)}" onclick="if (confirm('${_(u'Estás seguro? Tal vez sólo quieras desactivarlo mejor...')}')) { var f = document.createElement('form'); this.parentNode.appendChild(f); f.method = 'POST'; f.action = this.href; f.submit(); };return false;">Eliminar</a></td>
    </tr>
</table>
</form>
<br/>
<a href="${tg.url('/alumno/new')}">Agregar</a>
<a href="${tg.url('/alumno/from_file')}">Agregar desde Archivo</a>
<div py:for="page in tg.paginate.pages" py:strip="True">
    <a py:if="page != tg.paginate.current_page" 
        href="${tg.paginate.get_href(page)}">${page}</a>
    <b py:if="page == tg.paginate.current_page">${page}</b>
</div>

</body>
</html>

<!-- vim: set et sw=4 sts=4 : -->
