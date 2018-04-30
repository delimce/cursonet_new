<?php

$router->group(['prefix' => 'api', 'namespace' => 'Api'], function () use ($router) {
    $router->post('/student/login', 'StudentController@login');


});