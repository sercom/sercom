<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:py="http://purl.org/kid/ns#"
    py:extends="'../../../templates/master.kid'">
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" py:replace="''"/>
<title>new</title>
</head>
<body>

<h1>Agregar desde Archivo - Resultados</h1>

<h2>Se agregagon con éxito los siguientes alumnos</h2>
    <ul>
        <li py:for="i in ok">${i[1]}</li>
</ul>

<h2>No se pudieron agregar los siguientes alumnos</h2>
    <ul>
        <li py:for="i in fail">${i[1]} - ${i[4]}</li>
</ul>
<br/>
<a href="${tg.url('/curso/list')}">Volver</a>

</body>
</html>
