<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<?python from turbogears import identity?>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:py="http://purl.org/kid/ns#"
    py:extends="'../../../../templates/master.kid'">
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" py:replace="''"/>
<title>show</title>
</head>
<body>

<table class="show">
    <tr>
        <th>Examen:</th>
        <td><span py:replace="record.examen.fecha">examen-fecha</span></td>
    </tr>
    <tr>
        <th>Numero:</th>
        <td><span py:replace="record.numero">numero</span></td>
    </tr>
    <tr>
        <th>Tipo:</th>
        <td><span py:if="record.tipo" py:replace="record.tipo.descripcion">tipo</span></td>
    </tr>
    <tr>
        <th>Tema:</th>
        <td><span py:if="record.tema" py:replace="record.tema.descripcion">tema</span></td>
    </tr>
    <tr>
        <th>Texto:</th>
        <td><span py:if="record.texto">${XML(record.texto)}</span></td>
    </tr>
    <tr>
        <th>Respuesta:</th>
        <td><span>${XML(record.get_respuesta_unica())}</span></td>
    </tr>


</table>

<br/>
<div style="display:inline" py:if="'admin' in identity.current.permissions">
    <a href="${tg.url('/examenes/pregunta/edit/%d' % record.id)}">Editar</a> |
</div>
<a href="${tg.url('/examenes/show/%d' % record.examen.id)}">Volver</a>
</body>
</html>
