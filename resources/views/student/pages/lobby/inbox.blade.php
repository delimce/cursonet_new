@extends('student.layout.app')
@section('title', trans('students.inbox.title'))

@section('content')
    @component("student.components.preloader")
    @endcomponent
    <div class="wrapper">
        <div id="inbox-list">

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
                        <tr  class="@if (!$message->leido) subtext @endif my-inbox"
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

        <div id="inbox-read">

            <button type="button" class="close to-close readCollapse" aria-label="Close">
                <i class="fas fa-times">&nbsp;</i>
            </button>

            <div class="inbox-content">
                <div style="float: right; width: 25%; margin-left: auto; ">
                    <h1><i class="fas fa-user-circle"></i></h1>
                </div>
                <div style="float: left; width: 60%">
                    <span class="subtext">Nombre:</span>
                    <span id="inbox-name">Luis De Lima</span><br>
                    <span class="subtext">Perfil:</span>
                    <span id="inbox-role">Estudiante</span><br>
                    <span class="subtext">Fecha:</span>
                    <span id="inbox-date">10/10/2018 02:00pm</span>
                </div>
                <div style="float: left; width: 100%; padding-top: 20px">
                    <span class="subtext">Asunto:</span>
                    <span id="inbox-subject">&nbsp;</span><br>
                </div>
                <div id="inbox-content" class="inbox-read-content">

                </div>
                <div style="float: right; width: 250px; text-align: right">
                    <button type="button" class="btn btn-danger">@lang('commons.delete')</button>
                    <button type="button" style="width: 100px" class="btn btn-signin">
                        @lang('students.inbox.reply')
                    </button>
                </div>
            </div>
        </div>

    </div>
    @include('student.pages.lobby.new-message')
@endsection
@push('scripts-ready')
    $('.readCollapse').on('click', function () {

    $('#inbox-read').toggleClass('active');

    });
@endpush

@push('scripts')
    <script>
        $('.my-inbox').on('click',function (event) {
            var me = $(this);
            var msgId = me.data('id');
            axios.get('{!! url('api/student/message') !!}/'+msgId,
                {headers: {
                        "Authorization" : "{!! session()->get("myUser")->token !!}"
                    }
                }
            ).then(function (response) {
                $('#inbox-read').toggleClass('active');
                console.log(response.data)
                $("#inbox-subject").html(response.data.message.subject)
                $("#inbox-content").html(response.data.message.content)
                $("#inbox-date").html(response.data.message.date)
                var profile = (!response.data.message.profile)?'@lang('commons.student')':'@lang('commons.teacher')';
                $("#inbox-role").html(profile)
                $("#inbox-name").html(response.data.message.sender.nombre+" "+response.data.message.sender.apellido)

            }).catch(function (error) {
                showAlert(error.response.data.message)
            });
        })
    </script>
@endpush    