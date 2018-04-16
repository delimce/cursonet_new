@extends('student.layout.basic')
@section('title', 'Login')
@section('sidebar')
    @parent

    <p>This is appended to the master sidebar.</p>
@endsection

@section('content')
    <div id="login-box" class="card toright card-container">
        <!-- <img class="profile-img-card" src="//lh3.googleusercontent.com/-6V8xOA6M7BA/AAAAAAAAAAI/AAAAAAAAAAA/rzlHcD0KYwo/photo.jpg?sz=120" alt="" /> -->
        <img id="profile-img" class="profile-img-card" src="//ssl.gstatic.com/accounts/ui/avatar_2x.png"/>
        <form class="form-signin">
            <div style="text-align:right">
                <span class="minText">&nbsp;</span>
            </div>

            <span id="reauth-email" class="reauth-email"></span>
            <input type="email" v-model="email" class="form-control" placeholder="Usuario" required autofocus>
            <input type="password" v-model="password" class="form-control" placeholder="Contraseña" required>
            <button class="btn btn-lg btn-success btn-block btn-signin" type="submit">Iniciar Sesión</button>
        </form><!-- /form -->
    </div><!-- /card-container -->
@endsection