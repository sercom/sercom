<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<?python 
    from turbogears import identity 
    from sercom.model import Permiso
?>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:py="http://purl.org/kid/ns#"
    py:extends="'../../../../../templates/master.kid'">
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" py:replace="''"/>
<title>list</title>
</head>
<body>

<h1>Listado de Imagenes</h1>

<table class="list">
    <tr>
        <th>Nombre</th>
        <th>Tamaño</th>
        <th>Archivo</th>
        <th>Fecha</th>
        <th>Imagen</th>
        <th>URL</th>
    </tr>
    <tr py:for="record in records">
        <td><span py:replace="record.nombre">nombre</span></td>
        <td align="left"><span py:replace="record.tamanio">tamanio</span></td>
        <td><span py:replace="record.nombre_archivo">archivo</span></td>
        <td><span py:replace="record.fecha">fecha</span></td>
        <td><img style="width:70px;height:70px" src="${tg.url('/examenes/pregunta/imagen/show/%d' % record.id)}" /></td>
        <td>${'/examenes/pregunta/imagen/show/%d' % record.id}</td>
    </tr>
</table>

<br/>
<a href="${tg.url('/examenes/pregunta/imagen/new')}">Agregar</a>

<div py:for="page in tg.paginate.pages">
    <a py:if="page != tg.paginate.current_page"
        href="${tg.paginate.get_href(page)}">${page}</a>
    <b py:if="page == tg.paginate.current_page">${page}</b>
</div>

</body>
</html>

<!-- vim: set et sw=4 sts=4 : -->

