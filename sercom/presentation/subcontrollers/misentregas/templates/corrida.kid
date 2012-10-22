<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<?python import turbogears as tg ?>
<?python from sercom.model import Grupo, AlumnoInscripto ?>
<?python from turbogears import identity ?>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:py="http://purl.org/kid/ns#"
    py:extends="'../../../templates/master.kid'">
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" py:replace="''"/>
<title>corrida</title>
</head>
<body>

<h1><span py:content="entrega.entregador"/> - <span py:content="entrega.instancia"/></h1>
<div py:if="not entrega.concluida">
    <h3>La entrega aún no ha sido procesada. Aguarde unos instantes por favor.</h3>
    <script type="text/javascript">setTimeout('document.location.href=document.location.href',10000);</script>
</div>
<div py:if="entrega.concluida">
 <h2>Comandos Ejecutados</h2>
 <table width="100%">
    <tr>
        <th>#</th>
        <th>Tarea</th>
        <th>Comando</th>
        <th>Inicio</th>
        <th>Duración</th>
        <th>Exito?</th>
        <th>Observaciones</th>
        <th>Diferencias</th>
        <th>Archivos Guardados</th>
    </tr>
    <tr class="${ce.exito and 'pruebaok' or 'pruebafail'}" py:for="ce in entrega.comandos_ejecutados" py:if="ce.comando.publico or 'corregir' in identity.current.permissions">
        <td py:content="ce.comando.orden" />
        <td py:content="ce.comando.tarea" />
        <td py:content="ce.comando.comando" />
        <td py:content="ce.inicio" />
        <td py:content="ce.duracion" />
        <td py:content="tg.strbool(ce.exito)" align="center" />
        <td py:content="ce.observaciones" />
        <td align="center"><a href="${tg.url('/mis_entregas/diff/%d' % ce.id)}" py:if="ce.diferencias">Bajar</a></td>
        <td align="center"><a href="${tg.url('/mis_entregas/file/%d' % ce.id)}" py:if="ce.archivos">Bajar Todo</a>
                           <span py:for="nombre in ce.get_archivos_nombres()">&nbsp;<a href="${tg.url('/mis_entregas/file/%d/%s' % (ce.id,nombre))}" target="_blank" >${nombre}</a>
                           </span>
       </td>
    </tr>
 </table>
 <h2>Pruebas Realizadas</h2>
 <div py:for="p in entrega.get_pruebas_visibles(identity.current.user)" py:strip="True">
    <div style="background:#ddd; border-radius:5px; border:1px solid black; margin-bottom:10px;">
        <h3 style="padding-left:5px" py:content="p.caso_de_prueba.nombre + (p.caso_de_prueba.publico and ' ' or ' (privado)')" />
        <table class="${p.exito and 'pruebaok' or 'pruebafail'}" border="1" width="100%">
            <tr py:if="p.caso_de_prueba.descripcion">
                <td>Descripcion</td>
                <td colspan="3" py:content="p.caso_de_prueba.descripcion"></td>
            </tr>
            <tr>
                <td>Comando</td>
                <td colspan="3" py:content="p.caso_de_prueba.comando"></td>
            </tr>
            <tr>
                <td>Inicio / Fin</td>
                <td>${p.inicio}  /  ${p.fin}</td>
            </tr>
            <tr py:if="p.observaciones">
                <td>Observaciones</td>
                <td colspan="3" py:content="p.observaciones"></td>
            </tr>
        </table>
      <table border="1" class="prueba" width="100%">
        <tr>
            <th>#</th>
            <th>Tarea</th>
            <th>Descripción</th>
            <th>Duración</th>
            <th>Exito?</th>
            <th>Observaciones</th>
            <th>Diferencias</th>
            <th>Archivos Guardados</th>
        </tr>
        <tr py:for="ce in p.comandos_ejecutados" py:if="ce.comando.publico or 'corregir' in identity.current.permissions" class="${ce.exito and 'pruebaok' or 'pruebafail'}">
            <td py:content="ce.comando.orden" />
            <td py:content="ce.comando.tarea.nombre" />
            <td py:content="ce.comando.tarea.descripcion" />
            <td py:content="ce.duracion" />
            <td py:content="tg.strbool(ce.exito)" align="center" />
            <td py:content="ce.observaciones" />
            <td align="center">
                <a href="${tg.url('/mis_entregas/diff/%d' % ce.id)}" py:if="ce.diferencias">Bajar</a>
                <a href="${tg.url('/mis_entregas/verdiff/%d' % ce.id)}" py:if="ce.diferencias">Ver</a>
            </td>
            <td align="center">
                <a href="${tg.url('/mis_entregas/file/%d' % ce.id)}" py:if="ce.archivos">Bajar Todo</a>
                <span py:for="nombre in ce.get_archivos_nombres()">&nbsp;<a href="${tg.url('/mis_entregas/file/%d/%s' % (ce.id,nombre))}" target="_blank" >${nombre}</a>
                </span>
            </td>
        </tr>
  </table>
  </div>
 </div>
</div>

<a href="javascript:window.history.go(-1);">Volver</a>

</body>
</html>

<!-- vim: set et sw=4 sts=4 : -->
