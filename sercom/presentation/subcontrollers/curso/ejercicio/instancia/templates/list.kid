<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<?python from turbogears import identity ?>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:py="http://purl.org/kid/ns#"
    py:extends="'../../../../../templates/master.kid'">
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" py:replace="''"/>
<title>list</title>
</head>
<body>

<h1>Administración de <span py:replace="namepl">Objetos</span></h1>
<h2>Enunciado: <span py:replace="ejercicio.enunciado">Nombre Enunciado</span></h2>

<table class="list">
    <tr>
        <th>Nro</th>
        <th>Inicio</th>
        <th>Fin</th>
        <th>Procesada?</th>
        <th>En proceso?</th>
        <th>Activa?</th>
        <th>Entregas</th>
        <th>Observaciones</th>
        <th>Operaciones</th>
    </tr>
    <tr py:for="record in records">
        <td><span py:replace="record.numero">numero</span></td>
        <td><span py:replace="record.inicio">inicio</span></td>
        <td><span py:replace="record.fin">fin</span></td>
        <td align="center"><span py:replace="tg.strbool(record.fin_proceso is not None)">procesada</span></td>
        <td align="center"><span py:replace="tg.strbool(record.inicio_proceso is not None and record.fin_proceso is None)">en proceso</span></td>
        <td align="center"><span py:replace="tg.strbool(record.activo)">activa</span></td>
				<td align="center"><a href="${tg.url('/curso/ejercicio/instancia/entregas/%d' % record.id)}" py:content="len(record.entregas)">activa</a></td>
        <td><span py:replace="record.observaciones">obs</span></td>
        <td>
            <a py:if="'admin' in tg.identity.groups or 'JTP' in tg.identity.groups or 'redactor' in tg.identity.groups" href="${tg.url('/curso/ejercicio/instancia/show/%d' % record.id)}">Ver</a>
            <a py:if="'admin' in tg.identity.groups or 'JTP' in tg.identity.groups or 'redactor' in tg.identity.groups" href="${tg.url('/curso/ejercicio/instancia/edit/%d' % record.id)}">Editar</a>
            <a py:if="'admin' in tg.identity.groups or 'JTP' in tg.identity.groups or 'redactor' in tg.identity.groups" href="${tg.url('/curso/ejercicio/instancia/delete/%d' % record.id)}" onclick="if (confirm('${_(u'Estás seguro? Yo creo que no...')}')) { var f = document.createElement('form'); this.parentNode.appendChild(f); f.method = 'POST'; f.action = this.href; f.submit(); };return false;">Eliminar</a>
        </td>
    </tr>
</table>

<br/>
<a py:if="'admin' in tg.identity.groups or 'JTP' in tg.identity.groups or 'redactor' in tg.identity.groups" href="${tg.url('/curso/ejercicio/instancia/new/%s' % ejercicio.id)}">Agregar</a> |
<a py:if="'admin' in tg.identity.groups or 'JTP' in tg.identity.groups" href="${tg.url('/curso/ejercicio/list/%s' % ejercicio.curso.id)}">Volver a Ejericicios</a>

<a py:if="'redactor' in tg.identity.groups" href="${tg.url('/enunciado/list/')}">Volver a Enunciados</a>

<div py:for="page in tg.paginate.pages">
    <a py:if="page != tg.paginate.current_page"
        href="${tg.paginate.get_href(page)}">${page}</a>
    <b py:if="page == tg.paginate.current_page">${page}</b>
</div>

</body>
</html>

<!-- vim: set et sw=4 sts=4 : -->
