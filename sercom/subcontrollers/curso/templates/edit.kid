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
        <span py:for="d in record.docentes_to" py:strip="True">
            MochiKit.DOM.appendChildNodes("form_docentes_to", OPTION({"value":${d['id']}}, '${d['label']}'))
        </span>

        <span py:for="a in record.alumnos_inscriptos" py:strip="True">
            MochiKit.DOM.appendChildNodes("form_alumnos", OPTION({"value":${a['id']}}, '${a['label']}'))
        </span>
                // Saco de FROM los que ya estan en TO
                replaceChildNodes('form_docentes_from', list(ifilterfalse(
                    partial(esta_en_to, $('form_docentes_to').options),
                    $('form_docentes_from').options
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
<body>

<h1>Modificación de <span py:replace="name">Objeto</span></h1>

<div py:replace="form(value=record, action=tg.url('/curso/update/%d' % record.id),
    submit_text=_(u'Guardar'))">Formulario</div>
<br/>
<a href="${tg.url('/curso/from_file/%d' % record.id)}">Agregar Alumnos desde archivo</a>
    <br/>
    <br/>
<a href="${tg.url('/grupo_admin/new/%d' % record.id)}">Mezclar, Juntar, Separar Grupos</a>
<br/>
<br/>
<a href="${tg.url('/curso/show/%d' % record.id)}">Ver (cancela)</a>
<a href="${tg.url('/curso/list')}">Volver (cancela)</a>

</body>
</html>
