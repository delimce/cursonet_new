@push('head')
    <link rel="stylesheet" href="{!! url('bower_components/jquery-confirm2/css/jquery-confirm.css') !!}">
    <script src="{!! url('bower_components/jquery-confirm2/js/jquery-confirm.js') !!}"></script>
@endpush
<button id="{{$id}}" type="button" class="btn btn-danger">@lang('commons.delete')</button>

@push('scripts')
<script>
    $('#{{$id}}').confirm({
        title: '{{$title}}',
        content: '{{$content}}',
        buttons: {
            confirm: function () {
                {{$function}}
            },
            cancel:  function () {
            }
        }
    });
</script>
@endpush