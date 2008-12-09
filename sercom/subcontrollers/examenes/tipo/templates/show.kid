<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:py="http://purl.org/kid/ns#"
    py:extends="'../../../../templates/master.kid'">
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" py:replace="''"/>
<title>show</title>
</head>
<body>

<table class="show">
    <tr>
        <th>Descripcion:</th>
        <td><span py:replace="record.descripcion">descripcion</span></td>
    </tr>
</table>

<br/>
<a href="${tg.url('/examenes/tipo/edit/%d' % record.id)}">Editar</a> |
<a href="${tg.url('/examenes/tipo/list')}">Volver</a>

</body>
</html>
