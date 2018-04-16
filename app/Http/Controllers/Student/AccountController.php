<?php

namespace App\Http\Controllers\Student;

use Laravel\Lumen\Routing\Controller as BaseController;
use Illuminate\Http\Request;
use App\Models\Cn2\Student;

class AccountController extends BaseController
{
    /**
     * Create a new controller instance.
     * @return void
     */
    public function __construct()
    {
        //
    }

    //

    public function index()
    {
       return  view('student.pages.login');
    }
}
