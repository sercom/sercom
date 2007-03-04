<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<?python from sercom.model import Grupo, AlumnoInscripto ?>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:py="http://purl.org/kid/ns#"
    py:extends="'../../../templates/master.kid'">
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" py:replace="''"/>
<title>list</title>
</head>
<body>

<h1>Administración de <span py:replace="namepl">Objetos</span></h1>

<div py:replace="form(value=vfilter, action=tg.url('/alumno_inscripto/list'),	submit_text=_(u'Filtrar'))">Filtros</div>

<table class="list">
    <tr>
				<th>Curso</th>
        <th>Alumno</th>
        <th>Condicional?</th>
        <th>Tutor</th>
				<th>Operaciones</th>
    </tr>
    <tr py:for="record in records">
				<td><a href="${tg.url('/curso/show/%d' % record.curso.id)}" py:content="record.curso.shortrepr()">curso</a></td>
        <td><a href="${tg.url('/alumno/show/%d' % record.alumno.id)}" py:content="record.alumno.shortrepr()">alumno</a></td>
        <td><span py:replace="record.condicional">fecha corregido</span></td>
        <td><a py:if="record.tutor" href="${tg.url('/docente/show/%d' % record.tutor.id)}" py:content="record.tutor.shortrepr()">Tutor</a></td>
				<td>
					<a href="${tg.url('/alumno_inscripto/show/%d' % record.id)}">Ver</a>
				</td>
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
