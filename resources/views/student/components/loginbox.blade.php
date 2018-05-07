<!-- /card-container -->
<div id="login-box" class="card card-container">
    <div class="logo_student">&nbsp;</div>
    @if(isset($title))
        <div class="subtext" style="padding: 10px; color: #fff">
            {{$title}}
        </div>
    @endif
    @if(isset($info))
        {{$info}}
    @endif
    @if(isset($form))
        <form id="main_form" class="form-signin">
            {{$form}}
        </form>
    @endif
</div>
<!-- /card-container -->