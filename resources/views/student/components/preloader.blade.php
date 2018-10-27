<!-- Preloader -->
<div id="preloader">
    <div id="status">
        <i class="fa fa-spinner fa-pulse"></i>
        @if(isset($text))
            <span>{{$text}}</span>
        @else
            <span>@lang('students.preloader')</span>
        @endif
    </div>
</div>
<!-- Preloader -->
@push('scripts')
    <script>
        $(window).on('load', function () { // makes sure the whole site is loaded
         preload()
        })
    </script>
@endpush