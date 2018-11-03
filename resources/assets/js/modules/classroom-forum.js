const switchForumView = function (mode = true) {
    if (mode) {
        let topic = $('.module-item.current-module').data('topic');
        let group = $('.module-item.current-module').data('group');
        reloadList('api/student/class/forum/topic/' + topic + '/group/' + group, '#forum-list')
        $('#forum-wrapper').hide();
        $('#forum-list').show()
    } else {
        $('#forum-wrapper').show();
        $('#forum-list').hide();
    }
};

$('#forum-list').on('click-cell.bs.table', function (field, value, row, $element) {
    axios.request({
        url: api_url + 'student/classroom/forum/' + $element.id,
        method: 'get',
    }).then(function (response) {
        switchForumView(false)
        $('#forum-wrapper').html(response.data)
    }).catch(function (error) {
        showAlert("no es posible cargar el foro")
    });
});

const saveForumPost = function (dataPost) {
    axios.request({
        method: 'post',
        url: api_url + 'api/student/class/forum/post',
        data: dataPost
    }).then(function (response) {
        CKEDITOR.instances.post_content.setData('');
        forumReload(dataPost.forum);
    }).catch(function (error) {
        showAlert(error.response.data.message)
    })
}

const forumReload = function (forum_id) {
    axios.request({
        url: api_url + 'student/classroom/forum/' + forum_id,
        method: 'get',
    }).then(function (response) {
        switchForumView(false)
        $('#forum-wrapper').html(response.data)
        showSuccess("El foro ha sido actualizado!", 900)
    }).catch(function (error) {
        showAlert("no es posible recargar el foro")
    });
}