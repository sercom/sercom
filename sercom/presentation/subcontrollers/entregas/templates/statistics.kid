<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:py="http://purl.org/kid/ns#"
    py:extends="'../../../templates/master.kid'">
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" py:replace="''"/>
<title>new</title>
</head>
<body>

Estadisticas
| <a href="${tg.url('/entregas/force_new')}">Forzar Entrega</a>

<h1>Estadisticas sobre entregas</h1>


<script type="text/javascript" src="http://www.google.com/jsapi"></script>

<script type="text/javascript">
  google.load('visualization', '1', {'packages':['piechart', 'table', 'linechart']});
  google.setOnLoadCallback(drawChart);
  
  function drawChart() {
        var data = new google.visualization.DataTable();
        data.addColumn('string', 'Instancia');  // Column 0 is type string and has label "Task".
        data.addColumn('number', 'Cant. Entregas'); // Column 1 is type number and has label "Hours per Day".
        data.addRows([
                       ${','.join(["['%s',%s]" % c for c in cant_entregas])}
          ]);
        var chart = new google.visualization.BarChart(document.getElementById('chart_div'));
        chart.draw(data, {width: 400, height: 240, is3D: true, title: 'Entregas por Instancia'});
  }
</script>

    <div id="chart_div"></div>

</body>
</html>
