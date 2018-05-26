<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="csrf-token" content="{{ csrf_token() }}">
    <link rel="shortcut icon" href="{!! url('assets/img/favicon.png') !!}">
    <title>Cursonet 2.0 - @yield('title')</title>
    {{--ccs files--}}
    @include('student.layout.css')
    {{--js files--}}
    @include('student.layout.js')
    @stack('head')
    <link rel="stylesheet" href="{!! url('assets/css/commons.css') !!}">
    <link rel="stylesheet" href="{!! url('assets/css/student.style.css') !!}">
</head>
<body>
<nav id="main-nav" class="navbar navbar-default navbar-fixed-top">
    <!-- Navbar content -->
    <div class="left-nav">
        <div id="nav-logo">&nbsp;</div>
        @component("student.components.selectcourse",['courses' => session()->get("myCourses")])
        @endcomponent
    </div>

    <div class="right-nav">
        <div class="profile-activity clearfix">
            <div id="user-logged">
                <h1><i class="fas fa-user-circle"></i></h1>
                <div id="user-info">
                    <span><b>@lang('commons.student'):</b>&nbsp;Ramon Jose Alvarado Ramirez</span>
                    <span><a href="#">@lang('students.edit_profile')</a></span>
                </div>
            </div>
        </div>
        <div class="nav-items">
            <span><a href="{!! url('student/home') !!}">@lang('students.home')</a> </span>|
            <span><a href="#">@lang('students.my_results')</a></span>|
            <span><a href="{!! url('student/inbox') !!}">@lang('commons.messages')</a></span>|
            <span><a style="color: #00ccff" href="{!! url('student/logout') !!}">@lang('commons.logout')</a></span>
        </div>
    </div>

</nav>
<div id="app2" class="container-fluid">
    @yield('content')
    <div class="footer">
        <div class="footer-nav-items">
            <span><a href="{!! url('student/home') !!}">@lang('students.home')</a> </span>|
            <span><a href="#">@lang('students.teachers')</a></span>|
            <span><a href="#" data-toggle="modal" data-target="#support">
                    @lang('students.support')</a>
            </span>
        </div>
    </div>
</div>
@include('student.pages.lobby.support')
<script src="{!! url('assets/js/functions.js') !!}"></script>
@stack('scripts')
<script>
    $(document).ready(function () {
        @stack('scripts-ready')
    });
</script>
</body>
</html>