@extends('student.layout.app')
@section('title', trans('students.inbox.title'))

@section('content')
    <div class="wrapper">
        <div class="cn-container" id="inbox-list">
            <h2>@lang('students.inbox.title')</h2>
            <table id="inbox" data-search="true" class="table table-striped cn-grid">
                <thead>
                <tr>
                    <th data-field="id" data-visible="false"></th>
                    <th data-field="nombre" data-sortable="true" scope="col">Nombre</th>
                    <th data-field="asunto" data-sortable="true" scope="col">Mensaje</th>
                    <th data-field="fecha" data-sortable="true" scope="col">Ingreso</th>
                </tr>
                </thead>
                <tbody>
                @foreach($messages as $message)
                    <tr class="@if (!$message->leido) subtext @endif my-inbox">
                        <td>{{$message->id}}</td>
                        <td>{{$message->sender()}}</td>
                        <td>{{$message->subject}}</td>
                        <td>{{$message->datetime()}}</td>
                    </tr>
                @endforeach
                </tbody>
            </table>

            <div style="width: 200px; float: right; padding: 20px">
                <button id="new-msg" class="btn btn-lg btn-block btn-signin" type="button">
                    @lang('students.inbox.compose')
                </button>
            </div>
        </div>

        <div class="cn-container" id="inbox-read">

            <button type="button" class="close to-close readCollapse" aria-label="Close">
                <i class="fas fa-times">&nbsp;</i>
            </button>

            <div class="inbox-content">
                <div style="float: right; width: 25%; margin-left: auto; ">
                    <h1 id="inbox-picture"></h1>
                </div>
                <div style="float: left; width: 60%">
                    <span class="subtext">@lang('commons.name'):</span>
                    <span class="subtext" id="inbox-role"></span>&nbsp;<span id="inbox-name"></span><br>
                    <span class="subtext">@lang('commons.date'):</span>
                    <span id="inbox-date"></span>
                </div>
                <div style="float: left; width: 100%; padding-top: 20px">
                    <span class="subtext">@lang('students.inbox.subject'):</span>
                    <span id="inbox-subject">&nbsp;</span><br>
                </div>
                <div id="inbox-content" class="inbox-read-content">
                    &nbsp;
                </div>
                <input id="inbox-reply" name="inbox-reply" type="hidden">
                <div style="float: right; width: 250px; text-align: right">
                    <button id="delete" data-msg-id="" type="button"
                            class="btn btn-danger">@lang('commons.delete')</button>
                    <button type="button" id="reply-msg" style="width: 100px"
                            class="btn btn-signin">@lang('students.inbox.reply')</button>
                </div>
            </div>
        </div>
    </div>
    @include('student.pages.lobby.new-message')
@endsection

@push('scripts-ready')
    $('#inbox').bootstrapTable();
    $('.readCollapse').on('click', function () {
    $('#inbox-read').hide();
    });
@endpush

@push('scripts')
    <script>
        //behavior
        $('#inbox').on('click-cell.bs.table', function (field, value, row, $element) {
            var me = $(this);
            var msgId = $element.id;
            if (me.hasClass('selected')) {
                me.removeClass('selected');
                $('#inbox-read').hide();
            } else if (msgId != undefined) {
                axios.get('{!! url('api/student/message') !!}/' + msgId
                ).then(function (response) {
                    $('#inbox-read').show();
                    me.removeClass('subtext');
                    console.log(response.data)
                    $("#inbox-subject").html(response.data.message.subject)
                    $("#inbox-content").html(response.data.message.content)
                    $("#inbox-date").html(response.data.message.date)
                    var profile = (!response.data.message.profile) ? '@lang('commons.student')' : '@lang('commons.teacher')';
                    $("#inbox-role").html(profile)
                    var sender = response.data.message.sender;
                    $("#inbox-name").html(sender.nombre + " " + sender.apellido)
                    if (sender.foto != null) {
                        var picture = '<img src="' + sender.foto + '" />';
                        $("#inbox-picture").html(picture)
                    } else {
                        $("#inbox-picture").html('<i class="fas fa-user-circle"></i>');
                    }
                    ///delelete message
                    $('#delete').data('msg-id', msgId); //setter
                    ///reply message
                    $("#inbox-reply").val(response.data.message.profile + "_" + sender.id);
                }).catch(function (error) {
                    quitSession(error, '{!! url('student/logout') !!}');
                });
            }
        });


        $('#delete').confirm({
            title: '@lang('students.inbox.delete')',
            content: '@lang('students.inbox.delete.message')',
            buttons: {
                confirm: function () {
                    var msgId = $('#delete').data("msg-id");
                    axios.delete('{!! url('api/student/message') !!}/' + msgId
                    ).then(function (response) {
                        $('#inbox-read').hide();
                        //todo: refresh msg list


                    }).catch(function (error) {
                        quitSession(error, '{!! url('student/logout') !!}');
                    });
                },
                cancel: function () {
                }
            }
        });

    </script>
@endpush    