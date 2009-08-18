<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:py="http://purl.org/kid/ns#"
    py:extends="'../../../templates/master.kid'">
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" py:replace="''"/>
<title>new</title>
</head>
<body>

<h1>Agregar alumnos desde Archivo</h1>

<div class="help">
Desde acá podrá hacer una importación masiva de una lista de alumnos desde un archivo en formato
CSV (texto separado por comas).
<br /><br />
Se espera que el archivo tenga las siguientes columnas :
<blockquote>
    padron, nombre, email, telefono
</blockquote>
Para cada Alumno, se le creará un usuario donde su nombre del login y la clave es el número de padrón,
y será inscripto en el curso.
</div>

<br />

<form action="${tg.url('/curso/from_file_add/%d' %  cursoID)}" method="post" ENCTYPE="multipart/form-data">
    <input type="file" name="archivo" /><br />
    <input type="submit" value="Enviar" />
</form>

<br/>
<a href="${tg.url('/curso/list')}">Cancelar</a>

</body>
</html>
