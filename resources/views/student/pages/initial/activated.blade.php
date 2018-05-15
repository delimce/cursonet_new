@extends('student.layout.basic')
@section('title', 'Cuenta activada éxitosamente')
@section('content')
    @component("student.components.loginbox")
        @slot("info")
            <div style="color: #fff">
                <div>
                    ¡Listo <b>{{$user->nombre}}</b>! tu cuenta ha sido activada. Ahora puedes acceder
                    usando tu correo de registro: <b>{{$user->email}}</b> y tu contraseña. Bienvenid@ a <b>Cursonet</b>
                </div>
                <br>
                <p>
                    <a href="{!! url('student/login') !!} ">@lang('students.login.login')</a>
                </p>
            </div>
        @endslot
    @endcomponent
@endsection