<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<?python
    from sercom.model import Docente, Alumno, Correccion
    from turbogears import identity
    usuario = identity.current.user
?>

<html xmlns="http://www.w3.org/1999/xhtml" xmlns:py="http://purl.org/kid/ns#"
    py:extends="'master.kid'">
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<title>Dashboard - SERCOM</title>
</head>
<body>
    <h1>Dashboard</h1>
    <div py:if="not curso">
       Ningún curso fue seleccionado.
    </div>

    <div py:if="curso and 'corregir' in identity.current.permissions">
        <table>
            <tr>
                <th>Entrega Ejercicio</th>
                <th>Alumnos con Entregas</th>
                <th>Aceptadas</th>
                <th>Corregidas</th>
                <th>&nbsp;</th>
            </tr>
            <tr py:for="inst in curso.instancias_a_corregir">
                <?python
                   if inst.id in [ 22 ]:
                     resumenes = []
                   else:
                     resumenes = inst.get_resumen_entregas()
                   entregados = len([r for r in resumenes if r.tiene_entregas])
                   aceptados = len([r for r in resumenes if r.entregas_exitosas > 0])
                ?>
                <td>${inst.numerorepr()}</td>
                <td>${entregados}</td>
                <td>${aceptados}</td>
                <td><a href="${tg.url('/correccion/resumen_entregas/%d' % inst.id)}">Ver Entregas</a>
                </td>
            </tr>
        </table>
    </div>

    <div py:if="curso and 'corregir' not in identity.current.permissions">
        <h2>Instancias de Entrega</h2>
        <ul py:for="instancia in instancias_activas" py:strip="not instancias_activas">
            <li>
            <?python d = instancia.fin - now ?>
            La entrega ${instancia.numero} del
            ejercicio ${instancia.ejercicio.numero} vence
            el ${instancia.fin.strftime(r'%A %d de %B a las %R')}
            <br />
            (falta ${d.days} días,
            ${d.seconds//3600} horas y
            ${d.seconds//60%60} minutos).
            </li>
        </ul>
        <div py:if="not instancias_activas">
          No hay fechas de entrega a vencer.
        </div>	
    </div>
</body>
</html>
