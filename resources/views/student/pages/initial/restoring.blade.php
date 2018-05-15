@extends('student.layout.basic')
@section('title', 'Recuperar clave')

@section('content')
    @component("student.components.loginbox")
        @slot("title")
            @lang('students.login.reset_password')
        @endslot

        @slot("form")
            <div class="form-group">
                <label for="nombre" class="control-label">@lang('students.register.name')</label>
                <input type="text" value="{{$user->nombre." ".$user->apellido}}" class="form-control" id="nombre"
                       name="nombre"
                       autocomplete="my-name" readonly>
                <label for="email" class="control-label">@lang('students.email')</label>
                <input type="email" value="{{$user->email}}" class="form-control" id="email" name="email"
                       placeholder="@lang('students.email')"
                       autocomplete="my-email" readonly>
            </div>

            <div class="form-group">
                <input type="password" class="form-control" id="pass" name="pass" autofocus
                       autocomplete="new-pass"
                       data-bv-identical="true"
                       data-bv-identical-field="pass2"
                       data-bv-identical-message="@lang('students.register.password.error.equal')"
                       placeholder="@lang('students.register.new_password')"
                       required>
            </div>

            <div class="form-group">
                <input type="password" class="form-control" id="pass2" name="pass2"
                       autocomplete="new-pass2"
                       data-bv-identical="true"
                       data-bv-identical-field="pass"
                       data-bv-identical-message="@lang('students.register.password.error.equal')"
                       placeholder="@lang('students.register.new_password.repeat')" required>
            </div>
            <button class="btn btn-lg btn-block btn-signin" type="submit">
                @lang('students.login.reset_password')
            </button>
        @endslot
    @endcomponent
@endsection
@push('scripts')
    <script>
        $(document).ready(function () {
            $('#main_form').bootstrapValidator().on('success.form.bv', function (e) {
                // Prevent form submission
                e.preventDefault();
                // Get the form instance
                var $form = $(e.target);
                axios.post('{!! url('api/student/restore') !!}',
                    {
                        token:'{!! $user->token !!}',
                        pass: $("#pass").val()
                    }).then(function (response) {
                    redirect("{!! url('student/restoring/success') !!}", false)
                }).catch(function (error) {
                    console.log(error);
                    showAlert(error.response.data.message);
                });
            })
        });
    </script>
@endpush