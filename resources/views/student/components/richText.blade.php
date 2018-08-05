<div class="rich-text">
    <textarea name="{{$id}}" id="{{$id}}"></textarea>
</div>
@push('scripts')
    <script>
        var editor_height = {{ !isset($height) ? 200 : $height }}
        CKEDITOR.replace('{{$id}}', {
            width: '100%',
            height: editor_height,
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
    </script>
@endpush