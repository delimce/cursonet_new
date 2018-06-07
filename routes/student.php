<?php

/*
|--------------------------------------------------------------------------
| Application Routes
|--------------------------------------------------------------------------
|
| Here is where you can register all of the routes for an application.
| It is a breeze. Simply tell Lumen the URIs it should respond to
| and give it the Closure to call when that URI is requested.
|
*/

$router->get('/', function () use ($router) {
    return $router->app->version();
});

$router->group(['prefix' => 'student', 'namespace' => 'Student'], function () use ($router) {
    $router->get('/login', ['as' => 'student.login', 'uses' => 'InitialController@login']);
    $router->get('/', ['as' => 'student.in', 'uses' => 'InitialController@index']);
    $router->get('/forgotten', 'InitialController@forgotPassword');
    $router->post('/doLogin', 'InitialController@doLogin');
    $router->get('/register', 'InitialController@register');
    $router->get('/register/success/{email}', 'InitialController@registerSuccess');
    $router->get('/activate/{apikey}', 'InitialController@userActivated');
    $router->get('/restore/{apikey}', 'InitialController@restoringPassword');
    $router->get('/restoring/success', 'InitialController@restored');
    $router->get('/classroom', 'ClassRoomController@main');
    $router->get('profile', [
        'middleware' => 'auth',
        'logout' => 'AccountController@showProfile'
    ]);
});

$router->group(['prefix' => 'student', 'namespace' => 'Student'], function () use ($router) {
    $router->get('/home', ['as' => 'student.home', 'uses' => 'HomeController@home']);
    $router->get('/logout', 'HomeController@logout');
    $router->get('/inbox', 'HomeController@getInbox');
    $router->post('/select/course', 'HomeController@courseSelected');
});