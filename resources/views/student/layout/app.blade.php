<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="shortcut icon" href="assets/img/favicon.png">
    <title>Cursonet 2.0 - @yield('title')</title>
    <!-- Bootstrap -->
    <link href="{!! url('bower_components/bootstrap/dist/css/bootstrap.min.css') !!}" rel="stylesheet">
    <link href="{!! url('bower_components/select2/dist/css/select2.min.css') !!}" rel="stylesheet"/>
    <link href="{!! url('bower_components/animate.css/animate.min.css') !!}" rel="stylesheet"/>
    <link href="{!! url('bower_components/font-awesome/web-fonts-with-css/css/fontawesome-all.min.css') !!}"
          rel="stylesheet">
    <link href="{!! url('assets/css/commons.css') !!}" rel="stylesheet">
    <link href="{!! url('assets/css/student.style.css') !!}" rel="stylesheet">
    <link rel="stylesheet" href="{!! url('bower_components/roboto-fontface/css/roboto/roboto-fontface.css') !!} ">
    <link rel="stylesheet"
          href="{!! url('bower_components/roboto-fontface/css/roboto-condensed/roboto-condensed-fontface.css') !!}">
    <link rel="stylesheet"
          href="{!! url('bower_components/roboto-fontface/css/roboto-slab/roboto-slab-fontface.css') !!}">
    @stack('head')
</head>
<body>
<nav id="main-nav" class="navbar navbar-default navbar-fixed-top">
    <!-- Navbar content -->
    <div class="left-nav">
        <div id="nav-logo">&nbsp;</div>
        <span>Curso seleccionado:</span>
        <div id="nav-selects">
            <select class="adv-select" name="state">
                <option value="">&nbsp;</option>
                <option value="AL">Informatica</option>
                <option value="WY">Biologia</option>
            </select>

        </div>
    </div>

    <div class="right-nav">
        <div class="profile-activity clearfix">
            <div id="user-logged">
                <h1><i class="fas fa-user-circle"></i></h1>
                <div id="user-info">
                    <span><b>Estudiante:</b>&nbsp;Ramon Jose Alvarado Ramirez</span>
                    <span><a href="#">Editar Perfil</a></span>
                </div>
            </div>
        </div>
        <div class="nav-items">
            <span><a href="{!! url('student/home') !!}">Inicio</a> </span>|
            <span><a href="#">Mis Notas</a></span>|
            <span><a href="#">Mensajes</a></span>|
            <span><a style="color: #00ccff" href="#">Cerrar sesion</a></span>
        </div>
    </div>

</nav>
<div id="app2" class="container-fluid">
    @yield('content')

    <div class="footer">
        <div class="footer-nav-items">
            <span><a href="{!! url('student/home') !!}">Inicio</a> </span>|
            <span><a href="#">Facilitadores</a></span>|
            <span><a href="#">Centro de Soporte</a></span>
        </div>
    </div>

</div>


<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="{!! url('bower_components/jquery/dist/jquery.min.js') !!}"></script>
<script src="{!! url('bower_components/select2/dist/js/select2.min.js') !!}"></script>
<!-- Include all compiled plugins (below), or include individual files as needed -->
<script src="{!! url('bower_components/bootstrap/dist/js/bootstrap.min.js') !!}"></script>
<script src="{!! url('bower_components/remarkable-bootstrap-notify/bootstrap-notify.min.js') !!}"></script>
<script src="{!! url('assets/js/functions.js') !!}"></script>
@stack('scripts')
<script>
    $(document).ready(function () {
        $('.adv-select').select2({
            placeholder: "Seleccone un curso",
            allowClear: true
        });
    });
</script>
</body>
</html>