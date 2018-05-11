@extends('student.layout.email')
@section('content')
    <h2 style="text-align: center">Recupera tu clave de usuario en Cursonet</h2>
    <div style="padding-left: 14px">
        Para recuperar la clave de tu cuenta, debes ingresar al siguiente enlace:<br>
        <a style="color: #0c5460" href="{!! url("student/restore/") !!}/{{$token}}">Recuperar mi password aquí</a>
    </div>
@endsection