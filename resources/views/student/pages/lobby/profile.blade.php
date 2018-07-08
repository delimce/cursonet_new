@extends('student.layout.app')
@section('title', trans('students.profile.title'))

@section('content')
    <div class="wrapper">
        <div class="cn-container" id="profile-list">
            <form id="form-profile">
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
                                <input type="text" class="form-control" id="apellido" name="apellido"
                                       placeholder="Apellido"
                                       value="{{$data->apellido}}"
                                       autocomplete="my-lastname"
                                       required>
                            </div>
                        </div>

                        <div class="form-group required row">
                            <div class="col-sm-6">
                                <label for="id_number" class="control-label">Cédula</label>
                                <input type="text" class="form-control" id="id_number" name="id_number"
                                       placeholder="Cédula"
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
                                <label for="sexo" class="control-label">Sexo</label>
                                <select id="sexo" name="sexo" class="form-control">
                                    <option value="">@lang("commons.select")</option>
                                    <option @if($data->sexo=="M") selected @endif  value="M">@lang("commons.male")</option>
                                    <option @if($data->sexo=="F") selected @endif value="F">@lang("commons.female")</option>
                                </select>
                            </div>
                            <div class="col-sm-6">
                                <label for="email" class="control-label">Email</label>
                                <input type="email" class="form-control" id="email" name="email" placeholder="Email"
                                       value="{{$data->email}}"
                                       autocomplete="my-email"
                                       required>
                            </div>
                        </div>

                        <div class="form-group required row">
                            <div class="col-sm-6">
                                <label for="telefono">Telefono</label>
                                <input type="text" class="form-control" id="telefono" name="telefono"
                                       placeholder="Telefono"
                                       value="{{$data->telefono_p}}"
                                       autocomplete="telephone">
                            </div>
                        </div>

                        <div style="width: 200px; float: right; padding: 15px">
                            <button id="save" class="btn btn-lg btn-block btn-signin" type="submit">
                                @lang('students.profile.save.info')
                            </button>
                        </div>

                    </div>
                </div>
            </form>
        </div>
        @include('student.pages.lobby.settings')
    </div>
@endsection

@push('scripts')
    <script>
        $('#form-profile').bootstrapValidator().on('success.form.bv', function (e) {
            // Prevent form submission
            e.preventDefault();
            // Get the form instance
            var $form = $(e.target);
            axios.put('{!! url('api/student/account/profile') !!}', $form.serialize())
                .then(function (response) {
                    showSuccess(response.data.message, 2000)
                    $("#save").prop('disabled', false);
                }).catch(function (error) {
                showAlert(error.response.data.message);
                $("#save").prop('disabled', false);
            });

        })
    </script>
@endpush