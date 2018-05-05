@extends('student.layout.basic')
@section('title', 'Recordar su clave')

@section('content')
    <div id="login-box" class="card card-container">
        <div class="logo_student">
            &nbsp;
        </div>
        <form id="forget_form" class="form-signin">
            <input type="email" id="email" class="form-control" placeholder="Email Registrado" required>
            <button class="btn btn-lg btn-block btn-signin" type="submit">Reiniciar mi clave</button>
            <div id="login-account">
                <span>¿No tienes una cuenta?&nbsp;<a href="{!! url('student/register') !!} ">Registrate Aquí</a> </span>
            </div>
        </form><!-- /form -->
    </div><!-- /card-container -->
@endsection
@push('scripts')
    <script>
        $("#forget_form").submit(function (event) {

            axios.post('{!! url('api/student/forgotten') !!}', {
                email: $("#email").val()
            }).then(function (response) {
                showSuccess(response.data.message, 5000)
            }).catch(function (error) {
                showAlert(error.response.data.message)
            });
            event.preventDefault();
        });
    </script>
@endpush