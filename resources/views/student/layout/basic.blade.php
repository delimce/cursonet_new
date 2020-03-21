<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="csrf-token" content="{{ csrf_token() }}">
    <meta name="my-token" content="null">
    <link rel="shortcut icon" href="{!! url('assets/img/favicon.png') !!}">
    <title>Cursonet 2.0 - @yield('title')</title>
    @stack('head')
    <link rel="stylesheet" href="{!! url('assets/css/app.css') !!}">
</head>
<body>

<div id="app" class="container-fluid">
    @yield('content')
</div>
<!--Footer-->
<footer class="page-footer font-small blue pt-4 mt-4">
    <!--Copyright-->
    <div class="footer-copyright py-3 text-center">
        {{ trans('commons.created_by') }}<br>
        <a target="_blank" href="http://delimce.com">devElemento</a>
    </div>
    <!--/.Copyright-->
</footer>
<div id="axios-loader" class="lds-loading"></div>
<!--/.Footer-->
<script src="{!! url('assets/js/app.js') !!}"></script>
<script src="{!! url('assets/js/vendor.js') !!}"></script>
<script src="{!! url('assets/js/modules.js') !!}"></script>
@stack('scripts')
<script>
    (function ($) {
        $('#axios-loader').hide();
    }(jQuery));
</script>
</body>
</html>