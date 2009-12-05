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
        <th>Curso:</th>
        <td><span py:replace="record.curso">curso</span></td>
    </tr>
    <tr>
        <th>Alumno:</th>
	<td><span py:replace="record.alumno">nombre</span></td>
    </tr>
     <tr>
        <th>Correo Electrónico:</th>
	<td><a href="${'mailto:'+record.alumno.email}">"<span py:replace="record.alumno">nombre</span>" &lt;<span py:replace="record.alumno.email">mail</span>&gt;,</a></td>
    </tr>
    <tr>
        <th>Condicional:</th>
	<td><span py:replace="record.condicional">condicional</span></td>
    </tr>
    <tr>
        <th>Tutor:</th>
	<td><span py:if="record.tutor" py:replace="record.tutor">tutor</span></td>
    </tr>
    <tr>
        <th>Responsabilidades:</th>
	      <td>
            <ul>
                <li py:for="i in record.responsabilidades">
                    ${i}
                </li>
            </ul>
        </td>
    </tr>
    <tr>
        <th>Grupos a los que Pertenece:</th>
	      <td>
            <ul>
                <li py:for="i in record.membresias">
                    ${i.grupo}
                </li>
            </ul>
        </td>
    </tr>
    <tr>
        <th>Correcciones :</th>
	      <td>
            <ul>
                <li py:for="i in record.correcciones">
                    ${i}
                </li>
            </ul>
        </td>
    </tr>
</table>

<br/>
<a href="javascript:window.history.go(-1)">Volver</a>

</body>
</html>
