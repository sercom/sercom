<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:py="http://purl.org/kid/ns#"
    py:extends="'../../../templates/master.kid'">
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" py:replace="''"/>
<title>list</title>
</head>
<body>

<h1>Administración de <span py:replace="namepl">Objetos</span></h1>

<div py:replace="form(value=vfilter, action=tg.url('/grupo/list'),	submit_text=_(u'Filtrar'))">Filtros</div>

<table class="list">
    <tr>
        <th>Curso</th>
        <th>Nombre</th>
        <th>Responsable</th>
        <th>Operaciones</th>
    </tr>
    <tr py:for="record in records">
            <td><a href="${tg.url('/curso/show/'+str(record.curso.id))}" py:content="record.curso.shortrepr()">curso</a></td>
        <td><span py:replace="record.nombre">nombre</span></td>
                <td><a py:if="record.responsable is not None" href="${tg.url('/alumno/show/'+str(record.responsable.alumno.id))}" py:content="record.responsable.alumno.shortrepr()"></a></td>
                <td>
                    <a href="${tg.url('/grupo/show/%d' % record.id)}">Ver</a>
                    <a href="${tg.url('/grupo/edit/%d' % record.id)}">Editar</a>
                    <a href="${tg.url('/grupo/delete/%d' % record.id)}" onclick="if (confirm('${_(u'Estás seguro? Tal vez sólo quieras desactivarlo mejor...')}')) { var f = document.createElement('form'); this.parentNode.appendChild(f); f.method = 'POST'; f.action = this.href; f.submit(); };return false;">Eliminar</a>
                </td>
    </tr>
</table>

<br/>
<a href="${tg.url('/grupo/new')}">Agregar</a>
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
