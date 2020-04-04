@extends('student.layout.app')
@section('title', trans('students.inbox.title'))

@section('content')
    <div class="wrapper">

        <div class="cn-container" id="inbox-list">
            <ul class="nav nav-tabs" id="nav-tab" role="tablist">
                <li class="nav-item">
                    <a class="nav-link active" id="home-tab" data-toggle="tab" href="#myContent"
                    role="tab" aria-controls="contenido" aria-selected="true">
                        <span class="subtext">@lang('students.inbox.title')</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" id="files-tab" data-toggle="tab" href="#resources" role="tab"
                    aria-controls="recursos" aria-selected="false">
                    <span class="subtext">@lang('students.inbox.sent')</span>
                    </a>
                </li>
            </ul>

            <div class="tab-content" id="myTabContent">
                <div class="tab-pane fade show active" id="myContent" role="tabpanel"
                    aria-labelledby="home-tab">
                    @include('student.pages.lobby.inbox')
                </div>
                <div class="tab-pane fade" id="resources" role="tabpanel" aria-labelledby="files-tab">
                    @include('student.pages.lobby.sent')
                </div>
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
                    <button id="delete-msg" data-msg-id="" type="button"
                            class="btn btn-danger">@lang('commons.delete')</button>
                    <button id="delete-sent" data-msg-id="" type="button"
                            class="btn btn-secondary">@lang('students.inbox.sent.delete')</button>

                    <button type="button" id="reply-msg" style="width: 100px"
                            class="btn btn-primary">@lang('students.inbox.reply')</button>
                </div>
            </div>
        </div>
    </div>
    @include('student.pages.lobby.new-message')
@endsection
@push('scripts')
    <script>
        CKEDITOR.replace('mcontent', {
            toolbar: [
                {name: 'mode', items: ['Source']},
                {name: 'clipboard', items: ['PasteText', 'Undo', 'Redo']},
                {name: 'links', items: ['Link', 'Unlink', 'Anchor']},
                {name: 'basicstyles', items: ['Bold', 'Italic', 'Subscript', 'Superscript', 'RemoveFormat']},
                {name: 'paragraph', items: ['NumberedList', 'BulletedList']},
                {name: 'tools', items: ['Maximize', 'ShowBlocks']},
            ],
            language: 'es'
        });
    </script>
@endpush
@push('scripts-ready')
    $('#inbox').bootstrapTable();
    $('#sent').bootstrapTable();
    $('.readCollapse').on('click', function () {
    $('#inbox-read').hide();
    });
@endpush