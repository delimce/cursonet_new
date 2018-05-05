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
        <form id="register_form" class="form-signin"
              data-bv-submitbuttons='button[type="submit"]'
              data-bv-live="enabled">
            <div class="row">
                <div class="col-md-10 mx-auto">
                    <div class="form-group required row">
                        <div class="col-sm-6">
                            <label for="nombre" class="control-label">Nombre</label>
                            <input type="text" class="form-control" id="nombre" name="nombre" placeholder="Nombre"
                                   autocomplete="my-name"
                                   required>
                        </div>
                        <div class="col-sm-6">
                            <label for="apellido" class="control-label">Apellido</label>
                            <input type="text" class="form-control" id="apellido" name="apellido" placeholder="Apellido"
                                   autocomplete="my-lastname"
                                   required>
                        </div>
                    </div>
                    <div class="form-group required row">
                        <div class="col-sm-6">
                            <label for="id_number" class="control-label">Cédula</label>
                            <input type="text" class="form-control" id="id_number" name="id_number" placeholder="Cédula"
                                   autocomplete="numberid"
                                   required>
                        </div>
                        <div class="col-sm-6">
                            <label for="fecha_nac" class="control-label">Fecha de Nac.</label>
                            <input type="date" class="form-control" id="fecha_nac" name="fecha_nac"
                                   autocomplete="birthday"
                                   placeholder="Fecha de Nac."
                                   required>
                        </div>
                    </div>

                    <div class="form-group required row">
                        <div class="col-sm-6">
                            <label for="email" class="control-label">Email</label>
                            <input type="email" class="form-control" id="email" name="email" placeholder="Email"
                                   autocomplete="my-email"
                                   data-bv-identical="true"
                                   data-bv-identical-field="email2"
                                   data-bv-identical-message="el Email no es igual a la confirmación"
                                   required>
                        </div>
                        <div class="col-sm-6">
                            <label for="email2" class="control-label">Confirmación de Email</label>
                            <input type="email" class="form-control" id="email2" name="email2"
                                   placeholder="confimación de Email" autocomplete="my-email2"
                                   data-bv-identical="true"
                                   data-bv-identical-field="email"
                                   data-bv-identical-message="el Email no es igual a la confirmación"
                                   required>
                        </div>
                    </div>

                    <div class="form-group required row">
                        <div class="col-sm-6">
                            <label for="pass" class="control-label">Clave</label>
                            <input type="password" class="form-control" id="pass" name="pass"
                                   autocomplete="new-pass"
                                   placeholder="Clave"
                                   data-bv-identical="true"
                                   data-bv-identical-field="pass2"
                                   data-bv-identical-message="La clave no es igual a la confirmación"
                                   required>
                        </div>
                        <div class="col-sm-6">
                            <label for="password2" class="control-label">Confirmación clave</label>
                            <input type="password" class="form-control" id="pass2" name="pass2"
                                   autocomplete="new-pass2"
                                   data-bv-identical="true"
                                   data-bv-identical-field="pass"
                                   data-bv-identical-message="La clave no es igual a la confirmación"
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
        $(document).ready(function () {
            $('#register_form').bootstrapValidator().on('success.form.bv', function (e) {
                // Prevent form submission
                e.preventDefault();
                // Get the form instance
                var $form = $(e.target);
                axios.post('{!! url('api/student/signup') !!}', $form.serialize())
                .then(function (response) {
                   redirect("{!! url('student/register/success') !!}/"+$("#email").val(),false)
                }).catch(function (error) {
                    console.log(error);
                    showAlert(error.response.data.message);
                    $('#bregister').prop('disabled', false);
                });

            })


        });


    </script>
@endpush

