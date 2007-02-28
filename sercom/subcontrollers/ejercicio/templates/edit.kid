<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:py="http://purl.org/kid/ns#"
    py:extends="'../../../templates/master.kid'">
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" py:replace="''"/>
<title>edit</title>
</head>
<script type="text/javascript">
	function select_enunciado() {
		lista = MochiKit.DOM.getElement('enunciadoID');
		for(i=0; i &lt; l.options.length; i++) {
			if (l.options[i].value == ${record.enunciado.id}) {
				l.options[i].selected = true;
				l.selectedIndex = i;
				break;
			}
		}
	}
</script>
<body>

<h1>Modificación de <span py:replace="name">Objeto</span></h1>

<div id="hint">
	Buscando registros ...
</div>

<div py:replace="form(value=record, action=tg.url('/ejercicio/update/%d' % record.id),
	submit_text=_(u'Guardar'))">Formulario</div>

<br/>
<a href="${tg.url('/ejercicio/show/%d' % record.id)}">Ver (cancela)</a> |
<a href="${tg.url('/ejercicio/list')}">Volver (cancela)</a>
</body>
</html>
