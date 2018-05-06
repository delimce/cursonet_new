@extends('student.layout.basic')
@section('title', 'Cuenta activada éxitosamente')
@section('content')
    <div id="login-box" class="card card-container">
        <div class="logo_student">&nbsp</div>

        <div style="color: #fff">
            <div>
                ¡Listo <b>{{$user->nombre}}</b>! tu cuenta ha sido activada. Ahora puedes acceder
                usando tu correo de registro: <b>{{$user->email}}</b> y tu contraseña.  Bienvenid@ a <b>Cursonet</b>

            </div>
            <br>
            <p>
                <a href="{!! url('student/login') !!} ">Inicia sesión Aquí</a> </span>
            </p>
        </div>
    </div>
    </div><!-- /card-container -->
@endsection