<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:py="http://purl.org/kid/ns#"
    py:extends="'../../../../templates/master.kid'">
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" py:replace="''"/>
<title>list</title>
</head>
<body>

<h1><span py:replace="namepl">Objetos</span> del curso <span py:replace="curso.shortrepr()">Objetos</span></h1>

<table class="list">
    <tr>
        <th>Nombre</th>
        <th>Responsable</th>
        <th>Integrantes</th>
        <th>Tutores</th>
        <th>Operaciones</th>
    </tr>
    <tr py:for="record in records">
        <td><span py:replace="record.nombre">nombre</span></td>
        <td><a py:if="record.responsable is not None" href="${tg.url('/curso/alumno/show/'+str(record.responsable.alumno.id))}" py:content="record.responsable.alumno.shortrepr()"></a></td>
        <td><span py:replace="', '.join((ai.alumno.padron for ai in record.alumnos))">tito, juanca</span></td>
        <td><span py:replace="', '.join((di.docente.usuario for di in record.docentes))">tito, juanca</span></td>
        <td>
            <a href="${tg.url('/curso/grupo/show/%d' % record.id)}">Ver</a>
            <a href="${tg.url('/curso/grupo/edit/%d' % record.id)}">Editar</a>
            <a href="${tg.url('/curso/grupo/delete/%d/%d' % (record.curso.id, record.id))}" onclick="if (confirm('${_(u'Estás seguro? Tal vez sólo quieras desactivarlo mejor...')}')) { var f = document.createElement('form'); this.parentNode.appendChild(f); f.method = 'POST'; f.action = this.href; f.submit(); };return false;">Eliminar</a>
        </td>
    </tr>
</table>

<br/>
<a href="${tg.url('/curso/grupo/new/%d' % curso.id)}">Agregar</a> |
<a href="${tg.url('/curso/grupo/admin/%d' % curso.id)}">Mezclar, Juntar, Separar</a> |
<a href="${tg.url('/curso/list')}">Volver a Cursos</a>
<br/>
<br/>
<br/>
<br/>
<div py:for="page in tg.paginate.pages">
    <a py:if="page != tg.paginate.current_page"
        href="${tg.paginate.get_href(page)}">${page}</a>
    <b py:if="page == tg.paginate.current_page">${page}</b>
</div>

</body>
</html>

<!-- vim: set et sw=4 sts=4 : -->
