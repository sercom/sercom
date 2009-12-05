<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<?python from sercom.model import Grupo, AlumnoInscripto ?>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:py="http://purl.org/kid/ns#"
    py:extends="'../../../templates/master.kid'">
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" py:replace="''"/>
<title>list</title>
 <script type="text/javascript">
     function cambiar(filename){
        cambiarArchivo(${entrega.id}, filename);
     }

    function mostrarArchivo(res) {
        var lbl = MochiKit.DOM.getElement('lblArchivo');
        lbl.value = res.file_text.toString();
    }

    function err (err)
    {
        alert("The metadata for MochiKit.Async could not be fetched :(" + err);
    }

    function cambiarArchivo(entrega_id, filename)
    {
        encodedFilename = filename.replace(/\./,"%2E").replace(/\//g,"%2F");
        url = "/entregas/get_archivo/" + entrega_id + "/" + encodedFilename;
        var d = loadJSONDoc(url);
        d.addCallbacks(mostrarArchivo, err);
    }


</script>
</head>

<body>
<h1>Archivos de Entrega</h1>
<h2><span py:replace="'%s - %s' % (entrega.instancia.numerorepr(), entrega.entregador.shortrepr())"/></h2>


<div style="display:block">
  <div style="width:25%;float:left;height:100%">
    <p>Archivos:</p>
    <div py:for="archivo in entrega.get_archivos_nombres()" py:if="archivo[-1]!='/'" >
      <a href="#" onclick="cambiar('${archivo}');return false;">${archivo}</a>
    </div>
  </div>
  <div style="width:100%;">
    <textarea rows="40" style="width:70%" id="lblArchivo" readonly="true"/>
  </div>
</div>

</body>
</html>

<!-- vim: set et sw=4 sts=4 : -->
