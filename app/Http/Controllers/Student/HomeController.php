<?php

namespace App\Http\Controllers\Student;

use App\Models\Cn2\Admin;
use Laravel\Lumen\Routing\Controller as BaseController;
use Illuminate\Http\Request;
use App\Models\Cn2\Student;
use App\Models\Cn2\Course;
use Illuminate\Support\Facades\Storage;
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

        $courses = Course::whereHas('studentGroup', function ($query) {
            $query->whereEstId($this->student->id);
        })->whereActivo(1)->get();

        $req->session()->put('myCourses', $courses);

        if ($req->session()->has("courseSelected") && !empty($req->session()->get("courseSelected"))) {

            $currentCourse = $courses->filter(function ($value) use ($req) {
                return ($value->id == $req->session()->get("courseSelected"));
            })->first();

        } else { ///one at least
            $currentCourse = $courses->first();
            $req->session()->put("courseSelected", $currentCourse->id);
        }

        //get messages
        $messages = $this->student->messages()->with("student")->orderBy('id', 'desc')->take(4)->get();
        ///total topics
        $ntopics = $currentCourse->topics()->count();
        $course1 = $currentCourse->toArray();
        $course1["ntopics"] = $ntopics;

        return view('student.pages.lobby.home',
            ["myCourses" => $courses,
                "current" => $course1,
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
        $ntopics = $course->topics()->count();
        $data = array("alias" => $course->alias,
            "descripcion" => $course->descripcion,
            "id" => $course->id,
            "nombre" => $course->nombre,
            "init" => $course->createdAt(),
            "author" => $course->author(),
            "duracion" => $course->duracion,
            "ntopics" => $ntopics,
        );


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
    public function saveMyPicture(Request $req)
    {

        $validator = Validator::make($req->all(), [
            'foto' => 'required',
        ], ['required' => trans('commons.validation.required'),
        ]);

        if ($validator->fails()) {
            $error = $validator->errors()->first();
            return response()->json(['status' => 'error', 'message' => $error], 400);
        }

        try {
            $this->student->foto = $req->input('foto');
            $this->student->save();
            $image = $req->input('foto');  // your base64 encoded
            $image = str_replace('data:image/png;base64,', '', $image);
            $image = str_replace(' ', '+', $image);
            Storage::disk('students')->put("avatars/{$this->student->id}.png", base64_decode($image));
            return response()->json(['status' => 'ok', 'message' => trans('students.profile.pic.updated')]);
        } catch (Exception $ex) {
            return response()->json(['status' => 'error', 'message' => $ex->getMessage()], 500);
        }


    }

    /**get student's avatar
     * @return mixed
     */
    public function getAvatar($student_id)
    {
        $picture = Storage::disk('students')->get("avatars/{$student_id}.png");
        return response($picture, 200);

    }

    public function refreshSessionData(Request $req)
    {

        $req->session()->forget("myUser");
        $fields = InitialController::$fields;
        $user = Student::where('id', $this->student->id)->select($fields)->first();
        $req->session()->put('myUser', $user);

    }


    /** teachers of course's groups
     * @return mixed
     */
    public function getTeachers()
    {

        $groups = $this->student->groups()->with('group')->get();
        $teacher_array = array();
        $groups->each(function ($value) use (&$teacher_array) {
            $teacher_array[] = $value->group->prof_id;
        });

        ///get teachers
        $teachers = Admin::whereIn('id', $teacher_array)->get();

        return view("student.pages.lobby.teachers", ["data" => $teachers]);
    }


}
