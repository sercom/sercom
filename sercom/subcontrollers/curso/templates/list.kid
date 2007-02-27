<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:py="http://purl.org/kid/ns#"
    py:extends="'../../../templates/master.kid'">
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" py:replace="''"/>
<title>list</title>
</head>
<body>

<h1>Administración de <span py:replace="namepl">Objetos</span></h1>

<table>
    <tr>
        <th>Anio</th>
        <th>Cuatrimestre</th>
        <th>Numero</th>
        <th>Descripcion</th>
        <th>Docentes</th>
        <th>Alumnos</th>
        <th>Grupos</th>
				<th>Ejercicios</th>
				<th>Operaciones</th>
    </tr>
    <tr py:for="record in records">
        <!--td><input type="checkbox" onclick="var f =
            document.createElement('form'); this.parentNode.appendChild(f);
            f.method = 'POST'; f.action = '${tg.url('/alumno/activate/%d/%d' % (record.id, int(not record.activo)))}';
            f.submit(); return false;"
            py:attrs="checked=tg.checker(record.activo)" /></td-->
        <td><a href="${tg.url('/curso/show/%d' % record.id)}"><span
                    py:replace="record.numero">numero</span></a></td>
        <td><span py:replace="record.cuatrimestre">cuatrimestre</span></td>
        <td><span py:replace="record.anio">anio</span></td>
        <td><span py:replace="record.descripcion">descripcion</span></td>
        <td><a py:if="len(record.docentes)" href="${tg.url('/docente/list')}"><span py:replace="len(record.docentes)">Docentes</span></a></td>
        <td><a py:if="len(record.alumnos)"  href="${tg.url('/alumno/list')}"><span py:replace="len(record.alumnos)">Alumnos</span></a></td>
        <td><a py:if="len(record.grupos)"  href="${tg.url('/grupo/list')}"><span py:replace="len(record.grupos)">Grupos</span></a></td>
        <td><a py:if="len(record.ejercicios)" href="${tg.url('/ejercicio/list')}"><span py:replace="len(record.ejercicios)">Ejercicio</span></a></td>
        <td><a href="${tg.url('/curso/edit/%d' % record.id)}">Editar</a>
            <a href="${tg.url('/curso/delete/%d' % record.id)}" onclick="if (confirm('${_(u'Estás seguro? Tal vez sólo quieras desactivarlo mejor...')}')) { var f = document.createElement('form'); this.parentNode.appendChild(f); f.method = 'POST'; f.action = this.href; f.submit(); };return false;">Eliminar</a></td>
    </tr>
</table>

<br/>
<a href="${tg.url('/curso/new')}">Agregar</a>

<div py:for="page in tg.paginate.pages">
    <a py:if="page != tg.paginate.current_page"
        href="${tg.paginate.get_href(page)}">${page}</a>
    <b py:if="page == tg.paginate.current_page">${page}</b>
</div>

</body>
</html>

<!-- vim: set et sw=4 sts=4 : -->
