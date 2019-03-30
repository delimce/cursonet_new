import 'bootstrap/dist/js/bootstrap.min';
import 'popper.js';
import 'bootstrap-select-v4/dist/js/bootstrap-select.min'
import 'bootstrap4-notify'

window.api_url = process.env.MIX_API_URL;
global.axios = require('axios');
global.$ = global.jQuery = require('jquery');
window._ = require('lodash'); //lodash library

global.axios.interceptors.request.use(function (config) {
    // spinning start to show
    // UPDATE: Add this code to show global loading indicator
    $('#axios-loader').show();
    return config;
}, function (error) {
    return Promise.reject(error);
});

global.axios.interceptors.response.use(function (response) {
    // spinning hide
    // UPDATE: Add this code to hide global loading indicator
    $('#axios-loader').hide();
    return response;
}, function (error) {
    $('#axios-loader').hide();
    return Promise.reject(error);
});

import fontawesome from '@fortawesome/fontawesome'
import regular from '@fortawesome/fontawesome-free-regular'
import solid from '@fortawesome/fontawesome-free-solid'
import brands from '@fortawesome/fontawesome-free-brands'

fontawesome.library.add(regular)
fontawesome.library.add(solid)
fontawesome.library.add(brands)