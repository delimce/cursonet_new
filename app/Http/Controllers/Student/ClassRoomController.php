<?php

namespace App\Http\Controllers\Student;

use Laravel\Lumen\Routing\Controller as BaseController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Session;
use App\Models\Cn2\Student;

class ClassRoomController extends BaseController
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

    public function main(Request $req)
    {
        $courses = $req->session()->get('myCourses');
        return view('student.pages.classroom.main', ["myCourses" => $courses]);
    }

}
