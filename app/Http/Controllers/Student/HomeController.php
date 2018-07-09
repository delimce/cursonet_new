<?php

namespace App\Http\Controllers\Student;

use Laravel\Lumen\Routing\Controller as BaseController;
use Illuminate\Http\Request;
use App\Models\Cn2\Student;
use App\Models\Cn2\Course;
use Validator;

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
        $messages = $this->student->messages()->with("student")->orderBy('id', 'desc')->take(4)->get();

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
        $course->initDate = $course->createdAt();
        $course->author = $course->author();
        $data = array("alias"=>$course->alias,
                      "descripcion"=>$course->descripcion,
                      "id"=>$course->id,
                      "nombre"=>$course->nombre,
                      "init"=>$course->createdAt(),
                      "author"=>$course->author(),
                      "duracion"=>$course->duracion);


        return response()->json(['status' => 'ok', 'course' => $data]);
    }

    public function logout(Request $req)
    {
        $req->session()->flush();
        return redirect()->route('student.login');
    }

    public function getInbox()
    {
        return view("student.pages.lobby.inbox", ["messages" => $this->student->messages()->with('student')->get()]);
    }

    public function myProfile()
    {
        return view("student.pages.lobby.profile", ["data" => $this->student]);
    }

    /**
     * @param Request $req
     * @return mixed
     */
    public function saveMyPicture(Request $req){

        $validator = Validator::make($req->all(), [
            'foto' => 'required',
        ], ['required' => trans('commons.validation.required'),
        ]);

        if ($validator->fails()) {
            $error = $validator->errors()->first();
            return response()->json(['status' => 'error', 'message' => $error], 400);
        }

        $this->student->foto = $req->input('foto');
        $this->student->save();

        return response()->json(['status' => 'ok', 'message' => trans('students.profile.pic.updated')]);

    }


}
