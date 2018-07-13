@extends('student.layout.app')
@section('title', trans('students.teachers'))

@section('content')
    <div class="wrapper">
        @foreach($data as $teacher)
            <div class="teacher-box">
                <div class="card border mb-3" style="max-width: 18rem;">
                    <div class="card-header">@lang('commons.teacher') {{$teacher->nombre}} {{$teacher->apellido}}</div>
                    <div class="card-body">
                        <h1>
                            <i class="fas fa-user-circle"></i>
                        </h1>
                        <p class="card-text">{{$teacher->sintesis}}</p>
                    </div>
                </div>
            </div>

        @endforeach
    </div>
@endsection