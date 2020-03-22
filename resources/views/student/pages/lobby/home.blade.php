@extends('student.layout.app')
@section('title', trans('students.home'))

@section('content')

    @component("student.components.preloader")
    @endcomponent
    <div class="home-page">

            <div class="row justify-content-md-center">
                    <div class="col col-home">
                                @if(session()->has('courseSelected'))
                                    <div class="col card-border">
                                        @include('student.pages.lobby.course')
                                    </div> 
                                @endif
                            
                                <div class="col card-border">
                                    @include('student.pages.lobby.messages', ['messages' => $messages])
                                </div>
                    </div>
                    <div class="col col-home">
                                <div class="col card-border">
                                    @include('student.pages.lobby.wall')
                                </div>
                    
                                {{-- <div class="colcard-border">
                                    @include('student.pages.lobby.activity', ['some' => 'data'])
                                </div> --}}
                    </div>
                  </div>
    </div>
@endsection

@if(session()->has('courseSelected'))
    @push('scripts-ready')
        loadCourseInformation($('.selectpickerCourse').val())
    @endpush
@endif     