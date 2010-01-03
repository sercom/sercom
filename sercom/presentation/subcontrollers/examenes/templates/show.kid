<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<?python 
from turbogears import identity
from sercom.model import Permiso
?>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:py="http://purl.org/kid/ns#"
    py:extends="'../../../templates/master.kid'">
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" py:replace="''"/>
<title>show</title>
</head>
<body>

<table class="show">
    <tr>
        <th>Fecha:</th>
        <td><span py:replace="record.str_fecha()">fecha</span></td>
    </tr>
    <tr>
        <th>Periodo:</th>
        <td><span py:replace="record.periodo()">periodo</span></td>
    </tr>
    <tr>
        <th>Oportunidad:</th>
        <td><span py:replace="record.oportunidad">oportunidad</span></td>
    </tr>
    <tr>
        <th>Preguntas:</th>
        <td>
            <table style="width:100%">
            <div py:for="pregunta in record.preguntas">
               <tr>
                    <td>
                        <div><span py:replace="pregunta.numero">Numero</span>)</div>
                       <span py:if="pregunta.texto">${XML(pregunta.texto)}</span>
                    </td>
                </tr>
                <tr style="height:30px;vertical-align:top">
                    <td>
                        <a href="${tg.url('/examenes/pregunta/show/%d' % pregunta.id)}">
                          <?python
                            tiene_respuestas=pregunta.tiene_respuestas_por_usuario(identity.current.user)
                          ?>
                            <span py:if="tiene_respuestas" >Detalle (incluye respuestas)</span>
                            <span py:if="not tiene_respuestas">Detalle</span>
                       </a>
                    </td>
                </tr>
                <tr>
                   <td><hr/></td>
                </tr>
            </div>
            </table>
        </td>
    </tr>
</table>

<br/>
<div style="display:inline" py:if="Permiso.examen.editar in identity.current.permissions">
    <a href="${tg.url('/examenes/edit/%d' % record.id)}">Editar</a> |
</div>
<a href="${tg.url('/examenes/list')}">Volver</a>

</body>
</html>
