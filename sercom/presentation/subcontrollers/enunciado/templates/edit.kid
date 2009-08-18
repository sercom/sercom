<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:py="http://purl.org/kid/ns#"
    py:extends="'../../../templates/master.kid'">
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" py:replace="''"/>
<title>edit</title>
<script type="text/javascript">
    function init_data() {
        <span py:for="a in record.tareas_fuente" py:strip="True">
            MochiKit.DOM.appendChildNodes("form_tareas_fuente_to", OPTION({"value":${a['id']}}, '${a['label']}'))
        </span>
        <span py:for="a in record.tareas_prueba" py:strip="True">
            MochiKit.DOM.appendChildNodes("form_tareas_prueba_to", OPTION({"value":${a['id']}}, '${a['label']}'))
        </span>
        // Saco de FROM los que ya estan en TO
        replaceChildNodes('form_tareas_fuente_from', list(ifilterfalse(
           partial(esta_en_to, $('form_tareas_fuente_to').options),
           $('form_tareas_fuente_from').options
        )));
        replaceChildNodes('form_tareas_prueba_from', list(ifilterfalse(
           partial(esta_en_to, $('form_tareas_prueba_to').options),
           $('form_tareas_prueba_from').options
        )));
    }
    function esta_en_to (options, i) {
            for (j=0; j &lt; options.length; j++)
                if (options[j].value == i.value)
                    return true;
            return false;
        }
    MochiKit.DOM.addLoadEvent(init_data)
</script>
</head>
<body>

<h1>Modificación de <span py:replace="name">Objeto</span></h1>

<div py:replace="form(value=record, action=tg.url('/enunciado/update/%d' % record.id),
	submit_text=_(u'Guardar'))">Formulario</div>

<br/>
<a href="${tg.url('/enunciado/show/%d' % record.id)}">Ver (cancela)</a> |
<a href="${tg.url('/enunciado/list')}">Volver (cancela)</a>

</body>
</html>
