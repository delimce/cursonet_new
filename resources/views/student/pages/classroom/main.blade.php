@extends('student.layout.app')
@section('title', 'Aula Virtual')
@section('content')

    <div class="wrapper">

        <nav id="sidebar">
            @include('student.pages.classroom.modules', ['modules' => [["selected"=>true],["selected"=>false],["selected"=>false]]])
        </nav>

        <!-- Page Content Holder -->
        <div id="content">

            @component("student.components.classroombox")

            @endcomponent

        </div>


    </div>

@endsection
@push('scripts')
    <script type="text/javascript">
        $(document).ready(function () {
            $('#sidebarCollapse').on('click', function () {
                $('#sidebar').toggleClass('active');
                $(this).toggleClass('active');
                $(this).find(".plusMinus").toggleClass('fa-arrow-left fa-arrow-right');
                if($("#sidebar").hasClass('active'))
                    $(".swapText").html("Mostrar temas")
                else
                    $(".swapText").html("Ocultar temas")
            });
        });
    </script>
@endpush
