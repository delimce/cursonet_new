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
        <div id="nav-logo" onclick="redirect('{!! url('student/home') !!}')">&nbsp;</div>
        @component("student.components.selectcourse",['courses' => session()->get("myCourses")])
        @endcomponent
    </div>

    <div class="right-nav">
        @component("student.components.profileInfo",['data' => session()->get("myUser")])
        @endcomponent
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
            <span><a href="{!! url('student/teachers') !!}">@lang('students.teachers')</a></span>|
            <span><a href="#" data-toggle="modal" data-target="#support">
                    @lang('students.support')</a>
            </span>
        </div>
    </div>
</div>
@include('student.pages.lobby.support')
<script src="{!! url('assets/js/functions.js') !!}"></script>
<script src="{!! url('bower_components/select2/dist/js/select2.min.js') !!}"></script>
<script src="{!! url('bower_components/ckeditor/ckeditor.js') !!}"></script>
@stack('scripts')
<script>
 (function($) {
   $('[data-toggle="tooltip"]').tooltip()
   @stack('scripts-ready')
}(jQuery));
</script>
</body>
</html>