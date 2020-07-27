
const switchProjectView = function (mode = true) {
    if (mode) {
        let topic = $('.module-item.current-module').data('topic');
        let group = $('.module-item.current-module').data('group');
        reloadList('api/student/class/project/topic/' + topic + '/group/' + group, '#project-list');
        $('#project-container').hide();
        $('#project-list').show();
    } else {
        $('#project-container').show();
        $('#project-list').hide();
    }
};

const deployResource = function (rec) {
    if (Number(rec.type) === 0) {
        axios.request({
            responseType: 'blob',
            url: api_url + 'api/student/class/file' + '/' + rec.id,
            method: 'get',
        }).then(function (response) {
            downloadFile(response, String(rec.dir))
        }).catch(function (error) {
            showAlert("No es posible encontrar el archivo")
        });
    } else {
        window.open(String(rec.dir), '_blank');
    }
}

$('#project-list').on('click-cell.bs.table', function (field, value, row, $element) {
    axios.request({
        url: api_url + 'student/classroom/project/' + $element.id,
        method: 'get',
    }).then(function (response) {
        switchProjectView(false);
        $('#project-container').html(response.data);
    }).catch(function (error) {
        showAlert("no es posible cargar el projecto");
    });
});