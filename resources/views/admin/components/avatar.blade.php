<span id="user-picture">
    @if($data->img)
        <img src="{!!$data->img!!}"/>
    @else
        <h1>
            <i class="fas fa-user-circle admin-color"></i>
        </h1>
    @endif
</span>