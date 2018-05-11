@extends('student.layout.basic')
@section('title', 'Clave restaurada')

@section('content')
    @component("student.components.loginbox")
        @slot("info")
            <div style="color: #fff">
                <div>
                    Su contraseña ha sido restaurada con éxito.
                </div>
                <br>
                <p>
                    <a href="{!! url('student/login') !!} ">Inicia sesión Aquí</a> </span>
                </p>
            </div>
        @endslot
    @endcomponent
@endsection
