'use strict'
/**
 * token of Authorization and Cross Site Request Forgering
 * @type {string | null}
 */
axios.defaults.headers.common['X-CSRF-TOKEN'] = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
axios.defaults.headers.common['Authorization'] = document.querySelector('meta[name="my-token"]').getAttribute('content');

/**
 * if token is invalid, then quit session
 * @param error
 * @param url
 */
var quitSession = function (error, url) {
    if (error.status == 401)
        redirect(url, false)
    else
        showAlert(error.response.data.message)
}

/**
 * redirect to view
 * @param url
 * @param back
 */
var redirect = function (url, back=true) {
    if (back)
        window.location = url
    else location.replace(url)
}


var showAlert = function (message) {
    $.notify({
        // options
        icon: 'fas fa-exclamation-circle',
        title: 'Error:',
        message: message
    }, {
        // settings
        type: 'danger',
        spacing: 10,
        delay: 2000,
        placement: {
            from: "top",
            align: "right"
        },
    });
}

var showInfo = function (message) {
    $.notify({
        // options
        icon: 'fas fa-question-circle',
        title: 'Información:',
        message: message
    }, {
        // settings
        type: 'info',
        spacing: 10,
        delay: 3500,
        placement: {
            from: "bottom",
            align: "right"
        },
    });
}

var showSuccess = function (message, time = false) {
    $.notify({
        // options
        icon: 'fas fa-check-circle',
        message: message
    }, {
        // settings
        type: 'success',
        spacing: 10,
        delay: (!time) ? 1500 : time,
        placement: {
            from: "top",
            align: "center"
        },
    });
}

String.prototype.capitalize = function() {
    return this.replace(/(?:^|\s)\S/g, function(a) { return a.toUpperCase(); });
};