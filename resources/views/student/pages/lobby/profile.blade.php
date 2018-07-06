@extends('student.layout.app')
@section('title', trans('students.profile.title'))

@section('content')
    <div class="wrapper">
        <div class="cn-container" id="profile-list">

            <div class="row">
                <div class="col-md-11 mx-auto">
                    <h2>@lang('students.profile.personal')</h2>

                    <div class="form-group required row">
                        <div class="col-sm-6">
                            <label for="nombre" class="control-label">Nombre</label>
                            <input type="text" class="form-control" id="nombre" name="nombre" placeholder="Nombre"
                                   value="{{$data->nombre}}"
                                   autocomplete="my-name"
                                   required>
                        </div>
                        <div class="col-sm-6">
                            <label for="apellido" class="control-label">Apellido</label>
                            <input type="text" class="form-control" id="apellido" name="apellido" placeholder="Apellido"
                                   value="{{$data->apellido}}"
                                   autocomplete="my-lastname"
                                   required>
                        </div>
                    </div>

                    <div class="form-group required row">
                        <div class="col-sm-6">
                            <label for="id_number" class="control-label">Cédula</label>
                            <input type="text" class="form-control" id="id_number" name="id_number" placeholder="Cédula"
                                   value="{{$data->id_number}}"
                                   autocomplete="numberid"
                                   required>
                        </div>
                        <div class="col-sm-6">
                            <label for="fecha_nac" class="control-label">Fecha de Nac.</label>
                            <input type="date" class="form-control" id="fecha_nac" name="fecha_nac"
                                   value="{{$data->fecha_nac}}"
                                   autocomplete="birthday"
                                   placeholder="Fecha de Nac."
                                   required>
                        </div>
                    </div>

                    <div class="form-group required row">
                        <div class="col-sm-6">
                            <label for="email" class="control-label">Email</label>
                            <input type="email" class="form-control" id="email" name="email" placeholder="Email"
                                   value="{{$data->email}}"
                                   autocomplete="my-email"
                                   data-bv-identical="true"
                                   data-bv-identical-field="email2"
                                   data-bv-identical-message="el Email no es igual a la confirmación"
                                   required>
                        </div>
                        <div class="col-sm-6">
                            <label for="telephone">Telefono</label>
                            <input type="text" class="form-control" id="telephone" name="telephone"
                                   placeholder="Telefono"
                                   value="{{$data->telefono_p}}"
                                   autocomplete="telephone">
                        </div>
                    </div>


                    <div class="form-group required row">
                        <div class="col-sm-6">
                            <label>Gender</label>
                            <select id="gender" class="form-control">
                                <option value="male">Man</option>
                                <option value="female">Woman</option>
                            </select>
                        </div>

                    </div>

                    <div style="width: 200px; float: right; padding: 15px">
                        <button id="save" class="btn btn-lg btn-block btn-signin" type="button">
                            @lang('students.profile.save.info')
                        </button>
                    </div>

                </div>
            </div>
        </div>
        @include('student.pages.lobby.settings')
    </div>
@endsection