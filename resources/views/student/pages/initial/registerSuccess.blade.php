@extends('student.layout.basic')
@section('title', 'Registro exitoso')

@section('content')
    <div id="login-box" class="card card-container">
        <div class="logo_student">
            &nbsp;
        </div>
        <div id="login-account" style="text-align: center">
            Registro exitoso, se ha enviado un correo electrónico,
            para la activación de tu cuenta a la dirección:<br> <b>{{$email}}</b>
            <br><br>
           <p class="reactive">Revisa tu bandeja de entrada</p>
           <p>¡Gracias por registrarte!</p>
        </div>

    </div><!-- /card-container -->
@endsection
