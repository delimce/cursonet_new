//behavior inbox
$('#inbox').on('click-cell.bs.table', function (field, value, row, $element) {
    let me = $(this);
    let msgId = $element.id;
    if (me.hasClass('selected')) {
        me.removeClass('selected');
        $('#inbox-read').hide();
    } else if (msgId != undefined) {
        axios.get(api_url + 'api/student/message/' + msgId
        ).then(function (response) {
            $('#inbox-read').show();
            me.removeClass('subtext');
            console.log(response.data)
            $("#inbox-subject").html(response.data.message.subject)
            $("#inbox-content").html(response.data.message.content)
            $("#inbox-date").html(response.data.message.date)
            let profile = (!response.data.message.profile) ? 'Est.' : 'Prof.';
            $("#inbox-role").html(profile)
            let sender = response.data.message.sender;
            $("#inbox-name").html(sender.nombre + " " + sender.apellido)
            if (sender.foto != null) {
                let picture = '<img src="' + sender.foto + '" />';
                $("#inbox-picture").html(picture)
            } else {
                $("#inbox-picture").html('<i class="fas fa-user-circle"></i>');
            }
            ///delelete message
            $('#delete-msg').data('msg-id', msgId); //setter
            ///reply message
            $("#inbox-reply").val(response.data.message.profile + "_" + sender.id);
        }).catch(function (error) {
            quitSession(error, api_url + 'student / logout');
        });
    }
});

$('#delete-msg').confirm({
    title: 'Borrar mensaje',
    content: 'Esta seguro de borrar este mensaje?',
    buttons: {
        confirm: function () {
            let msgId = $('#delete-msg').data("msg-id");
            console.log(msgId)
            axios.delete(api_url + 'api/student/message/' + msgId
            ).then(function (response) {
                $('#inbox-read').hide();
                reloadList('api/student/message/all', '#inbox');
            }).catch(function (error) {
                quitSession(error, api_url + 'student / logout');
            });
        },
        cancel: function () {
        }
    }
});

$('#reply-msg').on('click', function (event) {
    let reply_text = '[Respuesta] ' + $("#inbox-subject").html();
    let reply_val = $('#inbox-reply').val();
    let name = $('#inbox-name').html()
    let reply_contact = '<div class="contact-selected">' + name + '</div>';
    let hidden = '<input id="to" name="to" type="hidden" value="' + reply_val + '">';
    $('.select-to').html(hidden).append(reply_contact);
    $('#subject').val(reply_text);
    $("#new-message").modal()
})

$(".msg-to-teacher").on('click', function (event) {
    let myId = $(this).data('to')
    let name = $('#teacher_' + myId).html()
    let reply_contact = '<div class="contact-selected">' + name + '</div>';
    let hidden = '<input id="to" name="to" type="hidden" value="1_' + myId + '">';
    $('.select-to').html(hidden).append(reply_contact);
    $("#new-message").modal()
})

$("#msg-send").on('click', function (event) {
    let to = $('#to').val();
    let destiny = to.split("_");
    let subject = $('#subject').val();
    let content = CKEDITOR.instances.mcontent.getData();
    axios.put(api_url + 'api/student/message', {
        type: Number(destiny[0]),
        to: Number(destiny[1]),
        subject: subject,
        message: content
    }).then(function (response) {
        $('#new-message').modal('hide');
        showSuccess(response.data.message, 2000)
        $('#subject').val('');
        CKEDITOR.instances.mcontent.setData('');
    }).catch(function (error) {
        showAlert(error.response.data.message)
    });
    event.preventDefault();
})


///reload select list
const reloadToSelectBox = function () {
    axios.get(api_url + "api/student/account/contacts")
        .then(function (response) {
            let options = '<option value="">Seleccione</option>';
            let data = response.data.contacts;
            let len = data.length;
            for (let i = 0; i < len; i++) {
                let id = (data[i].es_admin) ? "1_" + data[i].id : "0_" + data[i].id;
                let profile = (data[i].es_admin) ? "Profesor" : "Estudiante";
                let guy = String(data[i].nombre).capitalize() + " " + String(data[i].apellido).capitalize();
                options += '<option data-subtext="' + profile + '" value="' + id + '">' + guy + '</option>';
            }
            $('.selectpickerTo').empty();
            $('.selectpickerTo').append(options);
            $('.selectpickerTo').selectpicker({
                showTick: false,
                showIcon: false
            });

        }).catch(function (error) {
        showAlert(error.response.data.message)
    });
}

$('#new-msg').on('click', function (event) {

    let select = '<select name="to" id="to" data-style="form-select" data-live-search-placeholder="Buscar contacto" data-live-search="true" class="selectpickerTo"  data-width="320px"></select>';
    $('.select-to').html(select)
    reloadToSelectBox();

    $('#subject').val('');
    $("#new-message").modal()

})