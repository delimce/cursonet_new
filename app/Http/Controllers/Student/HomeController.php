<?php

namespace App\Http\Controllers\Student;


use Laravel\Lumen\Routing\Controller as BaseController;
use Illuminate\Http\Request;
use App\Models\Cn2\Student;
use Illuminate\Support\Facades\Storage;
use Validator;
use App\Services\CourseService;
use App\Services\StudentService;
use Exception;
use DB;

class HomeController extends BaseController
{
    /**
     * Create a new controller instance.
     * @return void
     */

    private $student;
    private $courseService;

    public function __construct(Request $req, CourseService $course)
    {
        $myUser = $req->session()->get("myUser");
        $this->courseService = $course;
        $this->student = Student::findOrFail($myUser->id);
    }


    public function home(Request $req)
    {

        $courses = $this->courseService->getCoursesByStudent($this->student->id);
        $req->session()->put('myCourses', $courses);
        if ($req->session()->has("courseSelected") && !empty($req->session()->get("courseSelected"))) {

            $currentCourse = $courses->filter(function ($value) use ($req) {
                return ($value->id === intval($req->session()->get("courseSelected")));
            })->first();
        } else { ///one at least
            $currentCourse = $courses->first();
            if (!is_null($currentCourse)) {
                $req->session()->put("courseSelected", $currentCourse->id);
            }
        }

        //get messages
        $messages = $this->student->messages()->with("student")->orderBy('id', 'desc')->take(4)->get();
        return view(
            'student.pages.lobby.home',
            [
                "myCourses" => $courses,
                "messages" => $messages
            ]
        );
    }


    /**
     * select course method
     * todo: add this method as restful endpoint, for course information object
     * @param Request $req
     * @return mixed
     */
    public function courseSelected(Request $req)
    {
        $courseId = $req->input("courseId");
        $data = $this->courseService->getMainDataByStudent($courseId, $this->student->id);
        $req->session()->put("courseSelected", $data["id"]);
        $req->session()->put("courseName", $data["nombre"]);
        return response()->json(['status' => 'ok', 'course' => $data]);
    }

    public function logout(Request $req)
    {
        $req->session()->flush();
        return redirect()->route('student.login');
    }

    public function myRatings()
    {
        $plans = DB::table('tbl_plan_evaluador')
            ->join('tbl_grupo_estudiante', 'tbl_plan_evaluador.grupo_id', '=', 'tbl_grupo_estudiante.grupo_id')
            ->join('tbl_grupo', 'tbl_grupo.id', '=', 'tbl_grupo_estudiante.grupo_id')
            ->join('tbl_curso', 'tbl_curso.id', '=', 'tbl_grupo.curso_id')
            ->join('tbl_plan_item', 'tbl_plan_evaluador.id', '=', 'tbl_plan_item.plan_id')
            ->groupBy('plan_id')
            ->select('tbl_plan_evaluador.*', 'tbl_grupo.nombre as grupo', 'tbl_curso.alias as curso')
            ->selectRaw('count(tbl_plan_item.id) as items')
            ->whereEstId($this->student->id)
            ->get();



        return view("student.pages.lobby.ratings", ["results" => $plans]);
    }

    public function getInbox()
    {
        $msgs = $this->student->messages()->with('student')->get();
        $sent = $this->student->messagesSent()->with('student')->get();
        return view("student.pages.lobby.msgs", ["messages" => $msgs, "sent" => $sent]);
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
        ], [
            'required' => trans('commons.validation.required'),
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
        $fields = StudentService::FIELDS;
        $user = Student::where('id', $this->student->id)->select($fields)->first();
        $req->session()->put('myUser', $user);
    }


       
    /**
     * getTeachers
     * teachers of course's groups
     * @param  mixed $req
     * @return void
     */
    public function getTeachers(Request $req)
    {
        $teachers = [];
        if ($req->session()->has("courseSelected") && !empty($req->session()->get("courseSelected"))) {

            $courseId = $req->session()->get("courseSelected");
            $teachers = $this->courseService->getAdminsByCourseId($courseId);
        }
        return view("student.pages.lobby.teachers", ["data" => $teachers]);
    }



    public function getPublicCourses()
    {
        $courses = $this->courseService->getPublicCoursesByStudent($this->student->id);
        return view("student.pages.lobby.publics", ["publics"=>$courses]);
    }
}
