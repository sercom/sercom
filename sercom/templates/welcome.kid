<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<?python from turbogears import identity ?>

<html xmlns="http://www.w3.org/1999/xhtml" xmlns:py="http://purl.org/kid/ns#"
    py:extends="'master.kid'">
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<title>Dashboard - SERCOM</title>
</head>
<body>
    <div py:if="'admin' in identity.current.permissions">
        <h1>Dashboard</h1>
        <h2>Correcciones</h2>
        <div py:if="a_corregir">
            En este momento tenes <a href="${tg.url('/correccion/')}">${a_corregir}</a> entregas para corregir.
        </div>
        <div py:if="not a_corregir">
            En este momento no tenés entregas para corregir.
        </div>
        <h2>Instancias de Entrega</h2>
        <div py:if="len(instancias_activas)">
            <ul py:for="i in instancias_activas">
                <li>
                <?python d = i.fin - now ?>
                La <a href="${tg.url('/curso/ejercicio/instancia/list/%d' % i.id)}">instancia
                ${i.numero}</a> del
                <a href="${tg.url('/curso/ejercicio/list/%d' % i.ejercicio.id)}">ejercicio
                ${i.ejercicio.numero}</a> vence en
                <span py:if="d.days">${d.days} días,</span>
                <span py:if="d.days or d.seconds">${d.seconds//3600}
                horas,</span> ${d.seconds//60%60} minutos
                (${i.fin.strftime(r'%F %R')}) y tiene
                <a href="${tg.url('/curso/ejercicio/instancia/entregas/%d' % i.id)}">${len(i.entregas)}
                entregas realizadas</a>.
                </li>
            </ul>
        </div>
        <div py:if="not len(instancias_activas)">
            No hay Ejercicios con entregas en curso en este momento.
        </div>
    </div>

    <div py:if="'entregar' in identity.current.permissions and 'admin' not in identity.current.permissions">
        <h2>Instancias de Entrega</h2>
        <div py:if="len(instancias_activas)">
            <ul py:for="instancia in instancias_activas">
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
        </div>
        <div py:if="not len(instancias_activas)">
					No hay fechas de entrega a vencer.
				</div>	
				<h2>Últimas entregas realizadas</h2>
        <table py:if="len(entregas)">
            <tr>
                <th>Curso</th>
                <th>Ejercicio</th>
                <th>Fecha Entrega</th>
            </tr>
            <tr py:for="e in entregas">
                <td>${e.instancia.ejercicio.curso.shortrepr()}</td>
                <td>${e.instancia.ejercicio.enunciado.nombre}</td>
                <td>${e.fecha}</td>
						</tr>
						<tr>
							<td colspan="3" align="right">
								<a href="${tg.url('/mis_entregas/list')}">Ver todas</a>
							</td>
						</tr>
        </table>
				<h2 py:if="len(correcciones)">Te han corregido los siguientes ejercicios</h2>
        <table py:if="len(correcciones)">
            <tr>
                <th>Curso</th>
                <th>Ejercicio</th>
                <th>Fecha</th>
                <th>Corrector</th>
                <th>Nota</th>
            </tr>
            <tr py:for="e in correcciones">
                <td>${e.instancia.ejercicio.curso.shortrepr()}</td>
                <td>${e.instancia.ejercicio.enunciado.nombre}</td>
                <td>${e.corregido}</td>
                <td>${e.corrector.shortrepr()}</td>
								<td>${e.nota}</td>
						</tr>
						<tr>
							<td colspan="5" align="right">
								<a href="${tg.url('/mis_correcciones/list')}">Ver todas</a>
							</td>
						</tr>
        </table>
    </div>
</body>
</html>
