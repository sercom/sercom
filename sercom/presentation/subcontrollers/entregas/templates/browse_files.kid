<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<?python from sercom.model import Grupo, AlumnoInscripto ?>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:py="http://purl.org/kid/ns#"
    py:extends="'../../../templates/master.kid'">
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" py:replace="''"/>
<title>list</title>
 <script type="text/javascript">
//<!--
  function ToogleButtonWrapper(linkId, contentId, description){
    this.linkId = linkId;
    this.description = description;
    this.contentId = contentId;

    function aatoogle(){
      if (this.visible)
        this.hide();
      else
        this.show();  
    }
    this.hide = function(){
      var content = MochiKit.DOM.getElement(this.contentId);
      content.style.display='none';
      var link = MochiKit.DOM.getElement(this.linkId);
      link.innerHTML = 'Mostrar ' + this.description;
      this.toogle = this.show;
    }
    this.show = function(){
      var content = MochiKit.DOM.getElement(this.contentId);
      content.style.display='block';
      var link = MochiKit.DOM.getElement(this.linkId);
      link.innerHTML = 'Ocultar ' + this.description;
      this.toogle = this.hide;
    }
    this.toogle = this.hide;
    var lnk = MochiKit.DOM.getElement(this.linkId);
    lnk.wrapper = this;
    lnk.onclick = function(){this.wrapper.toogle();};
    this.show();
  }
  
  function cambiar(filename){
    cambiarArchivo(${entrega.id}, filename);
  }

  function mostrarArchivo(res) {
    var lbl = MochiKit.DOM.getElement('lblArchivo');
    lbl.innerHTML = res.file_html.toString();
    __wrapperArchivo.show();
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

  MochiKit.DOM.addLoadEvent(function(){
      __wrapperArchivo = new ToogleButtonWrapper('lnkArchivo', 'pnlArchivo', 'Archivo');
      __wrapperListaArchivos = new ToogleButtonWrapper('lnkListaArchivos', 'pnlListaArchivos', 'Lista');
     });
  var __wrapperArchivo = null;
  var __wrapperListaArchivos = null;
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
display:block;
  margin:1px;
  background-color:white;
  height:100%; 
  vertical-align:top; 
  border:1pt dashed;
  overflow:auto;
}
.lista-archivos {
  width:100%;
  padding:5px; margin:2px;
}
.contenido-archivo {
  width:100%
  padding:5px; margin:2px;
}
.tabla-navegacion{
  width:100%;
  background-color:white;
}
.tabla-navegacion tr td {
  background-color:white;
}
-->
</style>

</head>

<body>
<h1>Archivos de Entrega</h1>
<h2><span py:replace="'%s - %s' % (entrega.instancia.shortrepr(), entrega.entregador.shortrepr())"/></h2>

<table class="tabla-navegacion">
 <tr>
  <td>
    <a id="lnkListaArchivos"/>
  </td>
  <td style="text-align:right">
    <a id="lnkArchivo"/>
  </td>
 </tr>
 <tr>
  <td colspan="2">
  <div style="float:left;width:30%" id="pnlListaArchivos" class="marco"> 
    <div class="lista-archivos" > 
      <div title="${archivo}" py:for="archivo in entrega.get_archivos_nombres()" py:if="archivo[-1]!='/'" >
        -&nbsp;<a href="#" onclick="cambiar('${archivo}');return false;">${archivo}</a>
      </div>
    </div>
  </div>
  <div style="width=100%" id="pnlArchivo" class="marco"> 
    <div class="contenido-archivo">
      <pre class="h1" id="lblArchivo"/>
    </div>
  </div>
  </td>
 </tr>
</table>

</body>
</html>

<!-- vim: set et sw=4 sts=4 : -->
