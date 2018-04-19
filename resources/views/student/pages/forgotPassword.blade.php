@extends('student.layout.basic')
@section('title', 'Recordar su clave')

@section('content')
    <div id="login-box" class="card toright card-container">
        <div class="logo_student">
            &nbsp;
        </div>
        <form class="form-signin">
            <input type="email" v-model="email" class="form-control" placeholder="Email Registrado" required autofocus>
            <button class="btn btn-lg btn-block btn-signin" type="submit">Reiniciar mi clave</button>
            <div id="login-account">
                <span>¿No tienes una cuenta?&nbsp;<a href="#">Registrate Aquí</a> </span>
            </div>
        </form><!-- /form -->
    </div><!-- /card-container -->
@endsection