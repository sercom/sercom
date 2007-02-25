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
        <th>Curso</th>
        <th>Numero</th>
        <th>Enunciado</th>
        <th>Es Grupal?</th>
        <th>Operaciones</th>
    </tr>
    <tr py:for="record in records">
        <td><a href="${tg.url('/curso/show/%d' % record.id)}"><span py:replace="record.curso.shortrepr()">curso</span></a></td>
        <td><span py:replace="record.numero">numero</span></td>
        <td><a py:if="record.enunciadoID is not None"
                href="${tg.url('/enunciado/show/%d' % record.enunciado.id)}"><span
                    py:replace="record.enunciado.shortrepr()">enunciado</span></a></td>
        <td>
            <span py:replace="record.grupal">grupal</span>
        </td>
        <td>
            <a href="${tg.url('/ejercicio/entrega/%d' % record.id)}">Entregas</a>
            <a href="${tg.url('/ejercicio/edit/%d' % record.id)}">Editar</a>
            <a href="${tg.url('/ejercicio/delete/%d' % record.id)}" onclick="if (confirm('${_(u'Estás seguro? Yo creo que no...')}')) { var f = document.createElement('form'); this.parentNode.appendChild(f); f.method = 'POST'; f.action = this.href; f.submit(); };return false;">Eliminar</a>
        </td>
    </tr>
</table>

<br/>
<a href="${tg.url('/ejercicio/new')}">Agregar</a>
<a py:if="parcial" href="${tg.url('/ejercicio/list')}">Ver todo</a>

<div py:for="page in tg.paginate.pages">
    <a py:if="page != tg.paginate.current_page"
        href="${tg.paginate.get_href(page)}">${page}</a>
    <b py:if="page == tg.paginate.current_page">${page}</b>
</div>

</body>
</html>

<!-- vim: set et sw=4 sts=4 : -->
