<?php

namespace App\Http\Controllers\Student;

use Laravel\Lumen\Routing\Controller as BaseController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Validator;
use App\Repositories\CourseRepository;
use App\Repositories\MessageRepository;
use App\Repositories\StudentRepository;
use Exception;

class HomeController extends BaseController
{
    /**
     * Create a new controller instance.
     * @return void
     */

    private $student;
    private $courseRepository;
    private $studentRepository;
    private $messageRepository;

    public function __construct(Request $req, CourseRepository $course, StudentRepository $student, MessageRepository $msg)
    {
        $myUser = $req->session()->get("myUser");
        $this->courseRepository = $course;
        $this->studentRepository = $student;
        $this->messageRepository = $msg;
        $this->student = $this->studentRepository->getStudentById($myUser->id);
    }


    public function home(Request $req)
    {

        $courses = $this->courseRepository->getCoursesByStudent($this->student->id);
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
        $messages = $this->student->messages()->with("student")->orderBy('id', 'desc')->get();

        $unreads = $this->messageRepository->getTotalUnread($messages);
        $req->session()->put("unreadMessages", $unreads);

        return view(
            'student.pages.lobby.home',
            [
                "myCourses" => $courses,
                "messages" => $messages->take(4)
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
        $data = $this->courseRepository->getMainDataByStudent($courseId, $this->student->id);
        $req->session()->put("courseSelected", $data["id"]);
        $req->session()->put("courseName", $data["nombre"]);
        return response()->json(['status' => 'ok', 'course' => $data]);
    }

    public function logout(Request $req)
    {
        $req->session()->flush();
        return redirect()->route('student.login');
    }

    public function myRatings(Request $req)
    {
        $this->refreshSessionData($req);
        $plans = $this->studentRepository->getPlansByStudentId($this->student->id);
        return view("student.pages.lobby.ratings", ["results" => $plans]);
    }

    public function getInbox(Request $req)
    {
        $msgs = $this->student->messages()->with('student')->orderBy('id', 'desc')->get();
        $unreads = $this->messageRepository->getTotalUnread($msgs);
        $req->session()->put("unreadMessages", $unreads);

        $sent = $this->student->messagesSent()->with('student')->get();
        return view("student.pages.lobby.msgs", ["messages" => $msgs, "sent" => $sent]);
    }

    public function myProfile(Request $req)
    {
        $this->refreshSessionData($req);
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
        $user = $this->studentRepository->getStudentById($this->student->id);
        $req->session()->put('myUser', $user);
        $unreads = $this->messageRepository->getTotalUnread($user->messages()->get());
        $req->session()->put("unreadMessages", $unreads);
    }



    /**
     * getTeachers
     * teachers of course's groups
     * @param  mixed $req
     * @return void
     */
    public function getTeachers(Request $req)
    {
        $this->refreshSessionData($req);
        $teachers = [];
        if ($req->session()->has("courseSelected") && !empty($req->session()->get("courseSelected"))) {

            $courseId = $req->session()->get("courseSelected");
            $teachers = $this->courseRepository->getAdminsByCourseId($courseId);
        }
        return view("student.pages.lobby.teachers", ["data" => $teachers]);
    }



    /**
     * getPublicCourses
     * @return void
     */
    public function getPublicCourses(Request $req)
    {
        $this->refreshSessionData($req);
        $courses = $this->courseRepository->getPublicCoursesByStudent($this->student->id);
        return view("student.pages.lobby.publics", ["publics" => $courses]);
    }
}
