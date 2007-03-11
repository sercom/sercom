<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<?python from sercom.model import Grupo, AlumnoInscripto ?>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:py="http://purl.org/kid/ns#"
    py:extends="'../../../templates/master.kid'">
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" py:replace="''"/>
<title>corrida</title>
</head>
<body>

<h1>Corrida</h1>

<h2>Comandos Ejecutados</h2>
<ul>
    <li py:for="comando in entrega.comandos_ejecutados">
    ${comando.shortrepr()}
    </li>
</ul>
<h2>Pruebas Realizadas</h2>
<ul>
    <li py:for="prueba in entrega.pruebas">
    ${prueba.shortrepr()}
    </li>
</ul>

<a href="${tg.url('/mis_entregas/list')}">Volver</a>

</body>
</html>

<!-- vim: set et sw=4 sts=4 : -->
