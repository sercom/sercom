<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:py="http://purl.org/kid/ns#"
    py:extends="'master.kid'">
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" py:replace="''"/>
<title>edit</title>
</head>
<body>

<h1>Panel de control de usuario</h1>

<div py:replace="user_form(value=record, action=tg.url('/user_update/%d' % record.id),
	submit_text=_(u'Guardar'))">Formulario</div>

<br/>
<a href="${tg.url('/dashboard')}">Volver (cancela)</a>

</body>
</html>
