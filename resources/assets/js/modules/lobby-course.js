$(".course-item").on("click", function (event) {
    let courseId = $(this).data("id");
    if (courseId != undefined) {
        axios
            .get(api_url + "api/student/course/" + courseId)
            .then(function (response) {
                let data = response.data.info;
                $("#course-name").html(data.name);
                $("#course-desc").html(data.desc);
                $("#course-init").html(data.init);
                $("#course-topics").html(data.ntopics);
                $("#course-author").html(data.author);

                $("#enroll-in-course").data("course", data.id);
                $("#course-detail").modal();
            })
            .catch(function (error) {
                showAlert(error.response.data.message);
            });
    }
});

$("#enroll-in-course").on("click", _.debounce(function (event) {
    let courseId = $(this).data("course");
    axios
        .post(api_url + "api/student/course/enroll/",
            { "course": courseId })
        .then(function (response) {
            showSuccess(response.data.message, 1000);
            setTimeout(function () {
                redirect(api_url + 'student/home', false);
            }, 2500);

        }).catch(function (error) {
            showAlert(error.response.data.message);
        });
}, 250));