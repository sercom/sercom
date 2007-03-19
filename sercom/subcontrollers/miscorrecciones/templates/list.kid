<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<?python from sercom.model import Grupo, AlumnoInscripto ?>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:py="http://purl.org/kid/ns#"
    py:extends="'../../../templates/master.kid'">
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" py:replace="''"/>
<title>list</title>
</head>
<body>

<h1>Mis <span py:replace="namepl.capitalize()">Objetos</span></h1>

<table class="list">
    <tr>
				<th>Entregador</th>
				<th>Ejercicio</th>
				<th><span title="Instancia de Entrega">IE</span></th>
        <th>Corrector</th>
        <th>Fecha</th>
        <th>Nota</th>
        <th>Observaciones</th>
    </tr>
    <tr py:for="record in records">
        <td><span py:if="record.entregador" py:replace="record.entregador.shortrepr()">usuario</span></td>
        <td><span py:replace="record.instancia.ejercicio.enunciado.nombre">usuario</span></td>
        <td><span py:replace="record.instancia.shortrepr()">usuario</span></td>
        <td><span py:if="record.corrector" py:replace="record.corrector.shortrepr()">fecha asignado</span></td>
        <td><span py:replace="record.corregido">fecha corregido</span></td>
        <td><span py:replace="record.nota">fecha corregido</span></td>
        <td><span py:replace="record.observaciones">nota</span></td>
    </tr>
</table>

<div py:for="page in tg.paginate.pages">
    <a py:if="page != tg.paginate.current_page"
        href="${tg.paginate.get_href(page)}">${page}</a>
    <b py:if="page == tg.paginate.current_page">${page}</b>
</div>

</body>
</html>

<!-- vim: set et sw=4 sts=4 : -->
