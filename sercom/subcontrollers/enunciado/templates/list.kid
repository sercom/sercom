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
        <th>Nombre</th>
        <th>Descripción</th>
        <th>Autor</th>
        <th title="Casos de Prueba">CP</th>
        <th>Operaciones</th>
    </tr>
    <tr py:for="record in records">
        <td><a href="${tg.url('/enunciado/show/%d' % record.id)}"><span py:replace="record.nombre">nombre</span></a></td>
        <td><span py:replace="tg.summarize(record.descripcion, 30)">descripción</span></td>
        <td><a py:if="record.autorID is not None"
                href="${tg.url('/docente/show/%d' % record.autor.id)}"><span
                    py:replace="tg.summarize(record.autor.shortrepr(), 30)">autor</span></a></td>
        <td><a py:if="len(record.casos_de_prueba)"
                href="${tg.url('/caso_de_prueba/list/%d' % record.id)}"><span
                    py:replace="len(record.casos_de_prueba)">cant</span></a></td>
        <td><a href="${tg.url('/enunciado/edit/%d' % record.id)}">Editar</a>
            <a href="${tg.url('/enunciado/delete/%d' % record.id)}" onclick="if (confirm('${_(u'Estás seguro? Yo creo que no...')}')) { var f = document.createElement('form'); this.parentNode.appendChild(f); f.method = 'POST'; f.action = this.href; f.submit(); };return false;">Eliminar</a></td>
    </tr>
</table>

<br/>
<a href="${tg.url('/enunciado/new')}">Agregar</a>

<div py:for="page in tg.paginate.pages">
    <a py:if="page != tg.paginate.current_page"
        href="${tg.paginate.get_href(page)}">${page}</a>
    <b py:if="page == tg.paginate.current_page">${page}</b>
</div>

</body>
</html>

<!-- vim: set et sw=4 sts=4 : -->
