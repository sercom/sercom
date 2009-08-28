<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<?python from turbogears import identity ?>
<?python from sercom.model import TareaPrueba, TareaFuente ?>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:py="http://purl.org/kid/ns#"
    py:extends="'../../../templates/master.kid'">
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" py:replace="''"/>
<title>show</title>
</head>
<body>

<table>
    <tr>
        <th>Año-Cuatrimestre:</th>
        <td><span py:replace="str(record.anio)+'-'+str(record.cuatrimestre)">nombre</span></td>
    </tr>
    <tr>
        <th>Nombre:</th>
        <td><span py:replace="record.nombre">nombre</span></td>
    </tr>
    <tr>
        <th>Descripción:</th>
				<td><span py:replace="record.descripcion">descripcion</span></td>
    </tr>
    <tr py:if="'admin' in tg.identity.groups or 'JTP' in tg.identity.groups or 'redactor' in tg.identity.groups">
        <th>Autor:</th>
				<td>
					<a py:if="record.autorID is not None" href="${tg.url('/docente/show/%d' % record.autor.id)}"><span py:replace="record.autor">autor</span></a></td>
    </tr>
    <tr py:if="'admin' in tg.identity.groups or 'JTP' in tg.identity.groups or 'redactor' in tg.identity.groups">
        <th>Creado el:</th>
				<td><span py:replace="record.creado">descripcion</span></td>
    </tr>
    <tr>
        <th>Archivos:</th>
				<td>
           <a py:if="record.archivos" href="${tg.url('/enunciado/files/%d' % record.id)}">Bajar Enunciado</a>
				</td>
    </tr>
    <tr>
        <th>Tareas:</th>
				<td>
					<ul>
						<li py:for="t in record.tareas">
							<a py:if="isinstance(t, TareaFuente)" href="${tg.url('/tarea_fuente/show/%d' % t.id)}" py:content="t"></a>
							<a py:if="isinstance(t, TareaPrueba)" href="${tg.url('/tarea_prueba/show/%d' % t.id)}" py:content="t"></a>
						</li>
					</ul>
				</td>
    </tr>
    <tr>
        <th>Casos de Prueba:</th>
				<td>
					<ul>
					<table border="0" style="width:100%">
						<tr py:for="t in record.casos_de_prueba" py:if="t.activo and (t.publico or 'admin' in tg.identity.groups or 'JTP' in tg.identity.groups or 'redactor' in tg.identity.groups)" >
							<td style="width:50%"><li py:content="t.nombre" /></td>
							<td><a py:if="t.archivos_entrada" href="${tg.url('/enunciado/caso_de_prueba/file/archivos_entrada/%d' % t.id)}">Bajar Entradas</a></td>
							<td><a py:if="t.archivos_a_comparar" href="${tg.url('/enunciado/caso_de_prueba/file/archivos_a_comparar/%d' % t.id)}">Bajar Salidas</a></td>
						</tr>
					</table>
					</ul>
				</td>
    </tr>
    <tr py:if="'admin' in tg.identity.groups or 'JTP' in tg.identity.groups or 'redactor' in tg.identity.groups">
				<th>Ejercicios en los<br /> que es Usado:</th>
				<td>
					<ul>
						<li py:for="t in record.ejercicios" py:content="t" />
					</ul>
				</td>
    </tr>
</table>

<br/>
<a py:if="'admin' in tg.identity.groups or 'JTP' in tg.identity.groups or 'redactor' in tg.identity.groups" href="${tg.url('/enunciado/edit/%d' % record.id)}">Editar</a> |
<a href="javascript:window.history.go(-1);">Volver</a>

</body>
</html>
