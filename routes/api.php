<?php

//***********************ADMIN************************************

///classroom
$router->group(
    ['prefix' => 'api/admin', 'namespace' => 'Api', 'middleware' => ['cors']],
    function () use ($router) {
        $router->post('/class/file', 'AdminController@saveFileResource');
        $router->get('/file/{res_id}', 'AdminController@openFileResource');
        $router->delete('/file/delete/{res_id}', 'AdminController@deleteFileResource');
    }
);

//***********************STUDENTS************************************

//initial
$router->group(
    ['prefix' => 'api/student', 'namespace' => 'Api'],
    function () use ($router) {
        $router->post('/login', 'StudentController@login');
        $router->post('/signup', 'StudentController@signUp');
        $router->get('/email', 'StudentController@testEmail');
        $router->post('/email/validate', 'StudentController@emailValidation');
        $router->post('/forgotten', 'StudentController@forgotten');
        $router->post('/restore', 'StudentController@restorePassword');

        $router->group(
            ['middleware' => ['api']],
            function () use ($router) {
                ///messages
                $router->group(
                    ['prefix' => 'message'],
                    function () use ($router) {
                        $router->put('/', 'MessageController@createMessage');
                        $router->get('/all', 'MessageController@getMessages');
                        $router->get('/{id}', 'MessageController@getMessage');
                        $router->delete('/{id}', 'MessageController@deleteMessage');
                    }
                );
                ///messages sent
                $router->group(
                    ['prefix' => 'message/sent'],
                    function () use ($router) {
                        $router->get('/all', 'MessageController@getMessagesSent');
                        $router->get('/{id}', 'MessageController@getMessageSent');
                        $router->delete('/{id}', 'MessageController@deleteMessageSent');
                    }
                );
                //account
                $router->group(
                    ['prefix' => 'account'],
                    function () use ($router) {
                        $router->get('/contacts', 'AccountController@getContacts');
                        $router->put('/settings', 'AccountController@setSetting');
                        $router->put('/changePass', 'AccountController@changePassword');
                        $router->put('/profile', 'AccountController@saveProfile');
                        $router->post('/support', 'AccountController@sendSupportMessage');
                    }
                );
                //ratings
                $router->group(
                    ['prefix' => 'ratings'],
                    function () use ($router) {
                        $router->get('/', 'RatingsController@list');
                        $router->get('/{planId}', 'RatingsController@getDetail');
                    }
                );

                //course
                $router->group(
                    ['prefix' => 'course'],
                    function () use ($router) {
                        $router->get('/{id}', 'CourseController@getDetail');
                        $router->post('/enroll', 'CourseController@enrollInCourse');
                    }
                );

                //classroom
                $router->group(
                    ['prefix' => 'class'],
                    function () use ($router) {
                        $router->get('/file/{res_id}', 'ClassroomController@getFile');

                        //topic
                        $router->group(
                            ['prefix' => '/topic'],
                            function () use ($router) {
                                $router->get('/all/{course_id}', 'ClassroomController@getTopics');
                                $router->get('/{topicId}', 'ClassroomController@getTopicDataById');
                            }
                        );

                        ///forum
                        $router->group(
                            ['prefix' => '/forum'],
                            function () use ($router) {
                                $router->post('/post', 'ClassroomController@saveForumPost');
                                $router->get('/topic/{topic_id}/group/{group_id}', 'ClassroomController@getForumByTopic');
                                $router->put('/post/like', 'ClassroomController@forumPostLike');
                                $router->put('/post/reply', 'ClassroomController@saveForumPostReply');
                            }
                        );

                        ///projects
                        $router->group(
                            ['prefix' => '/project'],
                            function () use ($router) {
                                $router->get('/{project_id}', 'ClassroomController@getProjectById');
                                $router->get('/topic/{topic_id}/group/{group_id}', 'ClassroomController@getProjectsByTopic');
                                $router->post('/upload/','ClassroomController@uploadProject');
                            }
                        );
                    }
                );
            }
        );
    }
);
