<div>
    <div class="project-content">
        <div class="project-list-back">
            <p>
             <a href="#">@lang('students.classroom.project.showlist')</a>
            </p>
          </div>
          <span class="in-title">{!! $content->nombre !!}</span>
          <span id="project-info" data-id="{{$content->id}}">{!! $content->enunciado !!}</span>

          @if($content->resources->count())
            <div class="project-files">
                <span>@lang('students.classroom.project.attachments')</span>
                    @foreach($content->resources()->get() as $resource)
                        <div class="project-file"
                            title="Abrir recurso"
                            data-id="{{$resource->file->id}}"
                            data-type="{{$resource->file->tipo}}"
                            data-dir="{{$resource->file->dir}}">
                            {{$resource->file->descripcion}} [{{$resource->file->getType()}}]  
                        </div>
                    @endforeach 
            </div>
          @endif

          <hr>
          <div class="project-fields">
            <div>
                <span class="field-title">@lang('students.classroom.project.date_init')</span>
                <span>{{$content->dateInit()}}</span>
              </div>
              <div>
                <span class="field-title">@lang('students.classroom.project.date_end')</span>
                <span class="date-end">{{$content->dateEnd()}}</span>
              </div>
              <div>
                <span class="field-title">@lang('students.classroom.project.status')</span>
                <span class="field-status">{{$content->statusName()}}</span>
              </div>
          </div> 
          
          @if($content->status()===$content::STATUS_PENDING)
            <div id="upload-project" class="dropzone">
              <div class="dz-default dz-message">
                  @lang('students.classroom.project.upload')<br>
                <p><i class="fa fa-upload"></i></p>
              </div>
            </div>
          @endif   
          
    </div>   
</div>

<script>
    (function($) {
  
      $('.project-list-back').on('click', function() {
        switchProjectView();
      });

      $('.project-file').on('click', function() {
        let resource = {};
        resource.id = $(this).data("id");
        resource.dir = $(this).data("dir");
        resource.type = $(this).data("type");
        deployResource(resource);
    });


    Dropzone.autoDiscover = false;
    $("#upload-project").dropzone({
        url: api_url + "api/student/class/project/upload",
        headers: {
            Authorization: document.querySelector('meta[name="my-token"]').getAttribute("content"),
        },
        params: {
         projectId: $("#project-info").data("id")
        },
        addRemoveLinks: true,
        maxFilesize: 5, //MB
        maxFiles: 1,
        success: function (file, response) {
          showSuccess(response.message);
          $('.field-status').html(response.statusname);
        },
        error: function (file, response) {
          showAlert(error.response.data.message);
        }
    });
    
      
    }(jQuery));
  
</script>