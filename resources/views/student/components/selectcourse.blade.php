<span> @lang('students.course.selected') </span>
<div id="nav-selects">
    <select name="course" id="course" class="selectpickerCourse">
        @if(count(session()->get('myCourses'))>0)
            @foreach (session()->get('myCourses') as $course)
                <option value="{{ $course["id"] }}"
                        @if(session()->has("courseSelected") && (session()->get("courseSelected") == $course["id"]))
                        selected @endif>
                    {{ $course["alias"] }}</option>
            @endforeach
        @endif
    </select>
</div>
@push('scripts-ready')
    $('.selectpickerCourse').selectpicker('refresh');
@endpush