<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:py="http://purl.org/kid/ns#"
    py:extends="'../../../../templates/master.kid'">
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" py:replace="''"/>
<title>list</title>
</head>
<body>

<h1>Tareas de "<span py:replace="enunciado.nombre">Objetos</span>"</h1>

<table class="list">
    <tr>
        <th>Tarea</th>
    </tr>
    <tr py:for="tarea in enunciado.tareas">
        <td><span py:replace="tarea">tarea</span></td>
    </tr>
</table>

<br/>
<a href="${tg.url('/enunciado/tarea/new/%d' % enunciado.id)}">Agregar</a>
<a href="${tg.url('/enunciado/list')}">Volver</a>

</body>
</html>

<!-- vim: set et sw=4 sts=4 : -->
