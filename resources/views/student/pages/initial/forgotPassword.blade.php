@extends('student.layout.basic')
@section('title', 'Recordar su clave')

@section('content')
    @component("student.components.loginbox")
        @slot("form")
            <form id="forgot_form" class="form-signin">
                <input type="email" id="email" class="form-control" placeholder="@lang('students.login.email')"
                       required>
                <button id="bforget" class="btn btn-lg btn-block btn-signin"
                        type="submit">@lang('students.login.reset_password')</button>
                @component("student.components.tosignup")
                @endcomponent
            </form>
        @endslot
    @endcomponent
@endsection