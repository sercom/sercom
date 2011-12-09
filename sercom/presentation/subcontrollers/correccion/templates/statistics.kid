<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:py="http://purl.org/kid/ns#"
    py:extends="'../../../templates/master.kid'">
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" py:replace="''"/>
<title>Estadísticas sobre Correcciones</title>
</head>
<body>

Estadísticas
| <a href="${tg.url('/correccion/mis_correcciones')}">Mis Correcciones</a>
| <a href="${tg.url('/correccion/resumen_entregas')}">Resumen de Entregas</a>
| <a href="${tg.url('/correccion/resumen_por_alumno')}">Resumen por Alumno</a>

<h1>Estadisticas sobre Correcciones</h1>


<script type="text/javascript" src="http://www.google.com/jsapi"></script>

<script type="text/javascript">
  google.load('visualization', '1', {'packages':['piechart', 'table', 'linechart']});
  google.setOnLoadCallback(drawChart);
  
  function drawChart() {
        var data = new google.visualization.DataTable();
        data.addColumn('string', 'Instancia');
        data.addColumn('number', 'Promedio Correcciones');
        data.addRows([
                       ${','.join(["['%s',%s]" % (c[0],c[1] or 'null') for c in promedio_por_instancia])}
          ]);
        var chart = new google.visualization.BarChart(document.getElementById('chart_prom_por_instancia_div'));
        chart.draw(data, {width: 500, height: 300, is3D: true, title: 'Promedio por Instancia'});


        var data = new google.visualization.DataTable();
        data.addColumn('string', 'Instancia');
        data.addColumn('number', 'Cant. Aprobados');
        data.addRows([
                       ${','.join(["['%s',%s]" % a for a in aprobados_por_instancia])}
          ]);
        var chart = new google.visualization.BarChart(document.getElementById('chart_aprobados_por_instancia_div'));
        chart.draw(data, {width: 500, height: 300, is3D: true, title: 'Aprobados por Instancia'});
   }
</script>

    <div id="chart_prom_por_instancia_div"></div>
    <br/>
    <div id="chart_aprobados_por_instancia_div"></div>

</body>
</html>
