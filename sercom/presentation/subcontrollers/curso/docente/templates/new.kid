<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:py="http://purl.org/kid/ns#"
    py:extends="'../../../../templates/master.kid'">
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" py:replace="''"/>
<title>new</title>
</head>
<body>

<h1>Inscribir Docente en curso <span py:replace="curso">Curso</span></h1>

<p py:replace="form(action=tg.url('/curso/docente/create/'), value=values, submit_text=_('Crear'))">Formulario</p>

<br/>
<a href="${tg.url('/curso/docente/list/%d' % curso.id)}">Cancelar</a>

</body>
</html>
