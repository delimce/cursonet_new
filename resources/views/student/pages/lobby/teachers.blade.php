@extends('student.layout.app')
@section('title', trans('students.teachers'))

@section('content')
    <div class="wrapper">
        @if(count($data)==0)
            <div class="section-info-text white">@lang('students.teachers.notfound')</div>
        @else
            @foreach($data as $teacher)
                <div class="teacher-box">
                    <div class="card border mb-3" style="max-width: 18rem;">
                        <div class="card-header black">@lang('commons.teacher') 
                            <span id="teacher_{{$teacher->admin->id}}">{{$teacher->admin->nombre}} {{$teacher->admin->apellido}}</span></div>
                        <div class="card-body">
                            <h1>
                                <i class="fas fa-user-circle"></i>
                            </h1>
                            <p class="card-text">{{str_limit($teacher->admin->sintesis,200)}}</p>
                        </div>
                        <div class="card-footer text-muted">
                            <span class="msg-to-teacher" data-toggle="tooltip" data-placement="bottom"
                             title="@lang('students.inbox.teacher.compose')"
                              data-to="{{$teacher->admin->id}}"><i class="fas fa-envelope"></i></span>
                            &nbsp;
                            <span><i class="far fa-calendar-alt"></i></span>
                        </div>
                    </div>
                </div>
            @endforeach
        @endif
    </div>
    @include('student.pages.lobby.new-message')
@endsection