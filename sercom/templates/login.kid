<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"
    xmlns:py="http://purl.org/kid/ns#">

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
            font-size: 10px;
            background-color: #eee;
            border: 2px solid #ccc;
        }

        #loginBox h1
        {
            font-size: 42px;
            font-family: "Trebuchet MS";
            margin: 0;
            color: #ddd;
        }

        #loginBox p
        {
            position: relative;
            top: -1.5em;
            padding-left: 4em;
            font-size: 12px;
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

    </style>
</head>

<body>
    <div id="loginBox">
        <h1>Identificación</h1>
        <p py:content="message">Mensaje de error</p>
	<p py:content="login_form(value=form_data)">Formulario de login</p>
    </div>
</body>
</html>
