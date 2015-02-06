<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<?python from turbogears import identity ?>
<?python from sercom.model import TareaPrueba, TareaFuente ?>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:py="http://purl.org/kid/ns#"
    py:extends="'../../../../templates/master.kid'">
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" py:replace="''"/>
<title>show</title>
</head>
<body>

<table>
    <tr>
        <th>Orden:</th>
        <td><span py:replace="str(record.orden)">orden</span></td>
    </tr>
    <tr>
        <th>Comando:</th>
        <td><span py:replace="record.comando">comando</span></td>
    </tr>
    <tr>
        <th>Descripción:</th>
				<td><span py:replace="record.descripcion">descripcion</span></td>
    </tr>
    <tr py:if="'admin' in identity.current.permissions">
        <th>Archivos Entrada:</th>
				<td>
           <a py:if="record.archivos_entrada" href="${tg.url('/tarea_prueba/comandos/file/archivos_entrada/%d' % record.id)}">Bajar Entradas</a>
				</td>
    </tr>
    <tr py:if="'admin' in identity.current.permissions">
        <th>Archivos a Comparar:</th>
				<td>
           <a py:if="record.archivos_a_comparar" href="${tg.url('/tarea_prueba/comandos/file/archivos_a_comparar/%d' % record.id)}">Bajar Salidas</a>
				</td>
    </tr></table>

<br/>
<a py:if="'admin' in identity.current.permissions" href="${tg.url('/tarea_prueba/comandos/edit/%d' % record.id)}">Editar</a> |
<a href="javascript:window.history.go(-1);">Volver</a>

</body>
</html>
