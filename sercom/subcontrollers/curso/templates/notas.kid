<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:py="http://purl.org/kid/ns#"
    py:extends="'../../../templates/master.kid'">
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" py:replace="''"/>
<title>list</title>
</head>
<body>

<h1>Notas del Curso : <span py:replace="curso.shortrepr()">Objetos</span></h1>

<table class="list">
    <tr>
        <th py:for="i in cols" py:content="i" />
    </tr>
    <tr py:for="j in range(len(rows))">
        <td py:for="i in cols" py:content="rows[j][i]" />
    </tr>
</table>

<br/>
<a href="${tg.url('/curso/list')}">Volver</a>

</body>
</html>

<!-- vim: set et sw=4 sts=4 : -->
