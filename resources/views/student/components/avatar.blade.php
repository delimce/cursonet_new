<span id="user-picture">
        @if(Storage::disk('students')->has("avatars/".$data->id.".png"))
        <img src="{{route('student.avatar',['student_id' =>$data->id])}}"/>
    @else
        <h1>
            <i class="fas fa-user-circle est-color"></i>
        </h1>
    @endif
</span>