<div class="cn-container" id="security-list">
    <div class="row">
        <div class="col-md-11 mx-auto">
            <span class="in-title">@lang('students.profile.security')</span>
            <div class="nav flex-column nav-pills" id="v-pills-tab" role="tablist" aria-orientation="vertical">
                <a class="nav-link active" id="v-pills-privacy-tab" data-toggle="pill" href="#v-pills-privacy"
                   role="tab" aria-controls="v-pills-privacy" aria-selected="true">Privacidad</a>
                <a class="nav-link" id="v-pills-notify-tab" data-toggle="pill" href="#v-pills-notify"
                   role="tab" aria-controls="v-pills-notify" aria-selected="false">Notificaciones</a>
                <a class="nav-link" id="v-pills-password-tab" data-toggle="pill" href="#v-pills-password"
                   role="tab" aria-controls="v-pills-password" aria-selected="false">Cambio de clave</a>
            </div>
            <div class="tab-content" id="v-pills-tabContent">
                <div class="tab-pane fade show active" id="v-pills-privacy" role="tabpanel"
                     aria-labelledby="v-pills-privacy-tab">
                    <div class="settings">
                        <div class="form-group">
                            <label for="share-info" class="control-label row">Compartir mis datos con los démas
                                Estudiantes</label>
                            <input id="share-info" class="toggle-in" data-value="share_info" data-width="90"
                                   type="checkbox" @if($data->share_info) checked @endif data-toggle="toggle"
                                   data-on="@lang('commons.enabled')"
                                   data-off="@lang('commons.disabled')">
                        </div>
                    </div>
                </div>
                <div class="tab-pane fade" id="v-pills-notify" role="tabpanel"
                     aria-labelledby="v-pills-notify-tab">
                    <div class="settings">
                        <div class="form-group">
                            <label for="notify-msg" class="control-label row">Notificar mis mensajes por
                                Email</label>
                            <input id="notify-msg" class="toggle-in" data-value="notify_msg" data-size="small"
                                   type="checkbox" @if($data->notify_msg) checked @endif data-toggle="toggle"
                                   data-on="@lang('commons.yes')"
                                   data-off="@lang('commons.no')">
                        </div>
                        <div class="form-group">
                            <label for="notify-forum" class="control-label row">Recibir notificaciones de los
                                foros</label>
                            <input id="notify-forum" class="toggle-in" data-value="notify_forum" data-size="small"
                                   type="checkbox" @if($data->notify_forum) checked @endif data-toggle="toggle"
                                   data-on="@lang('commons.yes')"
                                   data-off="@lang('commons.no')">
                        </div>
                        <div class="form-group">
                            <label for="notify-exam" class="control-label row">Recibir notificaciones de los
                                Examenes</label>
                            <input id="notify-exam" class="toggle-in" data-value="notify_exam" data-size="small"
                                   type="checkbox" @if($data->notify_exam) checked @endif data-toggle="toggle"
                                   data-on="@lang('commons.yes')"
                                   data-off="@lang('commons.no')">
                        </div>
                    </div>
                </div>
                <div class="tab-pane fade" id="v-pills-password" role="tabpanel"
                     aria-labelledby="v-pills-password-tab">
                    <form id="form_pass">
                        <div class="settings">
                            <div class="form-group">
                                <label for="pass" class="control-label row">Nueva Clave</label>
                                <input type="password" class="form-control" id="pass" name="pass"
                                       autocomplete="new-pass"
                                       placeholder="Clave"
                                       data-bv-identical="true"
                                       data-bv-identical-field="pass2"
                                       data-bv-identical-message="La clave no es igual a la confirmación"
                                       required>
                            </div>
                            <div class="form-group">
                                <label for="password2" class="control-label row">Confirmación clave</label>
                                <input type="password" class="form-control" id="pass2" name="pass2"
                                       autocomplete="new-pass2"
                                       data-bv-identical="true"
                                       data-bv-identical-field="pass"
                                       data-bv-identical-message="La clave no es igual a la confirmación"
                                       placeholder="confirme la clave" required>
                            </div>
                            <div style="width: 180px; float: left; padding: 15px">
                                <button id="savepass" class="btn btn-lg btn-block btn-signin" type="submit">
                                    @lang('students.profile.save.password')
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
@push('scripts')
    <script>
        $('.toggle-in').on('change', function (event) {
            var status = $(this).prop('checked');
            var value = $(this).data('value');
            axios.put('{!! url('api/student/account/settings') !!}', {
                status: status,
                field: value
            }).then(function (response) {
                showSuccess(response.data.message, 2000)
            }).catch(function (error) {
                showAlert(error.response.data.message)
            });
        })

        $('#form_pass').bootstrapValidator().on('success.form.bv', function (e) {
            // Prevent form submission
            e.preventDefault();
            // Get the form instance
            var $form = $(e.target);
            axios.put('{!! url('api/student/account/changePass') !!}', $form.serialize())
                .then(function (response) {
                    showSuccess(response.data.message, 2000)
                }).catch(function (error) {
                showAlert(error.response.data.message);
                $("#savepass").prop('disabled', false);
            });

        })
    </script>
@endpush