<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:py="http://purl.org/kid/ns#"
    py:extends="'../../../templates/master.kid'">
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" py:replace="''"/>
<title>new</title>
</head>
<body>

<a href="${tg.url('/entregas/statistics')}">Estadisticas</a>
| Forzar Entrega

<h1>Forzar nueva <span py:replace="name">Objeto</span></h1>

<p>Si aún no lo hizo le recomendamos leer detenidamente la <a href="http://7542.fi.uba.ar/administracion/entrega/">guía de entrega de trabajos</a> de la cátedra.</p>
<p py:replace="form(action=tg.url('/entregas/force_create'), options=options, value=values, submit_text=_('¡Entregar!'))">Formulario</p>
<p>Acerca del archivo entregable:
  <ul>
    <li>El formato debe ser ZIP, sin excepción, e incluir solamente los elementos requeridos por la entrega.</li>
    <li>Debe incluir el código fuente (.C, .CPP, .H)</li>
    <ol>
        <li>Utilizando el caracter TAB o hasta cuatro espacios para el <a href="http://7542.fi.uba.ar/administracion/entrega/#CF" title="Sangría en el fuente que mejora la legibilidad.">sangrado</a> (indent).</li>
        <li>Usando el conjunto de caracteres <a href="http://es.wikipedia.org/wiki/UTF8" title="8-bit Unicode Transformation Format">UTF-8</a> (sobre todo si hay letars acentuadas).</li>
    </ol>
    <li>No debe incluir código objeto (.O, .OBJ, etc.) o archivos de formato binario salvo expresa indicación en el enunciado.</li>
    <li>No debe incluir Makefile, script de compilación o similar salvo indicación en el enunciado.</li>
    <li>No debe incluir estructura de carpetas. Los archivos fuente deben encontrarse en la raíz del comprimido.</li>
  </ul>
</p>
<br/><br/>
<a href="${tg.url('/entregas/list')}">Cancelar</a>

</body>
</html>
