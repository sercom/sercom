<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<?python import sitetemplate
	from sercom.menu import Menu
	from sercom.controllers import Root
	from sercom.presentation.utils.sessionhelper import SessionHelper
	menu = Menu(Root)
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
		<div id="header"><span style="position:relative; top: 90%;">Sistema de Entrega Electrónica de Trabajos Prácticos</span></div>
    <div id="main_content">
    <div py:if="tg.config('identity.on',False) and not 'logging_in' in locals()" id="pageLogin">
        <table style="width:100%">
            <tr>
                <td class="contexto" py:if="not tg.identity.anonymous">
                  Curso:&nbsp;<span py:replace="SessionHelper().get_contexto_usuario().get_curso()">curso</span>&nbsp;&nbsp;
                  <a href="/seleccion_curso">Cambiar</a>
                </td>
                <td class="credenciales">
                  <span py:if="tg.identity.anonymous"><a href="/login">Login</a></span>
                  <span style="text-align: right;" py:if="not tg.identity.anonymous">
                    Bienvenido ${tg.identity.user.nombre}.
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
  	<p>Copyleft &copy; 2007 Dimov, Lucarella, Markiewicz</p>
	</div>
</body>

</html>
