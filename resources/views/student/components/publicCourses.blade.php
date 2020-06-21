<div>
    @if(count($courses)==0)
        <div>@lang('students.course.new.empty')</div>
    @else
         @foreach($courses as $item)
         <div class="course-item" data-toggle="tooltip" title="@lang("commons.details")" data-id="{{$item["id"]}}">
            <div class="course-icon">
            <div class="title">{{$item["name"]}}</div>
            </div>
         </div>
         @endforeach
    @endif
</div>