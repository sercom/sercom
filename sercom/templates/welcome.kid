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
            <ul py:for="instancia in instancias_activas">
                <li>
                <?python delta = instancia.fin - now ?>
                La entrega ${instancia.numero} del
                ejercicio ${instancia.ejercicio.numero} vence
                el ${instancia.fin.strftime(r'%A %d de %B a las %R')}
                (falta ${delta.days} días,
                ${delta.seconds//3600} horas y
                ${delta.seconds//60%60} minutos) y tiene
                ${len(instancia.entregas)} entregas realizadas.
                </li>
            </ul>
        </div>
        <div py:if="not len(instancias_activas)">
            No hay Ejercicios con entregas en curso en este momento.
        </div>
    </div>

    <div py:if="'entregar' in identity.current.permissions and 'admin' not in identity.current.permissions">
			<h1>Soy entregar</h1>
        <h2>Instancias de Entrega</h2>
        <div py:if="len(instancias_activas)">
            <ul py:for="instancia in instancias_activas">
                <li>
                <?python delta = instancia.fin - now ?>
                La entrega ${instancia.numero} del
                ejercicio ${instancia.ejercicio.numero} vence
                el ${instancia.fin.strftime(r'%A %d de %B a las %R')}
								<br />
								(falta ${delta.days} días,
                ${delta.seconds//3600} horas y
                ${delta.seconds//60%60} minutos).
                </li>
            </ul>
        </div>
        <div py:if="not len(instancias_activas)">
            No hay Ejercicios con entregas en curso en este momento.
        </div>
    </div>
</body>
</html>
