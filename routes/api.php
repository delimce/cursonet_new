<?php

$router->group(['prefix' => 'api/student', 'namespace' => 'Api'], function () use ($router) {
    $router->post('/login', 'StudentController@login');
    $router->post('/signup', 'StudentController@signUp');
    $router->get('/email', 'StudentController@testEmail');
    $router->post('/email/validate', 'StudentController@emailValidation');
    $router->post('/forgotten', 'StudentController@forgotten');
    $router->post('/restore', 'StudentController@restorePassword');


});