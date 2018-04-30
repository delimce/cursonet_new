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
        <form class="form-signin">
            <div class="row">
                <div class="col-md-10 mx-auto">
                    <div class="form-group required row">
                        <div class="col-sm-6">
                            <label for="inputFirstname" class="control-label">Nombre</label>
                            <input type="text" class="form-control" id="inputFirstname" placeholder="Nombre" required>
                        </div>
                        <div class="col-sm-6">
                            <label for="inputLastname" class="control-label">Apellido</label>
                            <input type="text" class="form-control" id="inputLastname" placeholder="Apellido" required>
                        </div>
                    </div>
                    <div class="form-group required row">
                        <div class="col-sm-6">
                            <label for="inputAddressLine1" class="control-label">Cédula</label>
                            <input type="text" class="form-control" id="inputAddressLine1" placeholder="Cédula"
                                   required>
                        </div>
                        <div class="col-sm-6">
                            <label for="inputAddressLine1" class="control-label">Fecha de Nac.</label>
                            <input type="date" class="form-control" id="inputAddressLine1" placeholder="Fecha de Nac."
                                   required>
                        </div>
                    </div>

                    <div class="form-group required row">
                        <div class="col-sm-6">
                            <label for="inputAddressLine2" class="control-label">Email</label>
                            <input type="email" class="form-control" id="inputAddressLine2" placeholder="Email"
                                   required>
                        </div>
                        <div class="col-sm-6">
                            <label for="inputAddressLine2" class="control-label">usuario</label>
                            <input type="text" maxlength="16" class="form-control" id="inputAddressLine2"
                                   placeholder="Usuario" required>
                        </div>
                    </div>

                    <div class="form-group required row">
                        <div class="col-sm-6">
                            <label for="inputContactNumber" class="control-label">Clave</label>
                            <input type="password" class="form-control" id="inputContactNumber" placeholder="Clave"
                                   required>
                        </div>
                        <div class="col-sm-6">
                            <label for="inputWebsite" class="control-label">Confirmación clave</label>
                            <input type="password" class="form-control" id="inputWebsite"
                                   placeholder="confirme la clave" required>
                        </div>
                    </div>

                    <div class="form-group row">
                        <div class="col-sm-6">
                            <button class="btn btn-lg btn-block btn-signin" type="submit">Registrar</button>
                        </div>
                        <div class="col-sm-6">
                            <div class="g-recaptcha" data-sitekey="6LcO41QUAAAAAK6wP3l8Xs62Az0oL-Z4n1smu_dB" data-callback="verifyRecaptchaCallback" data-expired-callback="expiredRecaptchaCallback"></div>
                            <input class="form-control d-none" data-recaptcha="true" required data-error="Please complete the Captcha">
                            <div class="help-block with-errors"></div>
                        </div>
                    </div>
                    <p>&nbsp;</p>
                </div>
            </div>

        </form><!-- /form -->
    </div><!-- /card-container -->
@endsection