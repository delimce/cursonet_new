@extends('student.layout.basic')
@section('title', 'Registro exitoso')

@section('content')
    @component("student.components.loginbox")
        @slot("title")
            @lang('students.register.success')
        @endslot
        @slot("info")
            <div id="login-account" style="text-align: center">
                Hemos enviado un correo electrónico a&nbsp;
                <b>{{$email}}</b> para activar tu cuenta<br>
                <br><br>
                <p class="reactive">Revisa tu bandeja de entrada</p>
                <p>@lang('students.register.thanks')</p>
            </div>
        @endslot
    @endcomponent
@endsection
