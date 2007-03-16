<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:py="http://purl.org/kid/ns#"
    py:extends="'../../../../../templates/master.kid'">
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" py:replace="''"/>
<title>show</title>
</head>
<body>

    <table>
        <tr>
            <th>Número:</th>
            <td><span py:replace="record.numero">descripcion</span></td>
        </tr>
        <tr>
            <th>Inicio:</th>
            <td><span py:replace="record.inicio">2007/02/21 12:34:21</span></td>
        </tr>
        <tr>
            <th>Fin:</th>
            <td><span py:replace="record.fin">2007/02/21 12:34:21</span></td>
        </tr>
        <tr>
            <th>Inicio de procesamiento:</th>
            <td><span py:replace="record.inicio_proceso">2007/02/21 12:34:21</span></td>
        </tr>
        <tr>
            <th>Fin de procesamiento:</th>
            <td><span py:replace="record.inicio_proceso">2007/02/21 12:34:21</span></td>
        </tr>
        <tr>
            <th>Activo:</th>
            <td>
                <span py:replace="tg.strbool(record.activo)">No</span>
            </td>
        </tr>
        <tr>
            <th>Observaciones:</th>
            <td>
                <span py:replace="record.observaciones">Observaciones</span>
            </td>
        </tr>
    </table>

<br/>
<a href="${tg.url('/curso/ejercicio/entrega/edit/%s' % record.id)}">Editar</a> |
<a href="${tg.url('/curso/ejercicio/entrega/list/%s' % record.ejercicioID)}">Volver</a>

</body>
</html>
