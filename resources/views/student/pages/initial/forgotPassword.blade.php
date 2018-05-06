@extends('student.layout.basic')
@section('title', 'Recordar su clave')

@section('content')
    @component("student.components.loginbox")
        @slot("form")
            <input type="email" id="email" class="form-control" placeholder="Email Registrado" required>
            <button id="bforget" class="btn btn-lg btn-block btn-signin" type="submit">Reiniciar mi clave</button>
            @component("student.components.tosignup")
            @endcomponent
        @endslot
    @endcomponent
@endsection
@push('scripts')
    <script>
        $("#main_form").submit(function (event) {
            axios.post('{!! url('api/student/forgotten') !!}', {
                email: $("#email").val()
            }).then(function (response) {
                showSuccess(response.data.message, 5000)
                $('#bforget').prop('disabled', true);
            }).catch(function (error) {
                showAlert(error.response.data.message)
            });
            event.preventDefault();
        });
    </script>
@endpush