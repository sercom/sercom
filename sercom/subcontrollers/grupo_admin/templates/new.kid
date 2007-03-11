<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:py="http://purl.org/kid/ns#"
    py:extends="'../../../templates/master.kid'">
<head>

<meta content="text/html; charset=utf-8" http-equiv="Content-Type" py:replace="''"/>
<title>new</title>
</head>
<body>

<h1>Administrar <span py:replace="namepl">Objeto</span></h1>
<p py:replace="form(action=tg.url('/grupo_admin/update/%d' % cursoId), value=values, submit_text=_('Actualizar'))">Formulario</p>

<br/>
<a href="${tg.url('/grupo/list')}">Cancelar</a>

<script language="javascript">
    initWidgets(true);
</script>

</body>
</html>
