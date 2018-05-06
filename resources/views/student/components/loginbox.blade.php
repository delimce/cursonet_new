<!-- /card-container -->
<div id="login-box" class="card card-container">
    <div class="logo_student">&nbsp;</div>
    @if(isset($info))
        <div class="subtext" style="padding: 10px; color: #fff">
            {{$info}}
        </div>
    @endif
    @if(isset($form))
        <form id="main_form" class="form-signin">
            {{$form}}
        </form>
    @endif
</div>
<!-- /card-container -->