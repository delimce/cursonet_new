<section>
    <h2 class="content-home">Bandeja de entrada </h2>

    @foreach ($messages as $item)
        <div class="row @if (!$item->leido) subtext @endif ">
            <div class="col-2.2">
                <i class="far @if (!$item->leido) fa-envelope @else fa-envelope-open @endif">&nbsp;</i>
                {{$item->datetime()}}
            </div>
            <div class="col-3.2">
                {{$item->sender()}}
            </div>
            <div class="col-5">
                {{$item->subject}}
            </div>
        </div>
    @endforeach

    @if (count($messages)>0)
        <div style="text-align: right">
            <a data-toggle="tooltip" data-placement="top" title="@lang('students.inbox.title.tooltip')"  href="{!! url('student/inbox') !!}">
                <i class="fas fa-plus-square"></i>
                @lang('students.inbox.all_messages')
            </a>
        </div>
    @else

        <div>
            @lang('students.inbox.no_messages')
        </div>

    @endif
</section>