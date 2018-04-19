<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="shortcut icon" href="assets/img/favicon.png">
    <title>Cursonet 2.0 - @yield('title')</title>
    <!-- Bootstrap -->
    <link href="bower_components/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="assets/css/student.style.css" rel="stylesheet">
    <link rel="stylesheet" href="bower_components/roboto-fontface/css/roboto/roboto-fontface.css">
    <link rel="stylesheet" href="bower_components/roboto-fontface/css/roboto-condensed/roboto-condensed-fontface.css">
    <link rel="stylesheet" href="bower_components/roboto-fontface/css/roboto-slab/roboto-slab-fontface.css">
</head>
<body>


<div id="app" class="container-fluid">
    @yield('content')
</div>


<!--Footer-->
<footer class="page-footer font-small blue pt-4 mt-4">
    <!--Copyright-->
    <div class="footer-copyright py-3 text-center">
       Creado por:<br>
        <a target="_blank" href="http://develemento.com.ve">devElemento</a>
    </div>
    <!--/.Copyright-->
</footer>
<!--/.Footer-->

<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="bower_components/jquery/dist/jquery.min.js"></script>
<!-- Include all compiled plugins (below), or include individual files as needed -->
<script src="bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
</body>
</html>