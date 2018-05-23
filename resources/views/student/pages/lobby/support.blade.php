<div class="modal fade" id="support" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle"
     aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h6 class="modal-title" id="exampleModalLongTitle">
                    <i class="fas fa-life-ring"></i>
                    @lang('students.support.title')
                </h6>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form>
                    <div class="form-group">
                        <select class="adv-select-to" name="to" id="to" class="form-control">
                        </select>
                    </div>

                    <div class="form-group">
                        <textarea name="msupport" id="msupport"></textarea>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" style="width: 150px"
                        class="btn btn-lg btn-block btn-signin">
                    <span class="glyphicon glyphicon-search"></span>
                    @lang('students.inbox.send')
                </button>
            </div>
        </div>
    </div>
</div>
@push('scripts')
    <script src="{!! url('bower_components/select2/dist/js/select2.min.js') !!}"></script>
    <script src="{!! url('bower_components/ckeditor/ckeditor.js') !!}"></script>
    <script>
        $('.adv-select-to').select2({
            placeholder: "@lang('students.inbox.recipient')",
            allowClear: false
        })

        CKEDITOR.replace('msupport',  {
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