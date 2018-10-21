'use strict'
/**
 * token of Authorization and Cross Site Request Forgering
 * @type {string | null}
 */
axios.defaults.headers.common['X-CSRF-TOKEN'] = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
axios.defaults.headers.common['Authorization'] = document.querySelector('meta[name="my-token"]').getAttribute('content');
$.fn.selectpicker.Constructor.BootstrapVersion = '4';
$.fn.selectpicker.defaults = {
    iconBase: 'none', // the font family for the checkmark
    tickIcon: 'none', // classname for the checkmark
};
/**
 * if token is invalid, then quit session
 * @param error
 * @param url
 */
let quitSession = function (error, url) {
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
let redirect = function (url, back = true) {
    if (back)
        window.location = url
    else location.replace(url)
}


let showAlert = function (message) {
    $.notify({
        // options
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

let showInfo = function (message) {
    $.notify({
        // options
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

let showSuccess = function (message, time = false) {
    $.notify({
        // options
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

String.prototype.capitalize = function () {
    return this.replace(/(?:^|\s)\S/g, function (a) {
        return a.toUpperCase();
    });
};

let downloadFile = function (response, filename) {
    let url = window.URL.createObjectURL(new Blob([response.data]));
    let link = document.createElement('a');
    link.href = url;
    link.setAttribute('download', filename); //or any other extension
    document.body.appendChild(link);
    link.click();

}