<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<?python from sercom.model import Grupo, AlumnoInscripto ?>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:py="http://purl.org/kid/ns#"
    py:extends="'../../../../templates/master.kid'">
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" py:replace="''"/>
<title>list</title>
</head>
<body>
   
    <h1>Alumnos del curso <span py:replace="curso"></span></h1>

<table class="list">
    <tr>
        <th>Alumno</th>
        <th>Condicional?</th>
        <th>Tutor</th>
        <th>Operaciones</th>
    </tr>
    <tr py:for="record in records">
        <td><a href="${tg.url('/curso/alumno/show/%d' % record.id)}" py:content="record.alumno">alumno</a></td>
        <td align="center"><span py:replace="tg.strbool(record.condicional)">fecha corregido</span></td>
        <td><a py:if="record.tutor" href="${tg.url('/docente/show/%d' % record.tutor.id)}" py:content="record.tutor">Tutor</a></td>
        <td>
            <a href="${tg.url('/curso/alumno/notas/%d/%d' % (record.id, curso.id))}">Notas</a>
        </td>
    </tr>
</table>

<br />
<a href="${tg.url('/curso/list')}">Volver</a>
<br /><br />

<div py:for="page in tg.paginate.pages">
    <a py:if="page != tg.paginate.current_page"
        href="${tg.paginate.get_href(page)}">${page}</a>
    <b py:if="page == tg.paginate.current_page">${page}</b>
</div>

</body>
</html>

<!-- vim: set et sw=4 sts=4 : -->
