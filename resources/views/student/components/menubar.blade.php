<div class="right-nav">
    @component("student.components.profileInfo",['data' => session()->get("myUser")])
    @endcomponent
    <div class="nav-items">
        <span><a href="{!! url('student/home') !!}">@lang('students.home')</a> </span>|
        <span><a href="{!! url('student/ratings') !!}">@lang('students.my_ratings')</a></span>|
        <span><a href="{!! url('student/inbox') !!}">@lang('commons.messages')
           
            @component("student.components.unreadmsg",['total' => session()->get("unreadMessages")])
            @endcomponent
        </a> 
        </span>|
        <span><a style="color: #00ccff" href="{!! url('student/logout') !!}">@lang('commons.logout')</a></span>
    </div>
</div>