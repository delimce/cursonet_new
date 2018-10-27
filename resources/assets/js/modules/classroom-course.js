$('#course').on('changed.bs.select', function (e, clickedIndex, isSelected, previousValue) {
    // do something...
    axios.post(api_url + 'student/select/course', {
        courseId: this.value
    }).then(function (response) {
        let current = baseName($(location).attr('href'));
        if (current === "home") {
            $("#course_name").html(response.data.course.nombre);
            $("#course_duration").html(response.data.course.duracion);
            $("#course_description").html(response.data.course.descripcion);
            $("#course_initdate").html(response.data.course.init);
            $("#course_ntopics").html(response.data.course.ntopics);
            if (response.data.course.ntopics > 0) {
                $("#course_button").show();
            } else {
                $("#course_button").hide();
            }
        } else {
            redirect(api_url + 'student/home', false)
        }

    }).catch(function (error) {
        showAlert("Error al seleccionar el curso")
        $("#course_button").hide();
    });
});

$('#file-list').on('click-cell.bs.table', function (field, value, row, $element) {
    if (Number($element.tipo_id) === 0) {
        axios.request({
            responseType: 'blob',
            url: api_url + 'api/student/class/file' + '/' + $element.id,
            method: 'get',
        }).then(function (response) {
            downloadFile(response, String($element.dir))
        }).catch(function (error) {
            showAlert("No es posible encontrar el archivo")
        });
    } else {
        window.open(String($element.dir), '_blank');
    }
});

$('.module-item').on('click', function (event) {
    let topic_id = $(this).data('topic');
    let group_id = $(this).data('group');
    $(".current-module").removeClass("current-module")
    $(this).addClass("current-module");
    axios.get(api_url + 'api/student/class/topic' + '/' + topic_id + '/group/' + group_id)
        .then(function (response) {
            $('#myContent').html(response.data.info.contenido)
            $('#topic-selected').html(response.data.info.titulo)
            $('#file-list').bootstrapTable('load', {
                data: response.data.info.files
            });

            switchForumView();
            $('#forum-list').bootstrapTable('load', {
                data: response.data.info.forums
            });

        }).catch(function (error) {
        showAlert("error al seleccionar el curso");
    });
})