<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<?python from sercom.model import Grupo, AlumnoInscripto ?>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:py="http://purl.org/kid/ns#"
    py:extends="'../../../../../templates/master.kid'">
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" py:replace="''"/>
<title>list</title>
</head>
<body>

<h1>Entregas para la Instancia de Entrega <span py:replace="instancia.shortrepr()">Objetos</span></h1>

<table class="list">
    <tr>
				<th>Entregador</th>
        <th>Correcta</th>
        <th>InicioTareas</th>
        <th>FinTareas</th>
        <th>Observaciones</th>
				<th>Operaciones</th>
    </tr>
		<tr py:for="record in instancia.entregas">
				<?python
					def contar_comandos_mal(prueba, publico):
						total = 0
						for c in prueba.comandos_ejecutados:
							if not c.exito and c.publico == publico:
								total += 1
						return total

					if not record.exito:
						# Reviso que tan mal esta
						# si no hay pruebas, esta mal porque no anduvieron los comandos
						if len(record.pruebas) == 0:
							color = "entregamal"
						else:
							# Veo que onda con las pruebas
							pruebas_pub_mal = 0
							pruebas_priv_mal = 0
							for prueba in record.pruebas:
								if contar_comandos_mal(prueba, True) > 0:
									pruebas_pub_mal += 1
								if contar_comandos_mal(prueba, False) > 0:
									pruebas_priv_mal += 1
							if pruebas_pub_mal > 0:
								color = "entregamal"
							if pruebas_priv_mal > 0:
								color = "entregamal"
					else:
						# Todo Ok! 
						color = "entregaok"
				?>
				<td class="${color}"><span py:if="record.entregador" py:replace="record.entregador.shortrepr()">usuario</span></td>
        <td class="${color}"><span py:replace="record.exito">fecha asignado</span></td>
        <td class="${color}"><span py:replace="record.inicio">fecha corregido</span></td>
        <td class="${color}"><span py:replace="record.fin">fecha corregido</span></td>
        <td class="${color}"><span py:replace="record.observaciones">nota</span></td>
				<td>
					<a href="${tg.url('/mis_entregas/corrida/%d' % record.id)}">Corrida</a>
					<a href="${tg.url('/mis_entregas/get_archivo/%d' % record.id)}">Bajar Archivo</a>
				</td>
    </tr>
</table>

<br/>
<a href="${tg.url('/curso/ejercicio/instancia/list/%s' % instancia.ejercicio.id)}">Volver</a>

</body>
</html>

<!-- vim: set et sw=4 sts=4 : -->
