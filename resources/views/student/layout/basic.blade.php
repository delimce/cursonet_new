<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="csrf-token" content="{{ csrf_token() }}">
    <link rel="shortcut icon" href="assets/img/favicon.png">
    <title>Cursonet 2.0 - @yield('title')</title>
    {{--ccs files--}}
    @include('student.layout.css')
    {{--js files--}}
    @include('student.layout.js')
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
<script src="{!! url('assets/js/functions.js') !!}"></script>
@stack('scripts')
</body>
</html>