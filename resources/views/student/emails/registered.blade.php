@extends('student.layout.email')
@section('content')
<h2 style="text-align: center">¡Bienvenido a Cursonet!</h2>
    <div style="padding-left: 14px">
        Estas a un solo paso de habilitar tu cuenta. sólo debes acceder al siguiente link:<br>
        <a style="color: #0c5460" href="{!! url("student/activate/") !!}/{{$token}}">Ingresa Aqui</a>
    </div>
@endsection