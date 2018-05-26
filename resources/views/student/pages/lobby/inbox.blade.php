@extends('student.layout.app')
@section('title', trans('students.inbox.title'))

@section('content')
    @component("student.components.preloader")
    @endcomponent
    <div class="wrapper">
        <div id="inbox-list">

            <a href="#" class="readCollapse">
                <i class="plusMinus fas fa-arrow-left"></i>
                <span class="swapText">Ocultar temas</span>
            </a>

            <h2>@lang('students.inbox.title')</h2>
            @component("student.components.dataTable")
                @slot("id")
                    inbox
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
                    <span id="inbox-subject">el asunto del mensaje aqui</span><br>
                </div>
                <div id="inbox-content" class="inbox-read-content">
                    It is a long established fact that a reader will be distracted by the
                    readable content of a page when looking at its layout. The point of using
                    Lorem Ipsum is that it has a more-or-less normal distribution of letters,
                    as opposed to using 'Content here, content here', making it look like readable
                    English. Many desktop publishing packages and web page editors now use Lorem
                    Ipsum as their default model text, and a search for 'lorem ipsum' will uncover
                    many web sites still in their infancy. Various versions have evolved over
                    the years, sometimes by accident, sometimes on purpose (injected humour and the like).
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