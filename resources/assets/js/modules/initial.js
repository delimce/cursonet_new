
$("#login_form").on("submit", _.throttle(function (e) {
    doLogin(e);
}, 1000))


const doLogin = function (event) {
    axios.post(api_url + 'student/doLogin', {
        email: $("#email").val(),
        password: $("#password").val()
    }).then(function (response) {
        redirect(api_url + 'student/home', false)
    }).catch(function (error) {
        showAlert(error.response.data.message)
    });
    event.preventDefault();
}


$("#forgot_form").on("submit", function (event) {
    $("#bforget").html('Enviando').prop('disabled', true);
    axios.post(api_url + 'api/student/forgotten', {
        email: $("#email").val()
    }).then(function (response) {
        showSuccess(response.data.message, 5000)
        $("#bforget").html('Enviado').prop('disabled', true);
    }).catch(function (error) {
        $("#bforget").html('Reiniciar clave').prop('disabled', false);
        showAlert(error.response.data.message)
    });
    event.preventDefault();
})

$('#register_form').bootstrapValidator().on('success.form.bv', function (e) {
    // Prevent form submission
    $("#bregister").html('Enviando...');
    e.preventDefault();
    // Get the form instance
    let $form = $(e.target);
    axios.post(api_url + 'api/student/signup', $form.serialize())
        .then(function (response) {
            redirect(api_url + "student/register/success/" + $("#email").val(), false)
        }).catch(function (error) {
            console.log(error);
            grecaptcha.reset();
            showAlert(error.response.data.message);
            $("#bregister").html('Registrar').prop('disabled', false);
        });

})