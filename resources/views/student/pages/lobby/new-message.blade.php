<div class="modal fade" id="new-message" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle"
     aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h6 class="modal-title" id="exampleModalLongTitle">
                    <i class="fas fa-envelope"></i>
                    @lang('students.inbox.compose.title')</h6>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="form-message">
                    <div class="form-group">
                        <div class="select-to">
                           &nbsp;
                        </div>
                        <br>
                        <input type="text" placeholder="@lang('students.inbox.subject')" class="form-control"
                               id="subject" maxlength="140"
                               name="subject" autocomplete="my-subject" required>
                    </div>

                    <div class="form-group">
                        <textarea name="mcontent" id="mcontent" required></textarea>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">@lang('commons.close')</button>
                <button id="msg-send" type="button" style="width: 150px"
                        class="btn btn-lg btn-block btn-signin">@lang('students.inbox.send')</button>
            </div>
        </div>
    </div>
</div>
@push('scripts')
    <script>


        $('#new-msg').on('click', function (event) {

            var msg = '<select name="to" id="to" class="form-control"></select>';
            $('.select-to').html(msg)

            $('#to').select2({
                ajax: {
                    headers: {
                        "Authorization": "{{session()->get("myUser")->token}}",
                    },
                    url: "{!! url('api/student/account/contacts') !!}",
                    dataType: 'json',
                    delay: 250,
                    processResults: function (data) {
                        return {
                            // Select2 requires an id, so we need to map the results and add an ID
                            // You could instead include an id in the tsv you add to soulheart ;)
                            results: data.contacts.map(function (item) {
                                return {
                                    id: (item.hasOwnProperty('es_admin')) ? "1_" + item.id : "0_" + item.id,
                                    text: String(item.nombre).capitalize() + " " + String(item.apellido).capitalize()
                                };
                            }),
                            pagination: {
                                // If there are 10 matches, there's at least another page
                                more: data.contacts.length === 10
                            }
                        };
                    },
                    cache: false
                },
                placeholder: "@lang('students.inbox.recipient')",
                allowClear: false
            })

            $('#subject').val('');
            $("#new-message").modal()

        })

        $('#reply-msg').on('click', function (event) {
            var reply_text = '[Respuesta] ' + $("#inbox-subject").html();
            var reply_val = $('#inbox-reply').val();
            var name = $('#inbox-name').html()
            var reply_contact = '<div class="contact-selected">'+name+'</div>';
            var hidden = '<input id="to" name="to" type="hidden" value="'+reply_val+'">';
            $('.select-to').html(hidden).append(reply_contact);
            $('#subject').val(reply_text);
            $("#new-message").modal()
        })


        CKEDITOR.replace('mcontent', {
            toolbar: [
                {name: 'mode', items: ['Source']},
                {name: 'clipboard', items: ['PasteText', 'Undo', 'Redo']},
                {name: 'links', items: ['Link', 'Unlink', 'Anchor']},
                {name: 'basicstyles', items: ['Bold', 'Italic', 'Subscript', 'Superscript', 'RemoveFormat']},
                {name: 'paragraph', items: ['NumberedList', 'BulletedList']},
                {name: 'tools', items: ['Maximize', 'ShowBlocks']},
            ],
            language: 'es'
        });


        $("#msg-send").on('click', function (event) {
            var to = $('#to').val();
            var destiny = to.split("_");
            var subject = $('#subject').val();
            var content = CKEDITOR.instances.mcontent.getData();
            console.log(destiny)
            axios.put('{!! url('api/student/message') !!}', {
                type: Number(destiny[0]),
                to: Number(destiny[1]),
                subject: subject,
                message: content
            }).then(function (response) {
                $('#new-message').modal('hide');
                showSuccess(response.data.message, 2000)
                $('#subject').val('');
                CKEDITOR.instances.mcontent.setData('');
            }).catch(function (error) {
                showAlert(error.response.data.message)
            });
            event.preventDefault();
        })

    </script>
@endpush