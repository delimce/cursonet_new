<section>
    <h2>Bandeja de entrada</h2>

    <div class="row">
        <div class="col-3">
            <i class="far fa-envelope-open">&nbsp;</i>
            12/04/2018 03:00PM
        </div>
        <div class="col-3">
            Ros Dangelo
        </div>
        <div class="col-6">
            titulo del mensaje aqui
        </div>
    </div>
    <div class="row subtext">
        <div class="col-3">
            <i class="far fa-envelope">&nbsp;</i>
            12/04/2018 03:00PM
        </div>
        <div class="col-3">
            Ros Dangelo
        </div>
        <div class="col-6">
            otro titulo de mensaje aqui
        </div>
    </div>

    <div style="text-align: right">
        <a href="{!! url('student/inbox') !!}">
            <i class="fas fa-plus-square"></i>
           @lang('students.inbox.all_messages')
        </a>
    </div>
</section>