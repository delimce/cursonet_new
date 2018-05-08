<div id="nav-selects">
    <select class="adv-select" name="course" id="course">
        <option value="">&nbsp;</option>
        @if(count($courses)>0)
            @foreach ($courses as $course)
                <option value="{{ $course["id"] }}">{{ $course["alias"] }}</option>
            @endforeach
        @endif
    </select>
</div>
@push('scripts')
    <script>
        $('.adv-select').select2({
            placeholder: "Seleccone un curso",
            allowClear: true
        });

        $('#course').on('change', function () {
            console.log(this.value)
            axios.post('{!! url('student/select/course') !!}', {
                courseId: this.value
            }).then(function (response) {
                console.log(response);
                $("#course_name").html(response.data.course.nombre);
                $("#course_duration").html(response.data.course.duracion);
                $("#course_description").html(response.data.course.descripcion);
            }).catch(function (error) {
                showAlert("error al seleccionar el curso")
            });
        })
    </script>
@endpush