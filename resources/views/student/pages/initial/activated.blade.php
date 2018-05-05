@extends('student.layout.basic')
@section('title', 'Cuenta activada éxitosamente')
@section('content')
    <div id="login-box" class="card card-container">
        <div class="logo_student">&nbsp</div>

        <div style="color: #fff">
            <span class="subtext">Tu cuenta ha sido activada.</span>
                <br><br>
            <div>
                ¡Lo lograste <b>{{$user->nombre}}</b>! tu cuenta ha sido activada. Ahora puedes acceder simplemente
                usando tu correo de registro: <b>{{$user->email}}</b> y tu contraseña, te damos la bienvenida
                a la plataforma de enseñanza <b>Cursonet</b>
            </div>
            <br>
            <p>
                <a href="{!! url('student/login') !!} ">Inicia sesión Aquí</a> </span>
            </p>
        </div>
    </div>
    </div><!-- /card-container -->
@endsection