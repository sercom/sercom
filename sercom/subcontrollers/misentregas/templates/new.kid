<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:py="http://purl.org/kid/ns#"
    py:extends="'../../../templates/master.kid'">
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" py:replace="''"/>
<title>new</title>
</head>
<script type="text/javascript">
	function init_data () {
		if (MochiKit.DOM.getElement('form_ejercicio').options.length == 1) {
			alert('No hay Ejercicios activos en este momento.\nNo es posible realizar una entrega.');
			window.history.go(-1);
		}
	}
	MochiKit.DOM.addLoadEvent(init_data);
</script>
<body>

<h1>Crear Nuevo <span py:replace="name">Objeto</span></h1>

<p py:replace="form(action=tg.url('/mis_entregas/create'), value=values, submit_text=_('Entregar!'))">Formulario</p>

<br/>
<a href="${tg.url('/mis_entregas/list')}">Cancelar</a>

</body>
</html>
