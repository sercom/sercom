<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<?python import sitetemplate ?>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:py="http://purl.org/kid/ns#" py:extends="sitetemplate">

<head>
    <meta content="text/html; charset=UTF-8"
        http-equiv="content-type" py:replace="''"/>
    <title>Sercom - Error</title>
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
    </style>
</head>

<body>
    <div id="loginBox">
        <h1>Error</h1>
        <p>Ha ocurrido un error durante la ejecución del sistema.</p>
        <br/>
        <p py:content="mensaje">Mensaje</p>
    </div>
</body>
</html>
