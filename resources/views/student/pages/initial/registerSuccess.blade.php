@extends('student.layout.basic')
@section('title', 'Registro exitoso')

@section('content')
    @component("student.components.loginbox")
        @slot("title")
            Registro exitoso,
        @endslot
        @slot("info")
            <div id="login-account" style="text-align: center">
                Se ha enviado un correo electrónico,
                para la activación de tu cuenta a la dirección:<br> <b>{{$email}}</b>
                <br><br>
                <p class="reactive">Revisa tu bandeja de entrada</p>
                <p>¡Gracias por registrarte!</p>
            </div>
        @endslot
    @endcomponent
@endsection
