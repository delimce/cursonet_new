<?php

namespace App\Http\Controllers\Student;

use Laravel\Lumen\Routing\Controller as BaseController;
use Illuminate\Http\Request;
use App\Models\Cn2\Student;

class HomeController extends BaseController
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

    public function home()
    {
       return  view('student.pages.lobby.home');
    }

    public function logout()
    {
        return redirect()->route('student.login');
    }


}
