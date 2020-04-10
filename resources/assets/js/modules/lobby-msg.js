//behavior inbox
$("#inbox").on("click-cell.bs.table", function(field, value, row, $element) {
  let me = $(this);
  let msgId = $element.id;
  if (me.hasClass("selected")) {
    me.removeClass("selected");
    $("#inbox-read").hide();
  } else if (msgId != undefined) {
    axios
      .get(api_url + "api/student/message/" + msgId)
      .then(function(response) {
        showContentMessage(response);
        $("#reply-msg").show();
        $("#delete-msg").show();
        $("#delete-sent").hide();
        ///delelete message
        $("#delete-msg").data("msg-id", msgId); //setter
        ///reply message
        let sender = response.data.message.sender;
        let reply = response.data.message.profile + "_" + sender.id;
        $("#inbox-reply").val(reply);
      })
      .catch(function(error) {
        quitSession(error, api_url + "student / logout");
      });
  }
});

$("#delete-msg").confirm({
  title: "Borrar mensaje",
  content: "Esta seguro de borrar este mensaje?",
  buttons: {
    confirm: function() {
      let msgId = $("#delete-msg").data("msg-id");
      console.log(msgId);
      axios
        .delete(api_url + "api/student/message/" + msgId)
        .then(function(response) {
          $("#inbox-read").hide();
          reloadList("api/student/message/all", "#inbox");
        })
        .catch(function(error) {
          quitSession(error, api_url + "student / logout");
        });
    },
    cancel: function() {}
  }
});

$("#delete-sent").confirm({
  title: "Borrar mensaje Enviado",
  content: "Esta seguro de borrar este mensaje?",
  buttons: {
    confirm: function() {
      let msgId = $("#delete-sent").data("msg-id");
      axios
        .delete(api_url + "api/student/message/sent/" + msgId)
        .then(function(response) {
          $("#inbox-read").hide();
          reloadList("api/student/message/sent/all", "#sent");
        })
        .catch(function(error) {
          quitSession(error, api_url + "student / logout");
        });
    },
    cancel: function() {}
  }
});

$("#reply-msg").on("click", function(event) {
  let reply_text = "[Respuesta] " + $("#inbox-subject").html();
  let reply_val = $("#inbox-reply").val();
  let name = $("#inbox-name").html();
  let reply_contact = '<div class="contact-selected">' + name + "</div>";
  let hidden =
    '<input id="to" name="to" type="hidden" value="' + reply_val + '">';
  $(".select-to")
    .html(hidden)
    .append(reply_contact);
  $("#subject").val(reply_text);
  $("#new-message").modal();
});

$(".msg-to-teacher").on("click", function(event) {
  let myId = $(this).data("to");
  let name = $("#teacher_" + myId).html();
  let reply_contact = '<div class="contact-selected">' + name + "</div>";
  let hidden = '<input id="to" name="to" type="hidden" value="1_' + myId + '">';
  console.log(myId)
  $(".select-to")
    .html(hidden)
    .append(reply_contact);
  $("#new-message").modal();
});

$("#msg-send").on("click", function(event) {
  let to = $("#to").val();
  let destiny = to.split("_");
  let subject = $("#subject").val();
  let content = CKEDITOR.instances.mcontent.getData();
  axios
    .put(api_url + "api/student/message", {
      type: Number(destiny[0]),
      to: Number(destiny[1]),
      subject: subject,
      message: content
    })
    .then(function(response) {
      $("#new-message").modal("hide");
      showSuccess(response.data.message, 2000);
      reloadList("api/student/message/sent/all", "#sent");
      $("#subject").val("");
      CKEDITOR.instances.mcontent.setData("");
    })
    .catch(function(error) {
      showAlert(error.response.data.message);
    });
  event.preventDefault();
});

///reload select list
const reloadToSelectBox = function() {
  axios
    .get(api_url + "api/student/account/contacts")
    .then(function(response) {
      let options = '<option value="">Seleccione</option>';
      let data = response.data.contacts;
      _.each(data, function(item) {
        let isTeacher = _.has(item, "es_admin");
        let id = isTeacher ? "1_" + item.id : "0_" + item.id;
        let profile = isTeacher ? "Profesor" : "Estudiante";
        let guy =
          String(item.nombre).capitalize() +
          " " +
          String(item.apellido).capitalize();
        options +=
          '<option data-subtext="' +
          profile +
          '" value="' +
          id +
          '">' +
          guy +
          "</option>";
      });

      $(".selectpickerTo").empty();
      $(".selectpickerTo").append(options);
      $(".selectpickerTo").selectpicker({
        showTick: false,
        showIcon: false
      });
    })
    .catch(function(error) {
      showAlert(error.response.data.message);
    });
};

$("#new-msg").on("click", function(event) {
  let select =
    '<select name="to" id="to" data-style="form-select" data-live-search-placeholder="Buscar contacto" data-live-search="true" class="selectpickerTo"  data-width="320px"></select>';
  $(".select-to").html(select);
  reloadToSelectBox();

  $("#subject").val("");
  $("#new-message").modal();
});

//behavior sent
$("#sent").on("click-cell.bs.table", function(field, value, row, $element) {
  let me = $(this);
  let msgId = $element.id;
  if (me.hasClass("selected")) {
    me.removeClass("selected");
    $("#inbox-read").hide();
  } else if (msgId != undefined) {
    axios
      .get(api_url + "api/student/message/sent/" + msgId)
      .then(function(response) {
        showContentMessage(response);
        $("#reply-msg").hide();
        $("#delete-msg").hide();
        $("#delete-sent").show();
        ///delelete message
        $("#delete-sent").data("msg-id", msgId); //setter
      })
      .catch(function(error) {
        quitSession(error, api_url + "student / logout");
      });
  }
});

/**
 * function
 */
const showContentMessage = function(response) {
  $("#inbox-read").show();
  $("#inbox-subject").html(response.data.message.subject);
  $("#inbox-content").html(response.data.message.content);
  $("#inbox-date").html(response.data.message.date);
  let profile = !response.data.message.profile ? "Est." : "Prof.";
  $("#inbox-role").html(profile);
  let sender = response.data.message.sender;
  $("#inbox-name").html(sender.nombre + " " + sender.apellido);
  if (sender.foto != null) {
    let picture = '<img id="user-img" src="' + sender.foto + '" />';
    $("#inbox-picture").html(picture);
  } else {
    $("#inbox-picture").html('<i class="fas fa-user-circle"></i>');
  }
  $("#user-img").on("error", function() {
    $("#inbox-picture").html('<i class="fas fa-user-circle"></i>');
  });
};
