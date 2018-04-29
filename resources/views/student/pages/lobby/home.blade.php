@extends('student.layout.app')
@section('title', 'Home')

@section('content')
    <div class="home-page">
        <div class="row">
            <div class="col-sm-7 card-border">
                <section>
                    <h2>Informacion del Curso</h2>

                    <div>
                        <span class="subtext">Nombre del curso:</span>
                        <span>unknown printer took </span>
                    </div>
                    <div>
                        <span class="subtext">Duracion:</span>
                        <span>3 semanas</span>
                    </div>
                    <div>
                        is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the
                        industry's
                        standard dummy text ever since the 1500s, when an unknown printer took a galley of type and
                        scrambled
                        it to make a type specimen book. It has survived not only five centuries, but also the leap into
                        electronic typesetting
                    </div>

                    <div style="float: left; width: 50%">
                        <div>
                            <span class="subtext">Fecha Inicio:</span>
                            <span>10/11/2018</span>
                        </div>
                        <div>
                            <span class="subtext">Fecha Fin:</span>
                            <span>10/11/2018</span>
                        </div>
                        <div>
                            <span class="subtext">Facilitador:</span>
                            <span><a href="#">Luis De Lima</a></span>
                        </div>
                    </div>

                    <div style="float: right; width: 50%; padding-top: 20px">
                        <div class="col-sm-auto">
                            <button class="btn btn-lg btn-block btn-signin" type="submit">Ir al Curso</button>
                        </div>
                    </div>

                </section>
            </div>
            <div class="col-sm-5 card-border">
                <section>
                    <h2>Informacion General</h2>
                </section>

            </div>
        </div>

        <div class="row">
            <div class="col-sm-7 card-border">
                <section>
                    <h2>Bandeja de entrada</h2>

                    <div class="row">
                        <div class="col-3">
                            <i class="far fa-envelope-open">&nbsp;</i>
                            12/04/2018 03:00PM
                        </div>
                        <div class="col-3">
                            Ros Dangelo
                        </div>
                        <div class="col-6">
                            titulo del mensaje aqui
                        </div>
                    </div>
                    <div class="row subtext">
                        <div class="col-3">
                            <i class="far fa-envelope">&nbsp;</i>
                            12/04/2018 03:00PM
                        </div>
                        <div class="col-3">
                            Ros Dangelo
                        </div>
                        <div class="col-6">
                           otro titulo de mensaje aqui
                        </div>
                    </div>

                    <div style="text-align: right"><a href="#">Ver todos los mensajes</a></div>
                </section>
            </div>

            <div class="col-sm-5 card-border">
                <section>
                    <h2>Actividad reciente</h2>
                    <div class="row">
                        <div class="col-4">
                            <i class="fas fa-pencil-alt">&nbsp;</i>
                            12/04/2018 03:00PM
                        </div>
                          <div class="col-8">
                            examen presentado con exito
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-4">
                            <i class="fab fa-wpforms">&nbsp;</i>
                            12/04/2018 03:00PM
                        </div>
                        <div class="col-8">
                           Archivo de clase 123 descargado con exito
                        </div>
                    </div>
                </section>

            </div>

        </div>
    </div>
@endsection