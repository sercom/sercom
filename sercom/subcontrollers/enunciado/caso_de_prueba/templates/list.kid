<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:py="http://purl.org/kid/ns#"
    py:extends="'../../../../templates/master.kid'">
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" py:replace="''"/>
<title>list</title>
</head>
<body>

<h1>Administración de <span py:replace="namepl">Objetos</span></h1>

<table class="list">
    <tr>
        <th>Nombre</th>
        <th>Comando</th>
        <th title="Código de retorno">RET</th>
        <th title="Es público?">PUB</th>
        <th>Operaciones</th>
    </tr>
    <tr py:for="record in records">
        <td><span py:replace="record.nombre">nombre</span></td>
        <td><span py:if="record.comando" py:replace="record.comando">comando --con-parámetros</span></td>
        <td><span py:replace="record.retorno">retorno</span></td>
        <td><span py:replace="tg.strbool(record.publico)">No</span></td>
        <td>
            <a href="${tg.url('/caso_de_prueba/show/%d'% record.id)}">Ver</a>
            <a href="${tg.url('/enunciado/caso_de_prueba/edit/%d' % record.id)}">Editar</a>
            <a href="${tg.url('/enunciado/caso_de_prueba/delete/%d/%d' % (record.enunciado.id, record.id))}" onclick="if (confirm('${_(u'Estás seguro? Yo creo que no...')}')) { var f = document.createElement('form'); this.parentNode.appendChild(f); f.method = 'POST'; f.action = this.href; f.submit(); };return false;">Eliminar</a></td>
    </tr>
</table>

<br/>
<a href="${tg.url('/enunciado/caso_de_prueba/new/%d' % enunciado)}">Agregar</a>
<a href="${tg.url('/enunciado/list')}">Volver</a>

<div py:for="page in tg.paginate.pages">
    <a py:if="page != tg.paginate.current_page"
        href="${tg.paginate.get_href(page)}">${page}</a>
    <b py:if="page == tg.paginate.current_page">${page}</b>
</div>

</body>
</html>

<!-- vim: set et sw=4 sts=4 : -->
