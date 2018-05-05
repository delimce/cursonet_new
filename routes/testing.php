<?php

$router->group(['prefix' => 'testing', 'namespace' => 'Testing'], function () use ($router) {
    $router->get('/email', 'TestingController@testEmail');

});