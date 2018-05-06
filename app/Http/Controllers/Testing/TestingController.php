<?php
/**
 * Created by PhpStorm.
 * User: Luis De Lima
 * Date: 05-May-18
 * Time: 6:57 PM
 */

namespace App\Http\Controllers\Testing;

use Laravel\Lumen\Routing\Controller as BaseController;


class TestingController extends BaseController
{

    public function testEmail()
    {
        return  view('student.emails.registered',["token"=>"43234234"]);
    }


}