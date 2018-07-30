<section>
    <h2>{{ trans('students.course.info') }}</h2>

    <div>
        <span class="subtext">@lang('students.course.name'):</span>
        <span id="course_name">{{$current["nombre"]}}</span>
    </div>
    <div>
        <span class="subtext">@lang('students.course.long'):</span>
        <span id="course_duration">{{$current["duracion"]}}</span>
    </div>
    <div id="course_description">
        {{$current["descripcion"]}}
    </div>

    <div style="float: left; width: 50%">
        <div>
            <span class="subtext">Fecha creado:</span>
            <span id="course_initdate">10/11/2018</span>
        </div>
        <div>
            <span class="subtext">n# de temas:</span>
            <span id="course_ntopics">{{$current["ntopics"]}}</span>
        </div>
        <div>
            <span class="subtext">Facilitador:</span>
            <span id="course_professor"><a href="#">Luis De Lima</a></span>
        </div>
    </div>

    <div id="course_button" style="float: right; width: 50%; padding-top: 20px;
    @if (intval($current["ntopics"])==0) display:none @endif">
        <div class="col-sm-auto">
            <button id="btocontent" class="btn btn-lg btn-block btn-signin"
                    type="submit">@lang('students.course.goto')</button>
        </div>
    </div>

</section>
@push('scripts')
    <script>
        $("#btocontent").click(function () {
            redirect('{!! url('student/classroom') !!}');
        })
    </script>
@endpush