@extends('student.layout.app')
@section('title', trans('students.inbox.title'))

@section('content')
    <div class="wrapper">
        <div class="cn-container" id="inbox-list">
            <h2>@lang('students.inbox.title')</h2>
            @component("student.components.dataTable")
                @slot("id")
                    inbox
                @endslot
                @slot("head")
                    <tr>
                        <th>Nombre</th>
                        <th>Asunto</th>
                        <th>Fecha</th>
                    </tr>
                @endslot
                @slot("body")
                    @foreach($messages as $message)
                        <tr class="@if (!$message->leido) subtext @endif my-inbox"
                            style="cursor: pointer" data-id="{{$message->id}}">
                            <td>{{$message->sender()}}</td>
                            <td>{{$message->subject}}</td>
                            <td>{{$message->datetime()}}</td>
                        </tr>
                    @endforeach
                @endslot
            @endcomponent
            <div style="width: 200px; float: right; padding: 20px">
                <button id="btocontent" class="btn btn-lg btn-block btn-signin" type="button" data-toggle="modal"
                        data-target="#new-message">
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
                    <h1 id="inbox-picture" style="width: 80px; height: 80px"></h1>
                </div>
                <div style="float: left; width: 60%">
                    <span class="subtext">@lang('commons.name'):</span>
                    <span id="inbox-name"></span><br>
                    <span class="subtext">@lang('commons.profile'):</span>
                    <span id="inbox-role"></span><br>
                    <span class="subtext">@lang('commons.date'):</span>
                    <span id="inbox-date"></span>
                </div>
                <div style="float: left; width: 100%; padding-top: 20px">
                    <span class="subtext">@lang('students.inbox.subject'):</span>
                    <span id="inbox-subject">&nbsp;</span><br>
                </div>
                <div id="inbox-content" class="inbox-read-content">

                </div>
                <div style="float: right; width: 250px; text-align: right">
                    <button id="delete" data-msg-id="" type="button"
                            class="btn btn-danger">@lang('commons.delete')</button>
                    <button type="button" style="width: 100px"
                            class="btn btn-signin">@lang('students.inbox.reply')</button>
                </div>
            </div>
        </div>

    </div>
    @include('student.pages.lobby.new-message')
@endsection

@push('scripts-ready')
    $('.readCollapse').on('click', function () {

    $('#inbox-read').hide();

    });

@endpush

@push('scripts')
    <script>

        $('#inbox tbody').on('click', 'tr', function () {
            var me = $(this);
            var msgId = me.data('id');
            if (me.hasClass('selected')) {
                me.removeClass('selected');
                $('#inbox-read').hide();
            } else if (msgId != undefined) {
                var table = $('#inbox').DataTable();
                table.$('tr.selected').removeClass('selected');
                me.addClass('selected');
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
                    if (sender.foto.length > 5) {
                        var picture = '<img src="' + sender.foto + '" />';
                        $("#inbox-picture").html(picture)
                    } else {
                        $("#inbox-picture").html('<i class="fas fa-user-circle"></i>');
                    }
                    ///delelete message
                    $('#delete').data('msg-id', msgId); //setter
                }).catch(function (error) {
                    quitSession(error, '{!! url('student/logout') !!}');
                });
            }
        })

        $('#delete').confirm({
            title: '@lang('students.inbox.delete')',
            content: '@lang('students.inbox.delete.message')',
            buttons: {
                confirm: function () {
                    var msgId = $('#delete').data("msg-id");
                    axios.delete('{!! url('api/student/message') !!}/' + msgId
                    ).then(function (response) {
                        $('#inbox-read').hide();
                        var table = $('#inbox').DataTable();
                        table.row('.selected').remove().draw(false);
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