<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:py="http://purl.org/kid/ns#"
    py:extends="'../../../../templates/master.kid'">
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" py:replace="''"/>
<title>list</title>
</head>
<body>

<h1><span py:replace="namepl">Objetos</span> del Curso <span py:replace="curso">Curso</span></h1>

<table class="list">
    <tr>
        <th>Docente</th>
        <th>Corrige?</th>
        <th>Observaciones</th>
				<th>Operaciones</th>
    </tr>
    <tr py:for="record in records">
        <td><a href="${tg.url('/docente/show/%d' % record.docente.id)}"><span py:replace="record.docente">docentes</span></a></td> 
        <td align="center"><span py:replace="tg.strbool(record.corrige)">Si/No</span></td>
        <td><span py:replace="record.observaciones">observaciones</span></td>
				<td>
					<a href="${tg.url('/curso/docente/edit/%d' % record.id)}">Editar</a>
					<a href="${tg.url('/curso/docente/delete/%d/%d' % (record.curso.id, record.id))}" onclick="if (confirm('${_(u'Estás seguro? Tal vez sólo quieras desactivarlo mejor...')}')) { var f = document.createElement('form'); this.parentNode.appendChild(f); f.method = 'POST'; f.action = this.href; f.submit(); };return false;">Eliminar</a>
				</td>
    </tr>
</table>

<br/>

<a href="${tg.url('/curso/docente/new/%d' % curso.id)}">Agregar</a> |
<a href="${tg.url('/curso/list')}">Volver</a>

<div py:for="page in tg.paginate.pages">
    <a py:if="page != tg.paginate.current_page"
        href="${tg.paginate.get_href(page)}">${page}</a>
    <b py:if="page == tg.paginate.current_page">${page}</b>
</div>

</body>
</html>

<!-- vim: set et sw=4 sts=4 : -->
