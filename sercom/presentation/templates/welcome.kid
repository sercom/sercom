<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<?python
    from sercom.model import Docente, Alumno, Correccion, Permiso
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
        <h3>Detalles de Ejercicios</h3>
        <table>
            <tr>
                <th>Entrega Ejercicio</th>
                <th>Total alumnos con entregas</th>
                <th>Con entregas aceptadas</th>
                <th>&nbsp;</th>
            </tr>
            <tr py:for="inst in curso.instancias_de_entrega">
                <?python
                   resumenes = inst.get_resumen_entregas()
                   entregados = len([r for r in resumenes if r.tiene_entregas])
                   aceptados = len([r for r in resumenes if r.entregas_aceptadas > 0])
                ?>
                <td>${inst.shortrepr()+ (inst.abierta and ' (abierta)' or '') }</td>
                <td>${entregados}</td>
                <td>${aceptados}</td>
                <td><a href="${tg.url('/correccion/resumen_entregas/%d' % inst.id)}">Ver Entregas</a>
                </td>
            </tr>
        </table>
    </div>

    <div py:if="Permiso.examen.respuesta.revisar in identity.current.permissions">
        <h3>Respuestas pendientes de revisión</h3>
        <div py:if="respuestas_pendientes">
            <table width="60%">
                <tr>
                    <th>Autor</th>
                    <th>Examen</th>
                    <th>Núm. Pregunta</th>
                    <th></th>
                </tr>
                <tr py:for="r in respuestas_pendientes">
                    <td>${r.autor}</td>
                    <td>${r.pregunta.examen}</td>
                    <td>${r.pregunta.numero}</td>
                    <td><a href="${tg.url('/examenes/respuesta/edit/%d/%d' % (r.preguntaID,r.id))}">Revisar</a></td>
                </tr>
            </table>
        </div>
        <div py:if="not respuestas_pendientes">
            No hay respuestas pendientes a la fecha.
        </div>
    </div>

    <div py:if="curso and 'corregir' not in identity.current.permissions">
        <h3>Correcciones</h3>
        <div py:if="correcciones">
            <table width="60%">
                <tr>
                    <th>Ejercicio</th>
                    <th>Corrector</th>
                    <th>Nota</th>
                    <th>Observaciones</th>
                </tr>
                <tr py:for="c in correcciones">
                    <td>${c.instancia}</td>
                    <td>${c.corrector}</td>
                    <td>${c.nota}</td>
                    <td>${c.observaciones}</td>
                </tr>
            </table>
        </div>
        <div py:if="not correcciones">
            No hay correcciones a la fecha.
        </div>
    </div> 

    <div py:if="curso and 'corregir' not in identity.current.permissions">
        <h3>Instancias de Entrega</h3>
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
