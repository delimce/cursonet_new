@extends('student.layout.basic')
@section('title', trans('commons.error.404.title'))
@section('content')
    @component("student.components.loginbox")
        @slot('title')
            @lang('commons.error.404.subtitle')
        @endslot

        @slot("info")
            <div style="color: #fff">
                @lang('commons.error.404.message')
                <a href="{!! url("/student") !!}">@lang('commons.go_main')</a>
            </div>
        @endslot
    @endcomponent
@endsection


