<section>
    <h2 class="content-home">Bandeja de entrada </h2>

    @foreach ($messages as $item)
        <div class="row @if (!$item->leido) subtext @endif ">
            <div class="col-3">
                <i class="far @if (!$item->leido) fa-envelope @else fa-envelope-open @endif">&nbsp;</i>
                {{$item->datetime()}}
            </div>
            <div class="col-3">
                {{$item->sender()}}
            </div>
            <div class="col-6">
                {{$item->subject}}
            </div>
        </div>
    @endforeach

    @if (count($messages)>0)
        <div style="text-align: right">
            <a href="{!! url('student/inbox') !!}">
                <i class="fas fa-plus-square"></i>
                @lang('students.inbox.all_messages')
            </a>
        </div>
    @else

        <div>
            <h2>@lang('student.inbox.no_messages')</h2>
        </div>

    @endif
</section>