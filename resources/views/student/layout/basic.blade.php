<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="csrf-token" content="{{ csrf_token() }}">
    <link rel="shortcut icon" href="assets/img/favicon.png">
    <title>Cursonet 2.0 - @yield('title')</title>
    <!-- Bootstrap -->
    <link href="{!! url('bower_components/bootstrap/dist/css/bootstrap.min.css') !!}" rel="stylesheet">
    <link rel="stylesheet" href="{!! url('bower_components/bootstrapvalidator/dist/css/bootstrapValidator.min.css') !!}"/>
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

<div id="app" class="container-fluid">
    @yield('content')
</div>
<!--Footer-->
<footer class="page-footer font-small blue pt-4 mt-4">
    <!--Copyright-->
    <div class="footer-copyright py-3 text-center">
        {{ trans('students.created_by') }}<br>
        <a target="_blank" href="http://develemento.com.ve">devElemento</a>
    </div>
    <!--/.Copyright-->
</footer>
<!--/.Footer-->

<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="{!! url('bower_components/jquery/dist/jquery.min.js') !!}"></script>
<script src="{!! url('bower_components/axios/dist/axios.min.js') !!}"></script>
<!-- Include all compiled plugins (below), or include individual files as needed -->
<script src="{!! url('bower_components/bootstrap/dist/js/bootstrap.min.js') !!}"></script>
<script src="{!! url('bower_components/bootstrapvalidator/dist/js/bootstrapValidator.min.js') !!}"></script>
<script type="text/javascript" src="{!! url('bower_components/bootstrapvalidator/src/js/language/es_ES.js') !!}"></script>
<script src="{!! url('bower_components/remarkable-bootstrap-notify/bootstrap-notify.min.js') !!}"></script>
<script src="{!! url('assets/js/functions.js') !!}"></script>
@stack('scripts')
</body>
</html>