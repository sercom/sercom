<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:py="http://purl.org/kid/ns#"
    py:extends="'../../../../templates/master.kid'">
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" py:replace="''"/>
<title>edit</title>
</head>
<script type="text/javascript">
	function init_data() {
		MochiKit.DOM.getElement('form_responsable').focus();
		MochiKit.DOM.getElement('form_nombre').focus();
		<span py:for="i in record.miembros" py:strip="True">
			MochiKit.DOM.appendChildNodes("form_miembros", OPTION({"value":${i['id']}}, '${i['label']}'))
		</span>
	}
	MochiKit.DOM.addLoadEvent(init_data);
</script>

<body>
<h1>Modificación de <span py:replace="name">Objeto</span></h1>

<div py:replace="form(value=record, action=tg.url('/curso/grupo/update/%d' % record.id),
	options=options, submit_text=_(u'Guardar'))">Formulario</div>

<br/>
<a href="${tg.url('/curso/grupo/list/%d' % record.cursoID)}">Volver (cancela)</a>

</body>
</html>
