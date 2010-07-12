<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<?python 
from turbogears import identity
from sercom.model import Permiso?>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:py="http://purl.org/kid/ns#"
    py:extends="'../../../../templates/master.kid'">
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" py:replace="''"/>
<title>show</title>
</head>
<body>

<table class="show">
    <tr>
        <th>Pregunta:</th>
        <td><span py:replace="record.pregunta">pregunta</span></td>
    </tr>

    <tr>
        <th>Texto:</th>
        <td><span py:if="record.texto">${XML(record.texto)}</span></td>
    </tr>
    <tr>
        <th>Revisada:</th>
        <td><span py:replace="record.revisada">revisada</span></td>
    </tr>
    <tr>
        <th>Autor:</th>
        <td><span py:replace="record.autor">autor</span></td>
    </tr>
</table>

<br/>
<div style="display:inline" py:if="Permiso.examen.editar in identity.current.permissions">
    <a href="${tg.url('/examenes/respuesta/edit/%d/%d' % (record.preguntaID, record.id))}">Editar</a> |
</div>
<a href="${tg.url('/examenes/pregunta/show/%d' % record.preguntaID)}">Volver</a>
</body>
</html>
