
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<?python from sercom.model import Grupo, AlumnoInscripto, DTOResumenAlumnoEntrega ?>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:py="http://purl.org/kid/ns#"
    py:extends="'../../../templates/master.kid'">
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" py:replace="''"/>
<title>list</title>
</head>
<body>

<h1>Resumen de Entregas de Alumnos</h1>

<div py:replace="form(value=vfilter, options=options, action=tg.url('/correccion/resumen_alumnos'), submit_text=_(u'Filtrar'))">Filtros</div>

<table class="list">
    <tr>
        <th>Alumno</th>
        <th>Entregas Exitosas</th>
        <th>Entregas Fallidas</th>
        <th>Corrector</th>
        <th>Operaciones</th>
    </tr>
    <tr py:for="record in records">
        <td><span py:replace="record.alumno">alumno</span></td>
        <td><span py:replace="record.entregas_exitosas == 0 and '-' or str(record.entregas_exitosas)">entregas exitosas</span></td>
        <td><span py:replace="record.entregas_fallidas == 0 and '-' or str(record.entregas_fallidas)">entregas fallidas</span></td>
        <td><span py:if="record.correccion" py:replace="record.correccion.corrector">corrector</span></td>
        <td>
            <a py:if="record.editar_correccion" href="${tg.url('/corregir/edit', correccionID=record.correccion.id)}">Corregir</a>
            <a py:if="record.agregar_correccion" href="${tg.url('/corregir/new', instanciaID = instanciaID, padron = record.alumno.padron)}">Corregir</a>
       </td>
    </tr>
</table>

<div py:for="page in tg.paginate.pages" py:strip="True">
    <a py:if="page != tg.paginate.current_page"
        href="${tg.paginate.get_href(page)}">${page}</a>
    <b py:if="page == tg.paginate.current_page">${page}</b>
</div>

</body>
</html>

<!-- vim: set et sw=4 sts=4 : -->
