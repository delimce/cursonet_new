<div>
    <div class="forum-toolbox">
         <span class="forum-list-back" data-toggle="tooltip" data-placement="bottom"
               title="@lang('students.classroom.forum.showlist')">
        <i class="fas fa-arrow-alt-circle-left"></i>
    </span>
        <span class="forum-list-refresh" data-toggle="tooltip" data-placement="bottom"
              title="@lang('students.classroom.forum.reload')">
        <i class="fas fa-sync-alt"></i>
        </span>
        <span class="forum-list-post" data-toggle="tooltip" data-placement="bottom"
              title="@lang('students.classroom.forum.post.new')">
                <i class="fas fa-pen-square"></i>
            </span>
    </div>
    <div class="forum-content">
        <h2>{!! $content->titulo !!}</h2>
        <span>{!! $content->content !!}</span>
    </div>

    @foreach($content->posts()->get() as $post)
        <div class="forum-post">
            <div class="student-data">
             <?php $person = $post->person()->first() ?>
             @component("student.components.avatar",['data' => $person])
             @endcomponent
                <span class="subtext">Nombre:</span>
                <span>{{$person->nombre.' '.$person->apellido }}</span><br>
                <span class="subtext">Perfil</span>   
                <span>{{$post->tipo_sujeto}}</span><br>
            </div>
            <div class="post">
                {!! $post->content !!}
            </div>
        </div>
    @endforeach

</div>

<script>
    (function ($) {
        $('[data-toggle="tooltip"]').tooltip()
        $('.forum-list-back').on('click', function () {
            switchForumView();
        })
    }(jQuery));
</script>