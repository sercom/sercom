<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<?python import sitetemplate ?>
<?python from sercom.menu import menu ?>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:py="http://purl.org/kid/ns#" py:extends="sitetemplate">

<head py:match="item.tag=='{http://www.w3.org/1999/xhtml}head'" py:attrs="item.items()">
    <meta content="text/html; charset=UTF-8" http-equiv="content-type" py:replace="''"/>
    <title py:replace="''">Sercom</title>
    <meta py:replace="item[:]"/>
    <style type="text/css">
        #pageLogin
        {
            font-size: 10px;
            font-family: verdana;
            text-align: right;
        }
    </style>
    <style type="text/css" media="screen">
@import "/static/css/style.css";
</style>
</head>

<body py:match="item.tag=='{http://www.w3.org/1999/xhtml}body'" py:attrs="item.items()">
		<div id="header"><span style="position:relative; top: 90%;">Administrador y Corrector Automático de Trabajos Prácticos</span></div>
    <div id="main_content">
    <div py:if="tg.config('identity.on',False) and not 'logging_in' in locals()" id="pageLogin">
        <span py:if="tg.identity.anonymous">
            <a href="/login">Login</a>
        </span>
        <span py:if="not tg.identity.anonymous">
            Bienvenido ${tg.identity.user.nombre}.
            <a href="/logout">Logout</a>
        </span>
    </div>
    <div py:if="tg_flash" class="flash" py:content="tg_flash"></div>

		<div id="navbar">
			Ir a :
			<select OnChange="window.location=this.options[this.selectedIndex].value;">
				<option value="${tg.url('/')}">Inicio</option>
				<option py:for="i in menu" value="${tg.url(i['url'])}">
				${i['name']}
				</option>
			</select>
		</div>
    <div py:replace="[item.text]+item[:]"/>

	<!-- End of main_content -->
	</div>
	<div id="footer">
		<a href="http://www.turbogears.org/"><img src="/static/images/under_the_hood_blue.png" alt="TurboGears under the hood" /></a>
  	<p>Copyleft &copy; 2007 Dimov, Lucarella, Markiewicz</p>
		<br />
	</div>
</body>

</html>
