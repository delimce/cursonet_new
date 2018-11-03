<?php

//***********************ADMIN************************************

///classroom
$router->group(['prefix' => 'api/admin', 'namespace' => 'Api'], function () use ($router) {
    $router->post('/class/file', 'AdminController@saveFileResource');
    $router->get('/file/{res_id}', 'AdminController@openFileResource');
    $router->delete('/file/delete/{res_id}', 'AdminController@deleteFileResource');

});

//***********************STUDENTS************************************

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

//classroom
$router->group(['prefix' => 'api/student/class', 'namespace' => 'Api', 'middleware' => ['api']], function () use ($router) {
      $router->get('/file/{res_id}', 'ClassroomController@getFile');

     //topic
    $router->group(['prefix' => '/topic'], function () use ($router) {
        $router->get('/all/{course_id}', 'ClassroomController@getTopics');
        $router->get('/{topic_id}', 'ClassroomController@getTopicInfo');
        $router->get('/{topic_id}/group/{group_id}', 'ClassroomController@getTopicInfo');
    });

    ///forum
    $router->group(['prefix' => '/forum'], function () use ($router) {
        $router->post('/post', 'ClassroomController@saveForumPost');
        $router->get('/topic/{topic_id}/group/{group_id}', 'ClassroomController@getForumByTopic');
        $router->put('/post/like', 'ClassroomController@forumPostLike');
    });

});