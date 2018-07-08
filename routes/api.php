<?php

//initial
$router->group(['prefix' => 'api/student', 'namespace' => 'Api'], function () use ($router) {
    $router->post('/login', 'StudentController@login');
    $router->post('/signup', 'StudentController@signUp');
    $router->get('/email', 'StudentController@testEmail');
    $router->post('/email/validate', 'StudentController@emailValidation');
    $router->post('/forgotten', 'StudentController@forgotten');
    $router->post('/restore', 'StudentController@restorePassword');

});

///messages
$router->group(['prefix' => 'api/student/message', 'namespace' => 'Api', 'middleware' => ['api']], function () use ($router) {
    $router->put('/', 'MessageController@createMessage');
    $router->get('/all', 'MessageController@getMessages');
    $router->get('/{id}', 'MessageController@getMessage');
    $router->delete('/{id}', 'MessageController@deleteMessage');

});

//account
$router->group(['prefix' => 'api/student/account', 'namespace' => 'Api', 'middleware' => ['api']], function () use ($router) {
    $router->get('/contacts', 'AccountController@getContacts');
    $router->put('/settings', 'AccountController@setSetting');
    $router->put('/changePass', 'AccountController@changePassword');
    $router->put('/profile', 'AccountController@saveProfile');
});