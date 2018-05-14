@extends('student.layout.basic')
@section('title', 'Login')

@section('content')
    @component("student.components.loginbox")
        @slot("form")
            <span id="reauth-email" class="reauth-email"></span>
            <input type="email" id="email" class="form-control" placeholder="{{ trans('students.email') }}" required autocomplete="email"
                   autofocus>
            <div id="login-account">
                <span class="forgot-password"><a href="{!! url('student/forgotten') !!} ">{{ trans('students.login.forgotten') }}</a> </span>
            </div>
            <input type="password" id="password" class="form-control" placeholder="{{ trans('students.password') }}"
                   autocomplete="my-password" required>
            <button id="blogin" class="btn btn-lg btn-block btn-signin" type="submit">{{ trans('students.login.login') }}</button>
            @component("student.components.tosignup")
            @endcomponent
        @endslot
    @endcomponent
@endsection
@push('scripts')
    <script>
        $("#main_form").submit(function (event) {

            axios.post('{!! url('api/student/login') !!}', {
                email: $("#email").val(),
                password: $("#password").val()
            }).then(function (response) {
                console.log(response);
                redirect('{!! url('student/home') !!}', false)
            }).catch(function (error) {
                showAlert(error.response.data.message)
            });
            event.preventDefault();
        });
    </script>
@endpush