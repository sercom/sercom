<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<?python import sitetemplate
 from sercom.menu import Menu
 from datetime import datetime
 from sercom.controllers import Root
 from sercom.presentation.utils.sessionhelper import SessionHelper
 from sercom.domain.exceptions import SinCursosDisponibles
 menu = Menu(Root)
 try:
   curso = SessionHelper().get_contexto_usuario().get_curso()
 except SinCursosDisponibles:
   curso = None
?>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:py="http://purl.org/kid/ns#" py:extends="sitetemplate">

<head py:match="item.tag=='{http://www.w3.org/1999/xhtml}head'" py:attrs="item.items()">
    <meta content="text/html; charset=UTF-8" http-equiv="content-type" py:replace="''"/>
    <title py:replace="''">Sercom</title>
    <meta py:replace="item[:]"/>
    <style type="text/css" media="screen">
    @import "/static/css/style.css";
    </style>
    <style type="text/css">
     #pageLogin td{ background-color:white; }
     #pageLogin {
       font-size: 10px;
       font-family: verdana;
     }
     #pageLogin .contexto { text-align: left; }
     #pageLogin .credenciales { text-align: right; }
    </style>

</head>

<body py:match="item.tag=='{http://www.w3.org/1999/xhtml}body'" py:attrs="item.items()">
		<div id="header"><span style="position:relative; top: 100%;"></span></div>
    <div id="main_content">
    <div py:if="tg.config('identity.on',False) and not 'logging_in' in locals()" id="pageLogin">
        <table style="width:100%">
            <tr>
                <td class="contexto" py:if="curso and not tg.identity.anonymous">
                  Curso:&nbsp;
                  <a href="/seleccion_curso"><span py:replace="curso">curso</span></a>&nbsp;&nbsp;
                  <a py:if="'JTP' in tg.identity.groups" href="${tg.url('/curso/docente/list/%d' % curso.id)}">Docentes</a>
                  <a py:if="'JTP' in tg.identity.groups" href="${tg.url('/curso/alumno/list/%d' % curso.id)}">Alumnos</a>
                  <a py:if="'JTP' in tg.identity.groups" href="${tg.url('/curso/grupo/list/%d' % curso.id)}">Grupos</a>
                  <a py:if="'JTP' in tg.identity.groups" href="${tg.url('/curso/ejercicio/list/%d' % curso.id)}">Ejercicios</a>
                  <a py:if="'JTP' in tg.identity.groups" href="${tg.url('/curso/instancia_evaluacion_alumno/list/%d' % curso.id)}">Evaluación Alumnos</a>
                  <a py:if="'JTP' in tg.identity.groups" href="${tg.url('/curso/notas/%d' % curso.id)}">Notas</a>
		<br/>
                  <span py:for="i in [x for x in curso.instancias_de_entrega if x.activo and datetime.now()>=x.inicio]" py:if="'docente' in tg.identity.groups">
                  <a href="${tg.url('/correccion/resumen_entregas?instanciaID=%d' % i.id)}">${str(i.ejercicio.numero)+'.'+str(i.numero)}</a>
                  </span>
                </td>
                <td class="credenciales">
                  <span py:if="tg.identity.anonymous"><a href="/login">Login</a></span>
                  <span style="text-align: right;" py:if="not tg.identity.anonymous">
                    Bienvenido  <a href="/user_panel/${tg.identity.user.id}" title="Panel de control de usuario">${tg.identity.user.nombre}.</a>
                    <a py:if="'docente' in tg.identity.groups" href="${tg.url('/docente/edit/%d' % tg.identity.user.id)}">Editar</a>
                    <a href="/logout">Logout</a>
                  </span>
               </td>
           </tr>
        </table>
    </div>
    <div py:if="tg_flash" class="flash" py:content="tg_flash"></div>

    ${XML(str(menu))}
        
    <div py:replace="[item.text]+item[:]"/>

	<!-- End of main_content -->
	</div>
	<div id="footer">
		<a href="http://www.turbogears.org/"><img src="/static/images/under_the_hood_blue.png" alt="TurboGears under the hood" /></a>
		<br />
		<br />
  	<p>Sistema de seguimiento de cursada - Copyleft &copy; 2007 Dimov, Lucarella, Markiewicz</p>
	</div>
</body>

</html>
