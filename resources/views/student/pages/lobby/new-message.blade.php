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
                        <select class="adv-select-to" name="to" id="to" class="form-control">
                        </select>
                        <br>
                        <input type="text" placeholder="@lang('students.inbox.subject')" class="form-control"
                               id="subject"
                               name="subject" autocomplete="my-subject" required>
                    </div>

                    <div class="form-group">
                        <textarea name="mcontent" id="mcontent" required></textarea>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">@lang('commons.close')</button>
                <button id="msg-send" type="button" style="width: 150px"  class="btn btn-lg btn-block btn-signin">@lang('students.inbox.send')</button>
            </div>
        </div>
    </div>
</div>
@push('scripts')
    <script>
        $('.adv-select-to').select2({
            ajax: {
                headers: {
                    "Authorization" : "{{session()->get("myUser")->token}}",
                },
                url: "{!! url('api/student/account/contacts') !!}",
                dataType: 'json',
                delay: 250,
                data: function(params) {
                    return {
                        q: params.term,
                        page: params.page,
                        per_page: 10
                    };
                },
                processResults: function(data, page) {
                    return {
                        // Select2 requires an id, so we need to map the results and add an ID
                        // You could instead include an id in the tsv you add to soulheart ;)
                        results: data.contacts.map(function(item) {
                            return {
                                id: item.id,
                                text: String(item.nombre).capitalize()+" "+String(item.apellido).capitalize()
                            };
                        }),
                        pagination: {
                            // If there are 10 matches, there's at least another page
                            more: data.contacts.length === 10
                        }
                    };
                },
                cache: true
            },
            placeholder: "@lang('students.inbox.recipient')",
            allowClear: false
        })

        CKEDITOR.replace('mcontent',  {
            toolbar: [
                { name: 'mode', items : [ 'Source'] },
                { name: 'clipboard', items : [ 'PasteText','Undo','Redo' ] },
                { name: 'links', items: [ 'Link', 'Unlink', 'Anchor' ] },
                { name: 'basicstyles', items : [ 'Bold','Italic','Subscript','Superscript','RemoveFormat' ] },
                { name: 'paragraph', items : [ 'NumberedList','BulletedList'] },
                { name: 'tools', items : [ 'Maximize', 'ShowBlocks' ] },
            ],
            language: 'es'
        });



    </script>
@endpush