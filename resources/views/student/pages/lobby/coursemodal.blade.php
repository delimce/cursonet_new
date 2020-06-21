<div class="modal fade" id="course-detail" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle"
     aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h6 class="modal-title" id="exampleModalLongTitle">
                    <i class="fas fa-book"></i>
                    @lang('students.course.info')</h6>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div>
                    <span class="course-title">@lang("students.course.name"):</span>
                    <span id="course-name"></span>
                </div>
                <div>
                    <span class="course-title">@lang("students.course.desc"):</span>
                    <span id="course-desc"></span>
                </div>
                <div>
                    <span class="course-title">@lang("students.course.init"):</span>
                    <span id="course-init"></span>
                </div>
                <div>
                    <span class="course-title">@lang("students.course.topics"):</span>
                    <span id="course-topics"></span>
                </div>
                <div>
                    <span class="course-title">@lang("students.course.author"):</span>
                    <span id="course-author"></span>
                </div>
            </div>
            <div class="modal-footer">
                <button id="enroll-in-course" type="button" class="btn btn-lg btn-primary">
                    @lang('students.course.enroll')
                </button>
            </div>
        </div>
    </div>
</div>