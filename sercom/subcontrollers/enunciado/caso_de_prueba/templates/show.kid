<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:py="http://purl.org/kid/ns#"
    py:extends="'../../../../templates/master.kid'">
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" py:replace="''"/>
<title>show</title>
</head>
<body>

<table class="show">
    <tr>
        <th>Nombre:</th>
        <td><span py:replace="record.nombre">nombre</span></td>
    </tr>
    <tr>
        <th>Enunciado:</th>
	<td><a py:if="record.enunciadoID is not None"
			href="${tg.url('/enunciado/show/%d' % record.enunciado.id)}"><span
				py:replace="record.enunciado.shortrepr()">enunciado</span></a></td>
    </tr>
    <tr>
        <th>Parámetros:</th>
	<td>
            <span py:if="record.comando" py:replace="record.comando">comando --con-parámetros</span>:
	</td>
    </tr>
    <tr>
        <th>Código de retorno:</th>
				<td><span py:replace="record.retorno">retorno</span></td>
    </tr>
    <tr>
        <th>Máximo tiempo de CPU [s]:</th>
				<td><span py:replace="record.max_tiempo_cpu">max_tiempo_cpu</span></td>
    </tr>
    <tr>
        <th>Máximo Memoria [Mb]:</th>
				<td><span py:replace="record.max_memoria">max_tiempo_cpu</span></td>
    </tr>
    <tr>
        <th>Máximo Tam. Archivo [Mb]:</th>
				<td><span py:replace="record.max_tam_archivo">max_tiempo_cpu</span></td>
    </tr>
    <tr>
        <th>Máximo Cant. Archivo:</th>
				<td><span py:replace="record.max_cant_archivos">max_tiempo_cpu</span></td>
    </tr>
    <tr>
        <th>Máximo Cant. Procesos:</th>
				<td><span py:replace="record.max_cant_procesos">max_tiempo_cpu</span></td>
    </tr>
    <tr>
        <th>Máximo Locks Memoria:</th>
				<td><span py:replace="record.max_locks_memoria">max_tiempo_cpu</span></td>
    </tr>
    <tr>
        <th>Terminar si falla?:</th>
				<td><span py:replace="tg.strbool(record.terminar_si_falla)">max_tiempo_cpu</span></td>
    </tr>
    <tr>
        <th>Rechazar si falla?:</th>
				<td><span py:replace="tg.strbool(record.rechazar_si_falla)">max_tiempo_cpu</span></td>
    </tr>
    <tr>
        <th>Publico?:</th>
				<td><span py:replace="tg.strbool(record.publico)">max_tiempo_cpu</span></td>
    </tr>
    <tr>
        <th>Archivos de Entrada:</th>
				<td><a py:if="record.archivos_entrada" href="${tg.url('/enunciado/caso_de_prueba/file/%d/archivos_entrada' % record.id)}">Bajar</a></td>
    </tr>
    <tr>
        <th>Archivos a Comparar:</th>
				<td><a py:if="record.archivos_a_comparar" href="${tg.url('/enunciado/caso_de_prueba/file/%d/archivos_a_comparar' % record.id)}">Bajar</a></td>
    </tr>
    <tr>
        <th>Archivos a guardar:</th>
				<td><span py:repalce="', '.join(record.archivos_a_guardar)"></span></td>
    </tr>
    <tr>
        <th>Activo?:</th>
				<td><span py:repalce="tg.strbool(record.activo)"></span></td>
    </tr>
</table>

<br/>
<a href="${tg.url('/enunciado/caso_de_prueba/edit/%d' % record.id)}">Editar</a> |
<a href="${tg.url('/enunciado/caso_de_prueba/list/%d' % record.enunciado.id)}">Volver</a>

</body>
</html>
