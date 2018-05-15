@extends('student.layout.basic')
@section('title', 'Recordar su clave')

@section('content')
    @component("student.components.loginbox")
        @slot("form")
            <input type="email" id="email" class="form-control" placeholder="@lang('students.login.email')" required>
            <button id="bforget" class="btn btn-lg btn-block btn-signin" type="submit">@lang('students.login.reset_password')</button>
            @component("student.components.tosignup")
            @endcomponent
        @endslot
    @endcomponent
@endsection
@push('scripts')
    <script>
        $("#main_form").submit(function (event) {
            $("#bforget").html('@lang('students.sending')').prop('disabled', true);
            axios.post('{!! url('api/student/forgotten') !!}', {
                email: $("#email").val()
            }).then(function (response) {
                showSuccess(response.data.message, 5000)
                $("#bforget").html('@lang('students.login.email_sent')').prop('disabled', true);
            }).catch(function (error) {
                $("#bforget").html('@lang('students.login.reset_password')').prop('disabled', false);
                showAlert(error.response.data.message)
            });
            event.preventDefault();
        });
    </script>
@endpush