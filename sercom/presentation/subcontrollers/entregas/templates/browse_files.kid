<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<?python from sercom.model import Grupo, AlumnoInscripto ?>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:py="http://purl.org/kid/ns#"
    py:extends="'../../../templates/master.kid'">
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" py:replace="''"/>
<title>list</title>
 <script type="text/javascript">
//<!--
     function cambiar(filename){
        cambiarArchivo(${entrega.id}, filename);
     }

     function ocultarArchivo(){
       var lbl = MochiKit.DOM.getElement('lblArchivo');
	lbl.style.display='none';
     }

    function mostrarArchivo(res) {
        var lbl = MochiKit.DOM.getElement('lblArchivo');
        lbl.innerHTML = res.file_html.toString();
	lbl.style.display='block';
    }

    function err (err)
    {
        alert("The metadata for MochiKit.Async could not be fetched :(" + err);
    }

    function cambiarArchivo(entrega_id, filename)
    {
        var encodedFilename = filename.replace(/\./,"%2E").replace(/\//g,"%2F");
        var url = '/entregas/get_fuente_c_formato?entrega_id=' + entrega_id + '&nombre=' + encodedFilename;
        var d = loadJSONDoc(url);
        d.addCallbacks(mostrarArchivo, err);
    }
//-->
</script>
<style type="text/css">
<!--
body.hl	{ background-color:#ffffff; }
pre.hl	{ color:#000000; background-color:#ffffff; font-family:Courier New;}
.num	{ color:#2928ff; }
.esc	{ color:#ff00ff; }
.str	{ color:#ff0000; }
.dstr	{ color:#818100; }
.slc	{ color:#838183; font-style:italic; }
.com	{ color:#838183; font-style:italic; }
.dir	{ color:#008200; }
.sym	{ color:#000000; }
.line	{ color:#555555; }
.kwa	{ color:#000000; font-weight:bold; }
.kwb	{ color:#830000; }
.kwc	{ color:#000000; font-weight:bold; }
.kwd	{ color:#010181; }
.marco  {
  background-color:white;
  height:100%; 
  vertical-align:top; 
  border:1pt dashed;
  overflow:auto;
}
.lista-archivos {
  font-size:8pt; 
  width:150px; overflow:auto; 
  padding:5px; margin:2px;
}
.contenido-archivo {
  font-size:8pt; 
  width:570px; 
  display:block;overflow:auto;
  padding:5px; margin:2px;
}
-->
</style>

</head>

<body>
<h1>Archivos de Entrega</h1>
<h2><span py:replace="'%s - %s' % (entrega.instancia.shortrepr(), entrega.entregador.shortrepr())"/></h2>

<table style="display:block;vertical-align:top;vertical-align:top;">
 <tr>
  <td class="marco"> 
    <div class="lista-archivos" > 
      Archivos:
      <div title="${archivo}" py:for="archivo in entrega.get_archivos_nombres()" py:if="archivo[-1]!='/'" >
        <a href="#" onclick="cambiar('${archivo}');return false;">${archivo}</a>
      </div>
    </div>
  </td>&nbsp;
  <td class="marco"> 
    <div class="contenido-archivo">
      <a onclick="ocultarArchivo()">Ocultar</a>
      <pre class="h1" id="lblArchivo" style="display:none"/>
    </div>
  </td>    
 </tr>
</table>

</body>
</html>

<!-- vim: set et sw=4 sts=4 : -->
