<section>
    <h2>@lang('students.classroom.modules.select')</h2>

    @foreach ($modules as $module)
        <div class="module-item @if ($module["selected"]) current-module @endif">
            <i class="fas fa-book"></i>
            <span class="subtext">@lang('students.classroom.modules.subject') {{$loop->index+1}},</span>
            <span>nombre del tema, puede ser muy largo por aqui</span>
        </div>
    @endforeach

</section>