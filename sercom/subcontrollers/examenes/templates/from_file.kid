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
Desde acá podrá hacer una importación masiva de una lista de alumnos desde un archivo en formato
CSV (texto separado por comas).
<br /><br />
Se espera que el archivo tenga las siguientes columnas :
<blockquote>
	fecha(dd/mm/yyy),anio,cuatrimestre,oportunidad,numero_pregunta,texto_pregunta,tipo.tema
</blockquote>
Ejemplo:
<blockquote>
31/01/2008,2008,01,01,1,"texto Pregunta 1",Teorica,c++
31/01/2008,2008,01,01,2,"texto, Pregunta 2",Teorica,gtk
</blockquote>
Para cada Pregunta, se crearán tipos y temas y se crearán los que no sean encontrados.
</div>

<br />

<form action="${tg.url('/examenes/from_file_add')}" method="post" ENCTYPE="multipart/form-data">
	<input type="file" name="archivo" /><br />
	<input type="submit" value="Enviar" />
</form>

<br/>
<a href="${tg.url('/examenes/list')}">Cancelar</a>

</body>
</html>
