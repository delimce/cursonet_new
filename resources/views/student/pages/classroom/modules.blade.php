<section>
    <h2>@lang('students.classroom.modules.select')</h2>
    @if($topics->count()==0)
        <span>@lang('students.classroom.modules.nofound')</span>
    @else
        @foreach ($topics as $i => $module)
            <div class="module-item @if ($i==0) current-module @endif" data-topic="{{$module->id}}">
                <span>{{$i+1}}.&nbsp;{{$module->titulo}}</span>
            </div>
        @endforeach
    @endif
</section>

@push('scripts')
    <script>
        $('.module-item').on('click', function (event) {
            var topic_id = $(this).data('topic');
            $(".current-module").removeClass("current-module")
            $(this).addClass("current-module");
            axios.get('{!! url('api/student/class/topic') !!}' + '/' + topic_id)
                .then(function (response) {
                    console.log(response)
                    $('#myContent').html(response.data.info.contenido)
                    $('#topic-selected').html(response.data.info.titulo)
                }).catch(function (error) {
                showAlert("@lang('students.course.selected.error')")
                $("#course_button").hide();
            });
        })
    </script>
@endpush