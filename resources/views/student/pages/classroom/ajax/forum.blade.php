<div>
    <div class="forum-toolbox">
         <span class="forum-list-back" data-toggle="tooltip" data-placement="bottom"
               title="@lang('students.classroom.forum.showlist')">
        <i class="fas fa-arrow-alt-circle-left"></i>
        </span>

        <span class="forum-list-top" data-toggle="tooltip" data-placement="bottom"
              title="@lang('students.classroom.forum.top')">
        <i class="fas fa-arrow-alt-circle-up"></i>
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
        <span class="in-title">{!! $content->titulo !!}</span>
        <span>{!! $content->content !!}</span>
    </div>

    @foreach($content->getPostsByPersonLikes(session()->get('myUser')->id) as $post)
        <div class="forum-post @if($post->tipo_sujeto=='admin') admin-border @endif">
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

            <div class="post-footer">
                @if($post->tipo_sujeto=='est')
                    <div class="status">
                        <span class="subtext">@lang('students.classroom.forum.post.status')</span>&nbsp;
                        <span>{{$post->statusName()}}</span>
                    </div>
                @endif
                <div class="tools" data-post-id="{{$post->id}}">
                     <span class="forum-tools-msg" data-toggle="tooltip" data-placement="top"
                           title="@lang('students.classroom.forum.post.message')">
                       <i class="far fa-envelope"></i>
                    </span>
                    <span class="forum-tools-reply" data-toggle="tooltip" data-placement="top"
                          title="@lang('students.classroom.forum.post.reply')">
                       <i class="far fa-comment"></i>
                    </span>
                    <span class="forum-tools-like"
                          data-toggle="tooltip" data-placement="top"
                          title="@lang('students.classroom.forum.post.like')">
                        <i class="@if(!is_null($post->opinion)) fas fa-thumbs-up @else far fa-thumbs-up @endif"></i>
                        <span class="nlikes">@if($post->likes>0){{$post->likes}} @endif</span>
                    </span>
                </div>
            </div>

        </div>
    @endforeach

    <div id="new-post">
        <div>
            <span>@lang('students.classroom.forum.post.title')&nbsp;<span
                        class="subtext">{!! $content->titulo !!}</span></span>
            <button type="button" class="close" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
        <div class="content">
            <textarea name="post_content" id="post_content"></textarea>
        </div>
        <div class="footer">
            <button id="save-post" data-forum="{{$content->id}}" data-person="{{session()->get("myUser")->id}}"
                    data-type="est" type="button" style="width: 150px"
                    class="btn btn-lg btn-block btn-signin">
                <span class="glyphicon glyphicon-search"></span>
                @lang('students.classroom.forum.post.save')
            </button>
        </div>
    </div><!-- modal-content -->

</div>

<script>
    (function ($) {
        $('[data-toggle="tooltip"]').tooltip()

        $('.forum-list-back').on('click', function () {
            switchForumView();
        })

        $('.close').on('click', function () {
            $('#new-post').hide();
        })

        $(".forum-list-top").click(function (event) {
            event.preventDefault();
            $("html, body").animate({scrollTop: 0}, 800);
            return false;
        });

        $('.forum-list-post').on('click', function () {
            $('#new-post').show();
            $('#forum-title').html($(".forum-content").find(".in-title").html())
        })

        $('.forum-list-refresh').on('click', function () {
            $(this).tooltip('hide');
            var forum_id = $(this).data("forum");
            forumReload(forum_id);

        })

        ///forum tools
        $('.forum-tools-like').on('click', function () {
            var me = $(this);
            var like = me.find(".nlikes")
            var current = Number(like.html());
            me.tooltip('hide');
            var post_id = me.parent().data('post-id');
            axios.request({
                method: 'put',
                url: '{!! url('api/student/class/forum/post/like') !!}',
                data: {"post": post_id}
            }).then(function (response) {
                $("i", me).toggleClass("far fas");
                current = (Boolean(response.data.message)) ? current + 1 : current - 1;
                current = (current === 0) ? "" : current
                like.html(current)
            }).catch(function (error) {
                showAlert(error.response.data.message)
            })
        })

        $('#save-post').on('click', function () {
            $(this).prop('disabled', true);
            var dataPost = {};
            dataPost.forum = $(this).data("forum");
            dataPost.person = $(this).data("person");
            dataPost.type = $(this).data("type");
            dataPost.content = CKEDITOR.instances.post_content.getData();
            saveForumPost(dataPost);
            $(this).prop('disabled', false);
        })

        CKEDITOR.replace('post_content', {
            width: '100%',
            height: 110,
            toolbar: [
                {name: 'mode', items: ['Source']},
                {name: 'clipboard', items: ['PasteText', 'Undo', 'Redo']},
                {name: 'links', items: ['Link', 'Unlink', 'Anchor']},
                {name: 'basicstyles', items: ['Bold', 'Italic', 'Subscript', 'Superscript', 'RemoveFormat']},
                {name: 'paragraph', items: ['NumberedList', 'BulletedList']},
                {name: 'tools', items: ['Maximize', 'ShowBlocks']},
            ],
            language: 'es'
        });


    }(jQuery));


    var saveForumPost = function (dataPost) {
        axios.request({
            method: 'post',
            url: '{!! url('api/student/class/forum/post') !!}',
            data: dataPost
        }).then(function (response) {
            CKEDITOR.instances.post_content.setData('');
            forumReload(dataPost.forum);
        }).catch(function (error) {
            showAlert(error.response.data.message)
        })
    }

    var forumReload = function (forum_id) {
        axios.request({
            url: '{!! url('student/classroom/forum/') !!}' + '/' + forum_id,
            method: 'get',
        }).then(function (response) {
            switchForumView(false)
            $('#forum-wrapper').html(response.data)
            showSuccess("El foro ha sido actualizado!", 900)
        }).catch(function (error) {
            showAlert("no es posible recargar el foro")
        });
    }

</script>