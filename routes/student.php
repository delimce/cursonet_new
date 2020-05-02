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

$router->get(
    '/',
    function () use ($router) {
        return redirect()->route('student.in');
    }
);

$router->group(
    ['prefix' => 'student', 'namespace' => 'Student'],
    function () use ($router) {
        $router->get('/login', ['as' => 'student.login', 'uses' => 'InitialController@login']);
        $router->get('/', ['as' => 'student.in', 'uses' => 'InitialController@index']);
        $router->get('/forgotten', 'InitialController@forgotPassword');
        $router->post('/doLogin', 'InitialController@doLogin');
        $router->get('/register', 'InitialController@register');
        $router->get('/register/success/{email}', 'InitialController@registerSuccess');
        $router->get('/activate/{apikey}', 'InitialController@userActivate');
        $router->get('/activated', ['as' => 'activated', 'uses' => 'InitialController@userActivatedSuccess']);
        $router->get('/restore/{apikey}', 'InitialController@restoringPassword');
        $router->get('/restoring/success', 'InitialController@restored');
        $router->get(
            'profile',
            [
                'middleware' => 'auth',
                'logout'     => 'AccountController@showProfile'
            ]
        );

        //home
        $router->group(
            ['middleware' => ['auth']],
            function () use ($router) {
                $router->get('/home', ['as' => 'student.home', 'uses' => 'HomeController@home']);
                $router->get('/logout', 'HomeController@logout');
                $router->get('/avatar/{student_id}', ['as' => 'student.avatar', 'uses' => 'HomeController@getAvatar']);
                $router->put('/profile/session', 'HomeController@refreshSessionData');
                $router->get('/ratings', 'HomeController@myRatings');
                $router->get('/inbox', 'HomeController@getInbox');
                $router->get('/profile', 'HomeController@myProfile');
                $router->get('/teachers', 'HomeController@getTeachers');
                $router->put('/profile/picture', 'HomeController@saveMyPicture');
                $router->post('/select/course', 'HomeController@courseSelected');

                //classroom
                $router->group(
                    ['prefix' => 'classroom'],
                    function () use ($router) {
                        $router->get('/', 'ClassRoomController@main');
                        $router->get('/forum/{forum_id}', 'ClassRoomController@getForumById');
                    }
                );
            }
        );
    }
);
