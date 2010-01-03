<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<?python from turbogears import identity 
from sercom.model import Permiso
?>
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
        <th>Fecha</th>
        <th>Periodo</th>
        <th>Oportunidad</th>
        <th>Operaciones</th>
    </tr>
    <tr py:for="record in records">
        <td><span py:replace="record.str_fecha()">fecha</span></td>
        <td><span py:replace="record.periodo()">periodo</span></td>
        <td><span py:replace="record.oportunidad">oportunidad</span></td>
        <td><a href="${tg.url('/examenes/show/%d' % record.id)}">Ver</a>
            <div style="display:inline" py:if="Permiso.examen.editar in identity.current.permissions"> 
                <a href="${tg.url('/examenes/edit/%d' % record.id)}">Editar</a>
                <a href="${tg.url('/examenes/delete/%d' % record.id)}">Eliminar</a>
            </div>
	</td>
    </tr>
</table>

<br/>

<a href="${tg.url('/examenes/pregunta/find')}">Buscar Preguntas</a>
<div style="display:inline" py:if="Permiso.examen.editar in identity.current.permissions"> | 
  <a href="${tg.url('/examenes/pregunta/imagen/list')}">Imagenes</a> | 
  <a py:if="Permiso.examen.tema.editar in identity.current.permissions" href="${tg.url('/examenes/tema')}">Editar Temas</a> | 
  <a py:if="Permiso.examen.tipo.editar in identity.current.permissions" href="${tg.url('/examenes/tipo')}">Editar Tipos</a> 
  <div style="display:inline" py:if="permitir_agregar"> |
    <a href="${tg.url('/examenes/new')}">Agregar</a> | 
    <a href="${tg.url('/examenes/from_file')}">Agregar desde Archivo</a> |
    <a href="${tg.url('/examenes/from_text')}">Agregar desde Texto</a>
  </div> 
</div>
<br/>
<div py:for="page in tg.paginate.pages" py:strip="True">
    <a py:if="page != tg.paginate.current_page"
        href="${tg.paginate.get_href(page)}">${page}</a>
    <b py:if="page == tg.paginate.current_page">${page}</b>
</div>
</body>
</html>

<!-- vim: set et sw=4 sts=4 : -->
