@extends('student.layout.app')
@section('title', trans('students.profile.title'))
@section('content')
    <div class="wrapper">
        <div class="cn-container" id="profile-list">
            <nav>
                <div class="nav nav-tabs" id="nav-tab" role="tablist">
                    <a class="nav-item nav-link active" id="nav-info-tab" data-toggle="tab" href="#nav-info" role="tab"
                       aria-controls="nav-info" aria-selected="true">
                        <span class="subtext">@lang('students.profile.personal')</span>
                    </a>
                    <a class="nav-item nav-link" id="nav-pic-tab" data-toggle="tab" href="#nav-pic" role="tab"
                       aria-controls="nav-pic" aria-selected="false">
                        <span class="subtext">@lang('students.profile.pic')</span>
                    </a>
                </div>
            </nav>
            <div class="tab-content" id="nav-tabContent">
                <div class="tab-pane fade show active" id="nav-info" role="tabpanel" aria-labelledby="nav-info-tab">
                    <form id="form-profile" style="margin-top: 17px;">
                        <div class="row">
                            <div class="col-md-11 mx-auto">
                                <div class="form-group required row">
                                    <div class="col-sm-6">
                                        <label for="nombre" class="control-label">Nombre</label>
                                        <input type="text" class="form-control" id="nombre" name="nombre"
                                               placeholder="Nombre"
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
                                            <option @if($data->sexo=="M") selected
                                                    @endif  value="M">@lang("commons.male")</option>
                                            <option @if($data->sexo=="F") selected
                                                    @endif value="F">@lang("commons.female")</option>
                                        </select>
                                    </div>
                                    <div class="col-sm-6">
                                        <label for="email" class="control-label">Email</label>
                                        <input type="email" class="form-control" id="email" name="email"
                                               placeholder="Email"
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

                                <div style="width: 250px; float: right; padding: 15px">
                                    <button id="save" class="btn btn-lg btn-block btn-primary" type="submit">
                                        @lang('students.profile.save.info')
                                    </button>
                                </div>

                            </div>
                        </div>
                    </form>
                </div>
                <div class="tab-pane fade" id="nav-pic" role="tabpanel" aria-labelledby="nav-pic-tab">
                    <div class="pic-container">
                        <div class="row" style="padding-left: 25px">
                            <span>
                                <div id="my-picture">
                                    @if($data->foto)
                                        <img src="{!! $data->foto !!}"/>
                                    @else
                                        <h1><i class="fas fa-user-circle"></i></h1>
                                    @endif

                                </div>
                                Imagen Actual
                            </span>
                        </div>
                        <div class="row">
                            <div style="padding:10px; margin: auto">
                                <strong> @lang('students.profile.pic.select'):</strong>
                                <br/>
                                <input id="upload-profile-img" data-toggle="tooltip" data-placement="top" title="@lang('students.profile.pic.select')" type="file">
                            </div>
                            <div id="upload-img"></div>
                        </div>
                        <div class="row" style="width: 200px; margin: auto">
                            <button id="save-image" class="btn btn-lg btn-block btn-primary" type="button">
                                @lang('students.profile.pic.save')
                            </button>
                        </div>

                    </div>
                </div>
            </div>
        </div>
        @include('student.pages.lobby.settings',["data"=> $data])
    </div>
@endsection

@push('scripts')
    <script>
        $uploadCrop = $('#upload-img').croppie({
            enableExif: true,
            viewport: {
                width: 200,
                height: 200,
                type: 'circle'
            },
            boundary: {
                width: 300,
                height: 300
            }
        });
    </script>
@endpush