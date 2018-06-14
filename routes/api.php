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
$router->group(['prefix' => 'api/student/message', 'namespace' => 'Api', 'middleware'=>['api']], function () use ($router) {
    $router->get('/{id}', 'MessageController@getMessage');
    $router->delete('/{id}', 'MessageController@deleteMessage');

});