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
            $('#status').fadeOut(); // will first fade out the loading animation
            $('#preloader').delay(350).fadeOut('slow'); // will fade out the white DIV that covers the website.
            $('body').delay(350).css({'overflow': 'visible'});
        })
    </script>
@endpush