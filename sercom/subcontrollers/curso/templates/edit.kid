<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:py="http://purl.org/kid/ns#"
    py:extends="'../../../templates/master.kid'">
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" py:replace="''"/>
<title>edit</title>
</head>
<script type="text/javascript">
    function init_data() {
 //       MochiKit.DOM.getElement('form_responsable').focus();
        MochiKit.DOM.getElement('form_anio').focus();
        <span py:for="d in record.docentes_curso" py:strip="True">
            MochiKit.DOM.appendChildNodes("form_docentes_curso", OPTION({"value":${d['id']}}, '${d['label']}'))
        </span>
        
        <span py:for="a in record.alumnos_inscriptos" py:strip="True">
            MochiKit.DOM.appendChildNodes("form_alumnos", OPTION({"value":${a['id']}}, '${a['label']}'))
        </span>
    }
    MochiKit.DOM.addLoadEvent(init_data)
    
    function makeOption(option) {
        return OPTION({"value": option.value}, option.text);
    }
                   
    function moveOption( fromSelect, toSelect) {
        // add 'selected' nodes toSelect
        appendChildNodes(toSelect,
        map( makeOption,ifilter(itemgetter('selected'), $(fromSelect).options)));
        // remove the 'selected' fromSelect
        // replaceChildNodes(fromSelect,
        // list(ifilterfalse(itemgetter('selected'), $(fromSelect).options)));
    }
    
    function mover( src, dest ) {
        moveOption(src, dest)    
    }
    
    function remover (src, dest) {
        replaceChildNodes(src,list(ifilterfalse(itemgetter('selected'), $(src).options)))
    }
    
</script>
<body>

<h1>Modificación de <span py:replace="name">Objeto</span></h1>

<div py:replace="form(value=record, action=tg.url('/curso/update/%d' % record.id),
    submit_text=_(u'Guardar'))">Formulario</div>
<br/>
<a href="${tg.url('/curso/from_file/%d' % record.id)}">Agregar Alumnos desde archivo</a>
    <br/>
    <br/>
<a href="${tg.url('/curso/show/%d' % record.id)}">Ver (cancela)</a> |
<a href="${tg.url('/curso/list')}">Volver (cancela)</a>

</body>
</html>
