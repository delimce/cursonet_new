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