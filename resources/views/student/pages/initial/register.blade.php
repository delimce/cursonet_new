@extends('student.layout.basic')
@section('title', 'Registrarse')
@push('head')
    <script src='https://www.google.com/recaptcha/api.js'></script>
@endpush
@section('content')
    <div id="login-box" class="card card-container2">
        <div class="logo_student">
            &nbsp;&nbsp;
        </div>
        <form id="register_form" class="form-signin">
            <div class="row">
                <div class="col-md-10 mx-auto">
                    <div class="form-group required row">
                        <div class="col-sm-6">
                            <label for="nombre" class="control-label">Nombre</label>
                            <input type="text" class="form-control" id="nombre" name="nombre" placeholder="Nombre"
                                   required>
                        </div>
                        <div class="col-sm-6">
                            <label for="apellido" class="control-label">Apellido</label>
                            <input type="text" class="form-control" id="apellido" name="apellido" placeholder="Apellido"
                                   required>
                        </div>
                    </div>
                    <div class="form-group required row">
                        <div class="col-sm-6">
                            <label for="id_number" class="control-label">Cédula</label>
                            <input type="text" class="form-control" id="id_number" name="id_number" placeholder="Cédula"
                                   required>
                        </div>
                        <div class="col-sm-6">
                            <label for="fecha_nac" class="control-label">Fecha de Nac.</label>
                            <input type="date" class="form-control" id="fecha_nac" name="fecha_nac"
                                   placeholder="Fecha de Nac."
                                   required>
                        </div>
                    </div>

                    <div class="form-group required row">
                        <div class="col-sm-6">
                            <label for="email" class="control-label">Email</label>
                            <input type="email" class="form-control" id="email" name="email" placeholder="Email"
                                   required>
                        </div>
                        <div class="col-sm-6">
                            <label for="email2" class="control-label">Confirmación de Email</label>
                            <input type="email" class="form-control" id="email2" name="email2" placeholder="confimación de Email"
                                   required>
                        </div>
                    </div>

                    <div class="form-group required row">
                        <div class="col-sm-6">
                            <label for="password1" class="control-label">Clave</label>
                            <input type="password" class="form-control" id="password1" name="password1"
                                   placeholder="Clave"
                                   required>
                        </div>
                        <div class="col-sm-6">
                            <label for="password2" class="control-label">Confirmación clave</label>
                            <input type="password" class="form-control" id="password2" name="password2"
                                   placeholder="confirme la clave" required>
                        </div>
                    </div>

                    <div class="form-group row">
                        <div class="col-sm-6">
                            <button id="bregister" class="btn btn-lg btn-block btn-signin" type="submit">Registrar
                            </button>
                        </div>
                        <div class="col-sm-6">
                            <div class="g-recaptcha" data-sitekey="6LcO41QUAAAAAK6wP3l8Xs62Az0oL-Z4n1smu_dB"
                                 data-callback="verifyRecaptchaCallback"
                                 data-expired-callback="expiredRecaptchaCallback"></div>
                            <input class="form-control d-none" data-recaptcha="true" required
                                   data-error="Please complete the Captcha">
                            <div class="help-block with-errors"></div>
                        </div>
                    </div>
                    <p>&nbsp;</p>
                </div>
            </div>

        </form><!-- /form -->
    </div><!-- /card-container -->
@endsection
@push('scripts')
    <script>

        $("#email").focusout(function () {

            if ($("#email").val().length > 3) {
                axios.post('{!! url('api/student/email/validate') !!}', {
                    email: $("#email").val()
                }).then(function (response) {
                    $("#email-validation").removeClass("unavailable-email").addClass("available-email").html("Email de usuario disponible");
                    $("#bregister").removeAttr('disabled');
                }).catch(function (error) {
                    $("#email-validation").removeClass("available-email").addClass("unavailable-email").html(error.response.data.message);
                    $("#bregister").attr('disabled', 'disabled');
                });

            }

        });

        $("#register_form").submit(function (event) {

            axios.post('{!! url('api/student/signup') !!}', {
                email: $("#email").val(),
                password: $("#password").val()
            }).then(function (response) {
                console.log(response);
            }).catch(function (error) {
                showAlert(error.response.data.message)
            });
            event.preventDefault();
        });
    </script>
@endpush

