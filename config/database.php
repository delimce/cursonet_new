<?php

return [

    'default' => 'cursonet',

    'connections' => [


        'cursonet' => [
            'driver' => 'mysql',
            'host' => env('DB_HOST', 'localhost'),
            'database' => env('DB_DATABASE', 'cursonet_db'),
            'username' => env('DB_USERNAME', 'root'),
            'password' => env('DB_PASSWORD', ''),
            'charset' => 'utf8',
            'collation' => 'utf8_unicode_ci',
            'prefix' => '',
            'strict' => false,
        ],

        'pgsql' => [
            // ...
        ],

        'sqlsrv' => [
            // ...
        ],

    ],
];
