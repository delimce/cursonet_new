@extends('student.layout.basic')
@section('title', 'Login')

@section('content')
    @component("student.components.loginbox")
        @slot("form")
            <form id="login_form" class="form-signin">
                <span id="reauth-email" class="reauth-email"></span>
                <input type="email" id="email" class="form-control" placeholder="@lang('students.email')" required
                       autocomplete="email"
                       autofocus>
                <div id="login-account">
                    <span class="forgot-password"><a
                                href="{!! url('student/forgotten') !!} ">@lang('students.login.forgotten')</a> </span>
                </div>
                <input type="password" id="password" class="form-control" placeholder="@lang('students.password')"
                       autocomplete="my-password" required>
                <button id="blogin" class="btn btn-lg btn-block btn-signin"
                        type="submit">@lang('students.login.login')</button>
                @component("student.components.tosignup")
                @endcomponent
            </form>
        @endslot
    @endcomponent
@endsection