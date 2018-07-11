@extends('student.layout.app')
@section('title', trans('students.teachers'))

@section('content')

    <div class="wrapper">
        <div class="subtext" style="padding: 14px">Profesores de los cursos inscritos</div>
        @foreach($data as $teacher)
            <div class="cn-container teacher-box">
                {{$teacher->nombre}}
            </div>
        @endforeach
    </div>
@endsection