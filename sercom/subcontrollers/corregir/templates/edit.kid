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
    ali = correccion.entregador
    alu = ali.alumno
?>
<body>
    <h1>Ejercicio ${eje.numero}.${eje.numero}
            de ${alu.nombre} (${alu.padron})</h1>
    <div>
        <a href="${tg.url('/mis_entregas/corrida/%d' % ent.id)}"
                >Ver entrega a corregir</a> |
        <a href="${tg.url('/curso/ejercicio/instancia/entregas/%d/%d' % (ins.id, ali.id))}"
                >Ver todas las entregas del alumno para esta instancia</a>
    </div>
    <br />
    ${correccion_form(value=correccion, options=options, action=action)}
</body>
</html>
