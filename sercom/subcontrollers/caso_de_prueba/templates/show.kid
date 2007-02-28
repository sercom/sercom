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
        <th>Nombre:</th>
        <td><span py:replace="record.nombre">nombre</span></td>
    </tr>
    <tr>
        <th>Enunciado:</th>
	<td><a py:if="record.enunciadoID is not None"
			href="${tg.url('/enunciado/show/%d' % record.enunciado.id)}"><span
				py:replace="record.enunciado.shortrepr()">enunciado</span></a></td>
    </tr>
    <tr>
        <th>Descripción:</th>
	<td><span py:replace="XML(record.desc)">descripcion</span></td>
    </tr>
    <tr>
        <th>Parámetros:</th>
	<td>
            <span py:if="record.parametros" py:replace="params2str(record.parametros)">--parámetros</span>:
	</td>
    </tr>
    <tr>
        <th>Código de retorno:</th>
	<td><span py:replace="record.retorno">retorno</span></td>
    </tr>
    <tr>
        <th>Tiempo de CPU:</th>
	<td><span py:replace="record.tiempo_cpu">tiempo_cpu</span></td>
    </tr>
</table>

<br/>
<a href="${tg.url('/caso_de_prueba/edit/%d' % record.id)}">Editar</a> |
<a href="${tg.url('/caso_de_prueba/list')}">Volver</a>

</body>
</html>
