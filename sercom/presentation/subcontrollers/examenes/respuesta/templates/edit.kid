<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:py="http://purl.org/kid/ns#"
    py:extends="'../../../../templates/master.kid'">
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" py:replace="''"/>
<title>edit</title>
<script type="text/javascript" src="../../../../static/js/tiny_mce/tiny_mce.js" />
<script type="text/javascript" src="../../../../static/js/init_tiny_mce.js" />
</head>
<body>

<h1>Modificación de <span py:replace="name">Objeto</span></h1>

<div py:replace="form(attrs=attrs, value=record, action=tg.url('/examenes/respuesta/update/%d/%d' % (record.preguntaID,record.id)),
	submit_text=_(u'Guardar'))">Formulario</div>

<br/>
<a href="${tg.url('/examenes/respuesta/show/%d/%d' % (record.preguntaID,record.id))}">Ver (cancela)</a> |
<a href="${tg.url('/examenes/pregunta/show/%d' % record.preguntaID)}">Volver (cancela)</a>

</body>
</html>
