<?php

$router->get('/admin', function () use ($router) {
    return $router->app->version();
});