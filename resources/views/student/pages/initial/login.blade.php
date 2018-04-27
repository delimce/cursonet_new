@extends('student.layout.basic')
@section('title', 'Login')
@section('sidebar')
    @parent
    <p>This is appended to the master sidebar.</p>
@endsection

@section('content')
    <div id="login-box" class="card card-container">
        <div class="logo_student">
            &nbsp;
        </div>
        <form class="form-signin">
            <span id="reauth-email" class="reauth-email"></span>
            <input type="email" v-model="email" class="form-control" placeholder="Usuario" required autofocus>
            <div id="login-account">
                <span class="forgot-password"><a href="{!! url('student/forgotten') !!} ">¿Olvidaste tu contraseña?</a> </span>
            </div>
            <input type="password" v-model="password" class="form-control" placeholder="Contraseña" required>
            <button class="btn btn-lg btn-block btn-signin" type="submit">Iniciar Sesión</button>
            <div id="login-account">
                <span>¿No tienes una cuenta?&nbsp;<a href="{!! url('student/register') !!} ">Registrate Aquí</a> </span>
            </div>
        </form><!-- /form -->
    </div><!-- /card-container -->
@endsection