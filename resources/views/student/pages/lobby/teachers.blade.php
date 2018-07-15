@extends('student.layout.app')
@section('title', trans('students.teachers'))

@section('content')
    <div class="wrapper">
        @foreach($data as $teacher)
            <div class="teacher-box">
                <div class="card border mb-3" style="max-width: 18rem;">
                    <div class="card-header">@lang('commons.teacher') <span
                                id="teacher_{{$teacher->id}}">{{$teacher->nombre}} {{$teacher->apellido}}</span></div>
                    <div class="card-body">
                        <h1>
                            <i class="fas fa-user-circle"></i>
                        </h1>
                        <p class="card-text">{{$teacher->sintesis}}</p>
                    </div>
                    <div class="card-footer text-muted">
                        <span class="msg-to-teacher" data-toggle="tooltip" data-placement="bottom" title="@lang('students.inbox.teacher.compose')" data-to="{{$teacher->id}}"><i class="fas fa-envelope"></i></span>
                        &nbsp;
                        <span><i class="far fa-calendar-alt"></i></span>
                    </div>
                </div>
            </div>

        @endforeach
    </div>
    @include('student.pages.lobby.new-message')
@endsection