<div class="profile-activity clearfix">
    <div id="user-logged">
        @component("student.components.avatar",['data' => $data])
        @endcomponent
        <div id="user-info">
            <span style="text-transform: capitalize; display: inline">
                <span style="display: inline" id="user-name"><?=$data->nombre?></span>&nbsp;
                <span style="display: inline" id="user-lastname"><?=$data->apellido?></span>
            </span>
            <span><a href="{!! url('student/profile') !!}">@lang('students.edit_profile')</a></span>
        </div>
    </div>
</div>