<?php

namespace App\Http\Controllers\Student;

use Laravel\Lumen\Routing\Controller as BaseController;
use Illuminate\Http\Request;
use App\Models\Cn2\Student;

class InitialController extends BaseController
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
       return  view('student.pages.initial.login');
    }

    public function forgotPassword()
    {
        return  view('student.pages.initial.forgotPassword');
    }

    public function register()
    {
        return  view('student.pages.initial.register');
    }
}
