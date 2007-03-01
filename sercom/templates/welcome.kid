<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<?python from turbogears import identity ?>

<html xmlns="http://www.w3.org/1999/xhtml" xmlns:py="http://purl.org/kid/ns#"
	py:extends="'master.kid'">
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<title>Welcome to TurboGears</title>
</head>
<body>
	<div py:if="'admin' in identity.current.permissions">
		<h1>Soy admin</h1>
	</div>


	<div py:if="'entregar' in identity.current.permissions and 'admin' not in identity.current.permissions">
		<h1>Soy entregar</h1>
	</div>
</body>
</html>
