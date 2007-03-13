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
        <th>Curso:</th>
        <td><span py:replace="record.curso.shortrepr()">curso</span></td>
    </tr>
    <tr>
        <th>Tutores:</th>
				<td>
					<span py:for="a in record.tutores">
						<span py:replace="a.docente.shortrepr()" />
						<br />
					</span>		
				</td>
    </tr>
    <tr>
			<th>Responsable:</th>
			<td><span py:if="record.responsable is not None" py:replace="record.responsable.shortrepr()">numero</span></td>
    </tr>
    <tr>
        <th>Integrantes:</th>
				<td>
					<span py:for="a in record.miembros">
						<a href="${tg.url('/curso/alumno/show/%d/%d' % (a.alumno.id, a.alumno.curso.id))}" py:content="a.alumno.shortrepr()" />
						<br />
					</span>		
				</td>
    </tr>
</table>

<br/>
<a href="${tg.url('/grupo/edit/%d' % record.id)}">Editar</a> |
<a href="${tg.url('/grupo/list')}">Volver</a>

</body>
</html>
