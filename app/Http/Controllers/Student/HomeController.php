<?php

namespace App\Http\Controllers\Student;

use Laravel\Lumen\Routing\Controller as BaseController;
use Illuminate\Http\Request;
use App\Models\Cn2\Student;
use App\Models\Cn2\Course;

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

    public function home(Request $req)
    {
        $courses = Course::all();
        $req->session()->put('myCourses', $courses);

        if ($req->session()->has("courseSelected")) {

            $currentCourse = $courses->filter(function ($value) use ($req) {
                return ($value->id == $req->session()->get("courseSelected"));
            })->first();

        } else if (count($courses) > 0) { ///almost one
            $currentCourse = $courses->first();
        }

        return view('student.pages.lobby.home', ["myCourses" => $courses, "current" => $currentCourse->toArray()]);
    }


    /**
     * select course method
     * @param Request $req
     * @return mixed
     */
    public function courseSelected(Request $req)
    {

        $courseId = $req->input("courseId");
        $req->session()->put("courseSelected", $courseId);
        $course = Course::findOrFail($courseId);
        return response()->json(['status' => 'ok', 'course' => $course]);

    }

    public function logout()
    {
        return redirect()->route('student.login');
    }


}
