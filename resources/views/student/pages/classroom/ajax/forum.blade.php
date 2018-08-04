<div>
    <div class="forum-toolbox">
         <span class="forum-list-back" data-toggle="tooltip" data-placement="bottom"
               title="@lang('students.classroom.forum.showlist')">
        <i class="fas fa-arrow-alt-circle-left"></i>
    </span>
     <span class="forum-list-refresh" data-toggle="tooltip" data-forum="{{$content->id}}" data-placement="bottom"
              title="@lang('students.classroom.forum.reload')">
        <i class="fas fa-sync-alt"></i>
     </span>
     <span class="forum-list-post" data-toggle="tooltip" data-placement="bottom"
              title="@lang('students.classroom.forum.post.new')">
                <i class="fas fa-edit"></i>
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
                <span class="subtext">Publicado</span>
                <span>{{$post->created_at}}</span><br>
            </div>
            <div class="post">
                {!! $post->content !!}
            </div>

            <div class="tools">
                 <span class="forum-tools-msg" data-toggle="tooltip" data-placement="top"
                       title="@lang('students.classroom.forum.post.message')">
                       <i class="far fa-envelope"></i>
                </span>

                <span class="forum-tools-reply" data-toggle="tooltip" data-placement="top"
                      title="@lang('students.classroom.forum.post.reply')">
                       <i class="far fa-comment"></i>
                </span>
                <span class="forum-tools-like" data-toggle="tooltip" data-placement="top"
                      title="@lang('students.classroom.forum.post.like')">
                        <i class="far fa-thumbs-up"></i>
                </span>

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

        $('.forum-list-refresh').on('click', function () {
            $(this).tooltip('hide');
           var forum_id = $(this).data("forum");
           axios.request({
                url: '{!! url('student/classroom/forum/') !!}' + '/' + forum_id,
                method: 'get',
            }).then(function (response) {
                switchForumView(false)
                $('#forum-wrapper').html(response.data)
                showSuccess("Foro actualizado con éxito!",900)
            }).catch(function (error) {
                showAlert("no es posible recargar el foro")
            });
        })
    }(jQuery));
</script>