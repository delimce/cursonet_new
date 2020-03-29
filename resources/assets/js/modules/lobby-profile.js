$('#form-profile').bootstrapValidator().on('success.form.bv', function (e) {
    // Prevent form submission
    e.preventDefault();
    // Get the form instance
    let $form = $(e.target);
    axios.put(api_url + 'api/student/account/profile', $form.serialize())
        .then(function (response) {
            showSuccess(response.data.message, 2000)
            $("#save").prop('disabled', false);
            axios.put(api_url + 'student/profile/session') //refresh session data
                .then(function (response) {
                    $("#user-name").html($("#nombre").val());
                    $("#user-lastname").html($("#apellido").val());
                })
        }).catch(function (error) {
        showAlert(error.response.data.message);
        $("#save").prop('disabled', false);
    });

})

$('#upload-profile-img').on('change', function () {
    var reader = new FileReader();
    reader.onload = function (e) {
        $uploadCrop.croppie('bind', {
            url: e.target.result
        }).then(function () {
            console.log('jQuery croppie bind complete');
        });
    }
    reader.readAsDataURL(this.files[0]);
});

$('#save-image').on('click', function (ev) {
    $uploadCrop.croppie('result', {
        type: 'base64',
        format: 'png',
        size: {width: 89, height: 89}
    }).then(function (resp) {
        axios.put(api_url + 'student/profile/picture',
            {"foto": resp})
            .then(function (response) {
                showSuccess(response.data.message, 1500);
                let html = '<img src="' + resp + '" />';
                $("#my-picture").html(html);
                $("#user-picture").html(html);
            }).catch(function (error) {
            showAlert(error.response.data.message);
        });
    });
});

$('.toggle-setting').on('change', function (event) {
    let status = $(this).prop('checked');
    let value = $(this).data('value');
    axios.put(api_url + 'api/student/account/settings', {
        status: status,
        field: value
    }).then(function (response) {
        showSuccess(response.data.message, 2000)
    }).catch(function (error) {
        showAlert(error.response.data.message)
    });
})

$('#form_pass').bootstrapValidator().on('success.form.bv', function (e) {
    // Prevent form submission
    e.preventDefault();
    // Get the form instance
    let $form = $(e.target);
    axios.put(api_url + 'api/student/account/changePass', $form.serialize())
        .then(function (response) {
            showSuccess(response.data.message, 2000)
        }).catch(function (error) {
        showAlert(error.response.data.message);
        $("#savepass").prop('disabled', false);
    });

})