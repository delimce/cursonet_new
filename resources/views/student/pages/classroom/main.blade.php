@extends('student.layout.app')
@section('title', 'Aula Virtual')
@section('content')

    <div class="wrapper">

        <nav id="sidebar">
            @include('student.pages.classroom.modules', ['modules' => [["selected"=>true],["selected"=>false],["selected"=>false]]])
        </nav>

        <!-- Page Content Holder -->
        <div id="content">



                        <section class="col-md-12" id="classroom-content">

                            <button type="button" id="sidebarCollapse" class="navbar-btn">
                                <span></span>
                                <span></span>
                                <span></span>
                            </button>

                            <ul class="nav nav-tabs mb-3" id="classroom-tabs" role="tablist">
                                <li class="nav-item">
                                    <a class="nav-link active" id="home-tab" data-toggle="tab" href="#myContent"
                                       role="tab" aria-controls="contenido" aria-selected="true">Contenido</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" id="files-tab" data-toggle="tab" href="#resources" role="tab"
                                       aria-controls="recursos" aria-selected="false">Recursos</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" id="eval-tab" data-toggle="tab" href="#eval" role="tab"
                                       aria-controls="evaluaciones" aria-selected="false">Evaluaciones</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" id="forum-tab" data-toggle="tab" href="#forum" role="tab"
                                       aria-controls="foros" aria-selected="false">Foros</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" id="project-tab" data-toggle="tab" href="#project" role="tab"
                                       aria-controls="proyectos" aria-selected="false">Proyectos</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" id="request-tab" data-toggle="tab" href="#request" role="tab"
                                       aria-controls="consultar" aria-selected="false">Consultas</a>
                                </li>
                            </ul>
                            <div class="tab-content" id="myTabContent">
                                <div class="tab-pane fade show active" id="myContent" role="tabpanel"
                                     aria-labelledby="home-tab">
                                    @include('student.pages.classroom.content', ['some' => 'data'])
                                </div>
                                <div class="tab-pane fade" id="resources" role="tabpanel" aria-labelledby="files-tab">
                                    ...
                                </div>
                                <div class="tab-pane fade" id="eval" role="tabpanel" aria-labelledby="eval-tab">...
                                </div>
                                <div class="tab-pane fade" id="forum" role="tabpanel" aria-labelledby="forum-tab">...
                                </div>
                                <div class="tab-pane fade" id="project" role="tabpanel" aria-labelledby="project-tab">
                                    ...
                                </div>
                                <div class="tab-pane fade" id="request" role="tabpanel" aria-labelledby="request-tab">
                                    ...
                                </div>
                            </div>

                        </section>



        </div>


    </div>

@endsection
@push('scripts')
    <script type="text/javascript">
        $(document).ready(function () {
            $('#sidebarCollapse').on('click', function () {
                $('#sidebar').toggleClass('active');
                  $(this).toggleClass('active');
            });
        });
    </script>
@endpush
