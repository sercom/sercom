<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<?python import sitetemplate ?>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:py="http://purl.org/kid/ns#" py:extends="sitetemplate">

<head>
    <meta content="text/html; charset=UTF-8"
        http-equiv="content-type" py:replace="''"/>
    <title>Login</title>
    <style type="text/css">
        #loginBox
        {
            width: 30%;
            margin: auto;
            margin-top: 10%;
            padding-left: 10%;
            padding-right: 10%;
            padding-top: 5%;
            padding-bottom: 5%;
            font-family: verdana;
            font-size: 9pt;
            background-color: #eee;
            border: 2px solid #ccc;
        }

        #loginBox h1
        {
            font-size: 28pt;
            font-family: "Trebuchet MS";
            margin: 0;
            color: #ddd;
        }

        #loginBox p
        {
            position: relative;
            top: -1.5em;
            padding-left: 4em;
            font-size: 10pt;
            margin: 0;
            color: #666;
        }

        #loginBox table
        {
            table-layout: fixed;
            border-spacing: 0;
            width: 100%;
        }

        #loginBox td.label
        {
            width: 33%;
            text-align: right;
        }

        #loginBox td.field
        {
            width: 66%;
        }

        #loginBox td.field input
        {
            width: 100%;
        }

        #loginBox td.buttons
        {
            text-align: right;
        }

        #register
        {
            font-family: verdana;
            font-size: 9pt;
            text-align: center;
            margin-top: 1em;
        }

        #register a.link, a, a.active {
            color: #369;
        }

        .flash
        {
            padding-left: 4em;
            font-size: 10pt;
            margin: 0;
            color: #666;
            margin: 0.5em;
            color: #393;
        }

    </style>
</head>

<body>
    <div id="loginBox">
        <h1>Identificación</h1>
        <p py:content="message">Mensaje</p>
        <p py:content="login_form(value=form_data)">Formulario de login</p>
        <div py:if="tg_flash" class="flash" py:content="tg_flash"></div>
        <a href="${tg.url('/recover')}">Recuperar contraseña</a>
        &nbsp;&nbsp;
        <div id="register" py:if="tg.config('inscripcion_abierta')">
            <a href="${tg.url('/register')}">Inscripción</a>
            &nbsp;&nbsp;
            <a href="${tg.url('/upgrade_registration')}">Inscripción recursantes</a>
        </div>
    </div>
</body>
</html>
