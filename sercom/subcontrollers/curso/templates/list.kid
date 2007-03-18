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
        <th>#</th>
        <th>Nro</th>
        <th># Cuat.</th>
        <th>Anio</th>
        <th>Descripcion</th>
        <th>Docentes</th>
        <th>Alumnos</th>
        <th>Grupos</th>
        <th>Ejercicios</th>
        <th>Operaciones</th>
    </tr>
    <tr py:for="record in records">
        <td><span py:replace="record.id">id</span></td>
        <td align="center"><span py:replace="record.numero">numero</span></td>
        <td align="center"><span py:replace="record.cuatrimestre">cuatrimestre</span></td>
        <td align="center"><span py:replace="record.anio">anio</span></td>
        <td><span py:replace="record.descripcion">descripcion</span></td>
        <td align="center"><a href="${tg.url('/curso/docente/list/%d' % record.id)}"><span py:replace="len(record.docentes)">Docentes</span></a></td>
        <td align="center"><a href="${tg.url('/curso/alumno/list/%d' % record.id)}"><span py:replace="len(record.alumnos)">Alumnos</span></a></td>
        <td align="center"><a href="${tg.url('/curso/grupo/list/%d' % record.id)}"><span py:replace="len(record.grupos)">Grupos</span></a></td>
        <td align="center"><a href="${tg.url('/curso/ejercicio/list/%s' % record.id)}"><span py:replace="len(record.ejercicios)">Ejercicio</span></a></td>
        <td><a href="${tg.url('/curso/show/%d' % record.id)}">Ver</a>
            <a href="${tg.url('/curso/edit/%d' % record.id)}">Editar</a>
            <a href="${tg.url('/curso/notas/%d' % record.id)}">Notas</a>
            <a href="${tg.url('/curso/delete/%d' % record.id)}" onclick="if (confirm('${_(u'Estás seguro? Tal vez sólo quieras desactivarlo mejor...')}')) { var f = document.createElement('form'); this.parentNode.appendChild(f); f.method = 'POST'; f.action = this.href; f.submit(); };return false;">Eliminar</a></td>
    </tr>
</table>

<br/>
<a href="${tg.url('/curso/new')}">Agregar</a>

<div py:for="page in tg.paginate.pages">
    <a py:if="page != tg.paginate.current_page"
        href="${tg.paginate.get_href(page)}">${page}</a>
    <b py:if="page == tg.paginate.current_page">${page}</b>
</div>

</body>
</html>

<!-- vim: set et sw=4 sts=4 : -->
