<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:py="http://purl.org/kid/ns#"
    py:extends="'../../../templates/master.kid'">
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" py:replace="''"/>
<title>show</title>
</head>
<body>

<table>
    <tr>
        <th>Curso:</th>
				<td>
					<a href="${tg.url('/curso/show/%d' % record.curso.id)}">
						<span py:replace="record.curso.shortrepr()">nombre</span>
					</a>
				</td>
    </tr>
    <tr>
        <th>Número:</th>
	<td><span py:replace="record.numero">descripcion</span></td>
    </tr>
    <tr>
        <th>Enunciado:</th>
	<td>
		<a href="${tg.url('/enunciado/show/%d' % record.enunciado.id)}">
			<span py:replace="record.enunciado.shortrepr()">autor</span>
		</a>
	</td>
    </tr>
    <tr>
        <th>Es grupal?:</th>
	<td>
			<span py:replace="record.grupal">grupal</span>
	</td>
  </tr>
</table>

<br/>
<a href="${tg.url('/enunciado/edit/%d' % record.id)}">Editar</a> |
<a href="${tg.url('/enunciado/list')}">Volver</a>

</body>
</html>
