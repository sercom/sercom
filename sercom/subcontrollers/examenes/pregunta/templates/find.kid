<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:py="http://purl.org/kid/ns#"
    py:extends="'../../../../templates/master.kid'">
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" py:replace="''"/>
<title>list</title>
</head>
<body>

<h1>Busqueda de <span py:replace="namepl">Objetos</span></h1>
<div py:replace="form(value=vfilter, action=tg.url('/examenes/pregunta/find'), submit_text=_(u'Filtrar'))">Filtros</div>


<table class="list">
    <tr>
        <th style="width:130px">Examen</th>
        <th style="width:50px">Número Pregunta</th>
        <th>Texto</th>
        <th style="width:50px">Operaciones</th>
    </tr>
    <tr py:for="record in records">
        <td><span py:replace="record.examen">examen</span></td>
        <td><span py:replace="record.numero">oportunidad</span></td>
        <td><span>${XML(record.texto)}</span></td>
        <td><a href="${tg.url('/examenes/show/%d' % record.examenID)}">Ver Examen</a></td>
    </tr>
</table>

<br/>

<a href="${tg.url('/examenes/list')}">Volver</a>

<div py:for="page in tg.paginate.pages">
    <a py:if="page != tg.paginate.current_page"
        href="${tg.paginate.get_href(page)}">${page}</a>
    <b py:if="page == tg.paginate.current_page">${page}</b>
</div>

</body>
</html>

<!-- vim: set et sw=4 sts=4 : -->
