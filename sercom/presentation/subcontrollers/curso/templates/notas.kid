<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:py="http://purl.org/kid/ns#"
    py:extends="'../../../templates/master.kid'">
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" py:replace="''"/>
<title>list</title>
</head>
<body>

<h1>Notas del Curso : <span py:replace="curso">Objetos</span></h1>

<div align="right" style="font-size:70%; margin-right:5%; margin-bottom: 5px;">
	<a href="${tg.url('/correccion/calculo_correcciones')}">Calculo de Correcciones</a>
	<a href="${tg.url('/curso/notascsv/%d' % curso.id)}" target="_blank">Exportar</a>
</div>
<table class="list">
    <tr>
        <th>Padrón</th>
        <th>Nombre</th>
        <th>Grupos</th>
        <th py:for="i in resumen.instancias_nota"><div>${i.shortrepr()}</div><a href="${tg.url('/correccion/calculo_correcciones/%d' % i.id)}">Calc.</a></th>
    </tr>
    <tr py:for="notas in resumen.notas_alumnos">
        <td py:content="notas.padron"/>
        <td py:content="notas.nombre"/>
        <td py:content="notas.grupos"/>
        <td py:for="i in resumen.instancias_nota" py:content="notas[i]" />
    </tr>
</table>

</body>
</html>

<!-- vim: set et sw=4 sts=4 : -->
