<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:py="http://purl.org/kid/ns#"
    py:extends="'../../../templates/master.kid'">
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" py:replace="''"/>
<title>edit</title>
</head>
<body>

<h1>Modificación de <span py:replace="name">Objeto</span></h1>

<div py:replace="form(value=record, action=tg.url('/tarea_prueba/update/%d' % record.id),
	submit_text=_(u'Guardar'))">Formulario</div>

<br/>
<a href="${tg.url('/tarea_prueba/show/%d' % record.id)}">Ver (cancela)</a> |
<a href="${tg.url('/tarea_prueba/list')}">Volver (cancela)</a>

</body>
</html>
