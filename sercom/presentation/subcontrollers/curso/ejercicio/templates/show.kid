<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:py="http://purl.org/kid/ns#"
    py:extends="'../../../../templates/master.kid'">
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
        <th>Enunciado:</th>
	<td>
		<a href="${tg.url('/enunciado/show/%d' % record.enunciado.id)}">
			<span py:replace="record.enunciado">autor</span>
		</a>
	</td>
    </tr>
    <tr>
        <th>Es grupal?:</th>
				<td>
					<span py:replace="tg.strbool(record.grupal)">grupal</span>
				</td>
  </tr>
    <tr>
        <th>Instancias de Entrega:</th>
				<td>
					<ul>
						<li py:for="i in record.instancias">
							${i.numero} -
							${i.inicio} -
							${i.fin}
						</li>	
					</ul>
				</td>
  </tr>
</table>

<br/>
<a href="${tg.url('/curso/ejercicio/edit/%s' % record.id)}">Editar</a> |
<a href="${tg.url('/curso/ejercicio/list/%s' % record.cursoID)}">Volver</a>

</body>
</html>
