<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<?python from turbogears import identity ?>

<html xmlns="http://www.w3.org/1999/xhtml" xmlns:py="http://purl.org/kid/ns#"
	py:extends="'master.kid'">
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<title>Dashboard - SERCOM</title>
</head>
<body>
	<div py:if="'admin' in identity.current.permissions">
		<h1>Dashboard</h1>
		<h2>Correcciones</h2>
		<div>
			<span py:if="record['entregas_para_corregir'] != 0">
				En este momento tenes <a href="${tg.url('/correccion/')}">${record['entregas_para_corregir']}</a> entregas para corregir.
			</span>	
			<span py:if="record['entregas_para_corregir'] == 0">
				No hay entregas que corregir.
			</span>	
		</div>
		<h2>Instancias de Entrega</h2>
		<div>
			<span py:if="record['proxima_entrega'] is not None">La proxima Entrega vence el ${record['proxima_entrega']}.</span>
			<span py:if="record['proxima_entrega'] is None">En este momento no hay ninguna Entrega en curso.</span>
		</div>
	</div>


	<div py:if="'entregar' in identity.current.permissions and 'admin' not in identity.current.permissions">
		<h1>Soy entregar</h1>
	</div>
</body>
</html>
