<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:py="http://purl.org/kid/ns#"
    py:extends="'../../../../templates/master.kid'">
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" py:replace="''"/>
<title>new</title>
</head>
<body>

<h1>Crear Nuevo <span py:replace="name">Objeto</span></h1>

<p py:replace="form(action=tg.url('/examenes/tipo/create'), value=values, submit_text=_('Crear'))">Formulario</p>

<br/>
<a href="${tg.url('/examenes/tipo/list')}">Cancelar</a>

</body>
</html>
