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
const quitSession = function (error, url) {
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
const redirect = function (url, back = true) {
    if (back)
        window.location = url
    else location.replace(url)
}

const showAlert = function (message) {
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

const showInfo = function (message) {
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

const showSuccess = function (message, time = false) {
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

const downloadFile = function (response, filename) {
    let url = window.URL.createObjectURL(new Blob([response.data]));
    let link = document.createElement('a');
    link.href = url;
    link.setAttribute('download', filename); //or any other extension
    document.body.appendChild(link);
    link.click();

}

const baseName = function (str) {
    let base = new String(str).substring(str.lastIndexOf('/') + 1);
    if (base.lastIndexOf(".") != -1)
        base = base.substring(0, base.lastIndexOf("."));
    return base;
}

const preload = function () {
    $('#status').fadeOut(); // will first fade out the loading animation
    $('#preloader').delay(350).fadeOut('slow'); // will fade out the white DIV that covers the website.
    $('body').delay(350).css({ 'overflow': 'visible' });
}


const reloadList = function (url, list_id) {
    axios.get(api_url + url)
        .then(function (response) {
            $(list_id).bootstrapTable('removeAll').bootstrapTable('load', {
                data: response.data.list
            });
        }).catch(function (error) {
            console.log(error)
            showAlert(error.response.data.message)
        });
}