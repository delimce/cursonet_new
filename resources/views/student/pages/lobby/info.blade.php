<section>
    <h2>{{ trans('students.course.info') }}</h2>

    <div>
        <span class="subtext">Nombre del curso:</span>
        <span id="course_name">{{$current["nombre"]}}</span>
    </div>
    <div>
        <span class="subtext">Duración:</span>
        <span id="course_duration">{{$current["duracion"]}}</span>
    </div>
    <div id="course_description">
        {{$current["descripcion"]}}
    </div>

    <div style="float: left; width: 50%">
        <div>
            <span class="subtext">Fecha Inicio:</span>
            <span id="course_initdate">10/11/2018</span>
        </div>
        <div>
            <span class="subtext">Fecha Fin:</span>
            <span id="course_enddate">10/11/2018</span>
        </div>
        <div>
            <span class="subtext">Facilitador:</span>
            <span id="course_professor"><a href="#">Luis De Lima</a></span>
        </div>
    </div>

    @if (!is_null($current["id"]))
    <div id="course_button" style="float: right; width: 50%; padding-top: 20px">
        <div class="col-sm-auto">
            <button id="btocontent" class="btn btn-lg btn-block btn-signin" type="submit">{{ trans('students.course.goto') }}</button>
        </div>
    </div>
    @endif

</section>
@push('scripts')
    <script>
        $("#btocontent").click(function () {
            redirect('{!! url('student/classroom') !!}');
        })
    </script>
@endpush