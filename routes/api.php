<?php

$router->group(['prefix' => 'api', 'namespace' => 'Api'], function () use ($router) {
    $router->post('/student/login', 'StudentController@login');
    $router->post('/student/signup', 'StudentController@signUp');
    $router->get('/student/email', 'StudentController@testEmail');
    $router->post('/student/email/validate', 'StudentController@emailValidation');
    $router->post('/student/forgotten', 'StudentController@forgotten');
    $router->post('/student/restore', 'StudentController@restorePassword');


});