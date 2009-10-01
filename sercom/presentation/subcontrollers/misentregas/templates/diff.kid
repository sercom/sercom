<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<?python from sercom.model import Grupo, AlumnoInscripto ?>
<?python import os ?>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:py="http://purl.org/kid/ns#"
    py:extends="'../../../templates/master.kid'">
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" py:replace="''"/>
<LINK MEDIA="all" HREF="/tg_widgets/turbogears.widgets/sh/SyntaxHighlighter.css" TYPE="text/css" REL="stylesheet" />
<title>list</title>
</head>
<body>

<h1>Diferencias</h1>


<div py:for="info in zip.infolist()">
	<?python
	n, ext = os.path.splitext(info.filename)
	if ext != ".diff":
		continue
	?>
	<h3>${info.filename}</h3>
	<textarea name="code" class="${ext[1:]}:collapse">${zip.read(info.filename).decode('utf8','replace')}</textarea>
</div>

<br/>
<a href="javascript:window.history.go(-1)">Volver</a>

	<!-- Lo hago a mano para poder agregar un nuevo lenguaje. No se como hacerlo sino :S -->
  <SCRIPT SRC="/tg_widgets/turbogears.widgets/sh/shCore.js" TYPE="text/javascript"></SCRIPT>
	<SCRIPT SRC="/tg_widgets/turbogears.widgets/sh/shBrushPython.js" TYPE="text/javascript"></SCRIPT>
	<SCRIPT SRC="/tg_widgets/turbogears.widgets/sh/shBrushXml.js" TYPE="text/javascript"></SCRIPT>
	<script type="text/javascript">
		// <!-- Agrego soporte para DIFF que no tiene el widget -->
		dp.sh.Brushes.Diff = function()	{
			var keywords =	'@@'

			this.regexList = [
				{ regex: new RegExp('^-.*', 'gm'), css: 'rojo' },
				{ regex: new RegExp('^@@.*', 'gm'), css: 'chunk' },
				{ regex: new RegExp('^\\+.*', 'gm'), css: 'verde' }
				];

				this.CssClass = 'dp-diff';
		}
		dp.sh.Brushes.Diff.prototype	= new dp.sh.Highlighter();
		dp.sh.Brushes.Diff.Aliases = ['diff'];
	</script>
	<SCRIPT TYPE="text/javascript">dp.SyntaxHighlighter.HighlightAll('code');</SCRIPT>
</body>
</html>

<!-- vim: set et sw=4 sts=4 : -->
