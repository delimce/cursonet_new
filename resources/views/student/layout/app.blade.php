<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="csrf-token" content="{{ csrf_token() }}">
    <meta name="my-token" content="{!! session()->get("myUser")->token !!}">
    <link rel="shortcut icon" href="{!! url('assets/img/favicon.png') !!}">
    <title>Cursonet 2.0 - @yield('title')</title>
    @stack('head')
    <link rel="stylesheet" href="{!! mix('assets/css/app.css') !!}">
</head>
<body>
<nav id="main-nav" class="navbar navbar-default navbar-fixed-top">
    <!-- Navbar content -->
    <div class="left-nav">
        <div id="nav-logo" onclick="redirect('{!! url('student/home') !!}')">&nbsp;</div>
        @if(session()->has('courseSelected'))
            @component("student.components.selectcourse",['courses' => session()->get("myCourses")])
            @endcomponent
        @endif    
    </div>

    @component("student.components.menubar",['data' => session()->get("myCourses")])
    @endcomponent

</nav>
<div id="app2" class="container-fluid">
    @yield('content')
    <div class="footer">
        <div class="footer-nav-items">
            <span><a href="{!! url('student/home') !!}">@lang('students.home')</a> </span>|
            <span class="feature"><a href="{!! url('student/publics') !!}">@lang('students.public_courses')</a> </span>|
            <span><a href="{!! url('student/teachers') !!}">@lang('students.teachers')</a></span>|
            <span><a href="#" data-toggle="modal" data-target="#support">
                    @lang('students.support')</a>
            </span>
        </div>
    </div>
</div>
<div id="axios-loader" class="lds-loading"></div>
@include('student.pages.lobby.support')
<script src="{!! mix('assets/js/app.js') !!}"></script>
<script src="{!! mix('assets/js/vendor.js') !!}"></script>
<script src="{!! mix('assets/ckeditor/ckeditor.js') !!}"></script>
<script src="{!! mix('assets/js/modules.js') !!}"></script>
@stack('scripts')
<script>
    (function ($) {
        $('[data-toggle="tooltip"]').tooltip()
        $('#axios-loader').hide();
        @stack('scripts-ready')
    }(jQuery));
</script>
</body>
</html>