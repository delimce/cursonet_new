@extends('student.layout.app')
@section('title', trans('students.inbox.title'))

@section('content')
    @component("student.components.preloader")
    @endcomponent
    <div class="row home-page">
        <div class="col-md-7 card-border">
            <section>
                <h2>@lang('students.inbox.title')</h2>
                @component("student.components.dataTable")
                    @slot("id")
                        inbox
                    @endslot
                @endcomponent
                <div style="width: 200px; float: right; padding: 20px">
                    <button id="btocontent" class="btn btn-lg btn-block btn-signin" type="button" data-toggle="modal" data-target="#new-message">
                        @lang('students.inbox.compose')
                    </button>
                </div>
            </section>
        </div>
    </div>
    @include('student.pages.lobby.new-message')
@endsection
