<div class="profile-activity clearfix">
    <div id="user-logged">
        <h1><i class="fas fa-user-circle"></i></h1>
        <div id="user-info">
                    <span style="text-transform: capitalize"><b>@lang('commons.student'):</b>&nbsp;
                        <?=$data->nombre?>&nbsp;
                        <?=$data->apellido?>
                    </span>
            <span><a href="{!! url('student/profile') !!}">@lang('students.edit_profile')</a></span>
        </div>
    </div>
</div>