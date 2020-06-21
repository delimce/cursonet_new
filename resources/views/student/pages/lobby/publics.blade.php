@extends('student.layout.app')
@section('title', trans('students.public_courses'))

@section('content')
<div class="wrapper">
    <div class="cn-container publics">
    <div class="in-title">
        @lang('students.available_courses')
    </div>
    @component("student.components.publicCourses",["courses"=>$publics])
    @endcomponent
    </div>
</div>

@include('student.pages.lobby.coursemodal')
@endsection


