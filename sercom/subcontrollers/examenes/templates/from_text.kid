<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:py="http://purl.org/kid/ns#"
    py:extends="'../../../templates/master.kid'">
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" py:replace="''"/>
<title>new</title>

</head>
<body>

<h1>Agregar desde Archivo</h1>

<div class="help">
Desde acá podrá hacer una importación masiva de una lista de ejercicios de un examen dado.
<br /><br />
Se espera que el formato respete la siguiente estructura :
<blockquote>
	1)textoplano<br/>
	2)textoplano<br/>
	...
</blockquote>
</div>

<br />

<form action="${tg.url('/examenes/from_text_add')}" method="post">
	<textarea name="final" style="width:90%;height:400px"/><br /><br />
	<input type="submit" value="Enviar" />
</form>

<br/>
<a href="${tg.url('/examenes/list')}">Cancelar</a>

</body>
</html>
