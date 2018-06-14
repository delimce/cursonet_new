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

    private $student;

    public function __construct(Request $req)
    {
        $myUser = $req->session()->get("myUser");
        $this->student = Student::findOrFail($myUser->id);
    }

    //

    public function home(Request $req)
    {
        $courses = Course::all();
        $req->session()->put('myCourses', $courses);

        if ($req->session()->has("courseSelected") && !empty($req->session()->get("courseSelected"))) {

            $currentCourse = $courses->filter(function ($value) use ($req) {
                return ($value->id == $req->session()->get("courseSelected"));
            })->first();

        } else { ///one at least
            $currentCourse = $courses->first();
        }

        //get messages
        $messages = $this->student->messages()->orderBy('id', 'desc')->take(4)->get();

        return view('student.pages.lobby.home',
            ["myCourses" => $courses,
                "current" => $currentCourse->toArray(),
                "messages" => $messages]);
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

    public function logout(Request $req)
    {
        $req->session()->flush();
        return redirect()->route('student.login');
    }

    public function getInbox()
    {
        return view("student.pages.lobby.inbox", ["messages" => $this->student->messages()->get()]);
    }


}
