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
   // $router->get('/', 'InitialController@index');
    $router->get('/login', [
        'as' => 'student.login', 'uses' => 'InitialController@index'
    ]);
    $router->get('/forgotten', 'InitialController@forgotPassword');
    $router->get('/register', 'InitialController@register');
    $router->get('/register/success/{email}', 'InitialController@registerSuccess');
    $router->get('/activate/{apikey}', 'InitialController@userActivated');
    $router->get('/restore/{apikey}', 'InitialController@restoringPassword');
    $router->get('/restoring/success', 'InitialController@restored');
    $router->get('/home', 'HomeController@home');
    $router->post('/select/course', 'HomeController@courseSelected');
    $router->get('/logout', 'HomeController@logout');
    $router->get('/classroom', 'ClassRoomController@main');

    $router->get('profile', [
        'middleware' => 'auth',
        'logout' => 'AccountController@showProfile'
    ]);


});