<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:py="http://purl.org/kid/ns#"
    py:extends="'../../../templates/master.kid'">
<head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
    <title>Corregir</title>
</head>
<?python
    ins = correccion.instancia
    ent = correccion.entrega
    eje = ins.ejercicio
    entregador = correccion.entregador
?>
<body>
    <h1>Ejercicio ${ins.numerorepr()}
            de ${entregador}</h1>
    <div>
        <a href="${tg.url('/mis_entregas/corrida/%d' % ent.id)}"
                >Ver entrega a corregir</a> |
        <a href="${tg.url('/mis_entregas/get_archivo/%d' % ent.id)}"
                >Bajar entrega a corregir</a> |
        <a href="${tg.url('/curso/ejercicio/instancia/entregas/%d/%d' % (ins.id, entregador.id))}"
                >Ver todas las entregas</a>
    </div>
    <br />
    ${correccion_form(value=correccion, options=options, action=action)}

<br/>
<a href="javascript:window.history.go(-1)">Volver (cancela)</a>


</body>
</html>
