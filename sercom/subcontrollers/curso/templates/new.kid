<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:py="http://purl.org/kid/ns#"
    py:extends="'../../../templates/master.kid'">
<head>

<script type="text/javascript">
    function makeOption(option) {
        return OPTION({"value": option.value}, option.text);
    }
                   
    function moveOption( fromSelect, toSelect) {
        // add 'selected' nodes toSelect
        appendChildNodes(toSelect,
        map( makeOption,ifilter(itemgetter('selected'), $(fromSelect).options)));
        // remove the 'selected' fromSelect
        replaceChildNodes(fromSelect,
            list(ifilterfalse(itemgetter('selected'), $(fromSelect).options))
        );
    }
    
    function mover(src, dest) {
        moveOption(src, dest)
    }
    
    function remover( src, dest ) {
        moveOption(src, dest)
    }
</script>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" py:replace="''"/>
<title>new</title>
</head>
<body>

<h1>Crear Nuevo <span py:replace="name">Objeto</span></h1>

<p py:replace="form(action=tg.url('/curso/create'), value=values, submit_text=_('Crear'))">Formulario</p>
<br/>
<a href="${tg.url('/curso/list')}">Cancelar</a>

</body>
</html>
