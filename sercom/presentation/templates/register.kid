<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:py="http://purl.org/kid/ns#"
    py:extends="'master.kid'">
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" py:replace="''"/>
<title>Registrarse</title>
</head>
<body>

<h1>Inscribirse</h1>

<div py:replace="form(value=form_data, action=tg.url('/save_registration'),
	submit_text=_(u'Inscribirse'))">Formulario</div>

<br/>

</body>
</html>
