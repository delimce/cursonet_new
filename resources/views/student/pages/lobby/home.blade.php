@extends('student.layout.app')
@section('title', 'Home')

@section('content')
    <div class="home-page">
        <div class="row">
            <div class="col-md-7 card-border">
                @include('student.pages.lobby.info', ['some' => 'data'])
            </div>
            <div class="col-md-5 card-border">
                @include('student.pages.lobby.wall', ['some' => 'data'])
            </div>
        </div>

        <div class="row">
            <div class="col-md-7 card-border">
                @include('student.pages.lobby.messages', ['some' => 'data'])
            </div>

            <div class="col-md-5 card-border">
                @include('student.pages.lobby.activity', ['some' => 'data'])
            </div>
        </div>
    </div>
@endsection