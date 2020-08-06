@if($total)
<span class="badge badge-warning badge-pill notification-badge">
    {{App\Helpers\ViewHelper::msgNotification($total)}}
</span>
@endif