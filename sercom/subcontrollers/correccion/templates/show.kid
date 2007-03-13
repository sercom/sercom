<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:py="http://purl.org/kid/ns#"
    py:extends="'../../../templates/master.kid'">
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" py:replace="''"/>
<title>show</title>
</head>
<body>

<table class="show">
    <tr>
        <th>Instancia de Entrega:</th>
        <td><span py:replace="record.instancia.shortrepr()">record.padrón</span></td>
    </tr>
    <tr>
        <th>Entregador:</th>
	<td><span py:replace="record.entregador">nombre</span></td>
    </tr>
    <tr>
        <th>Entrega:</th>
	<td><span py:replace="record.entrega.shortrepr()">email</span></td>
    </tr>
    <tr>
        <th>Corrector:</th>
	<td><span py:replace="record.corrector">telefono</span></td>
    </tr>
    <tr>
        <th>Corregido el:</th>
	<td><span py:replace="record.corregido">nota</span></td>
    </tr>
    <tr>
        <th>Nota:</th>
	<td><span py:replace="record.nota">activo</span></td>
    </tr>
    <tr>
        <th>Observaciones:</th>
	<td><span py:replace="XML(record.observaciones)">observaciones</span></td>
    </tr>
</table>

<br/>
<a href="${tg.url('/correccion/list')}">Volver</a>

</body>
</html>
