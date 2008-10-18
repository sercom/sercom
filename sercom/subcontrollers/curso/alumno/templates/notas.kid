<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:py="http://purl.org/kid/ns#"
    py:extends="'../../../../templates/master.kid'">
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" py:replace="''"/>
<title>notas</title>
</head>
<body>
<h1>Notas de <span py:replace="record.alumno">Objeto</span></h1>

<div py:replace="form(value=record, action=tg.url('/curso/alumno/update/%d/%d' % (record.id, cursoid)),
	submit_text=_(u'Guardar'))">Formulario</div>

<br/>
<a href="${tg.url('/curso/alumno/list/%d' % cursoid)}">Volver (cancela)</a>

</body>
</html>
