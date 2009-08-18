<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<?python from sercom.model import Grupo, AlumnoInscripto ?>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:py="http://purl.org/kid/ns#"
    py:extends="'../../../../../templates/master.kid'">
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" py:replace="''"/>
<title>list</title>
</head>
<body>

<h1>Entregas Realizadas</h1>
<h2>Enunciado: <span py:replace="ejercicio.enunciado">Nombre Enunciado</span> (instancia: <span py:replace="instancia.numero">Nombre Enunciado</span>)</h2>

<table class="list">
    <tr>
				<th>Entregador</th>
        <th>Correcta</th>
        <th>InicioTareas</th>
        <th>FinTareas</th>
        <th>Observaciones</th>
				<th>Operaciones</th>
    </tr>
		<tr py:for="record in records">
				<?python
					def contar_comandos_mal(prueba, publico):
						total = 0
						tested = 0
						for c in prueba.comandos_ejecutados:
							if c.comando.publico == publico:
								if not c.exito:
									total += 1
								tested += 1
						return (total, tested)

					# Reviso que tan mal esta
					# si no hay pruebas, esta mal porque no anduvieron los comandos
					pruebas_pub_mal = 0
					pruebas_priv_mal = 0
					if len(record.pruebas) == 0:
						color = "#ff0000"
					else:
						# Veo que onda con las pruebas
						pri_mal = 0
						pub_mal = 0
						for prueba in record.pruebas:
							(rpub_mal, pub_tested) = contar_comandos_mal(prueba, True)
							(rpri_mal, pri_tested) = contar_comandos_mal(prueba, False)
							pri_mal += rpri_mal
							pub_mal += rpub_mal
						if pri_mal + pub_mal == 0:
							color = "#00ff00"
						else:
							if pub_mal > 0:
								color = "#ff0000"
							else:
								color = "#ffff00"
				?>
	<td style="background:${color};">
	    <a href="${tg.url('/alumno/show/%d' % record.entregador.alumno.id)}"><span py:if="record.entregador" py:replace="record.entregador"></span></a>
        </td>
        <td style="background:${color};"><span py:replace="record.exito">fecha asignado</span></td>
        <td style="background:${color};"><span py:replace="record.inicio">fecha corregido</span></td>
        <td style="background:${color};"><span py:replace="record.fin">fecha corregido</span></td>
        <td style="background:${color};"><span py:replace="record.observaciones">nota</span></td>
				<td>
					<a href="${tg.url('/mis_entregas/corrida/%d' % record.id)}">Corrida</a>
					<a href="${tg.url('/mis_entregas/get_archivo/%d' % record.id)}">Bajar Archivo</a>
				</td>
    </tr>
</table>

<br/>

<div>
<a href="javascript:window.history.go(-1);">Volver</a>
<span py:for="page in tg.paginate.pages">
    <a py:if="page != tg.paginate.current_page"
        href="${tg.paginate.get_href(page)}">${page}</a>
    <b py:if="page == tg.paginate.current_page">${page}</b>
</span>
</div>

</body>
</html>

<!-- vim: set et sw=4 sts=4 : -->
