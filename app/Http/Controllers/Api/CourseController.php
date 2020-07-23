<?php

namespace App\Http\Controllers\Api;

use Laravel\Lumen\Routing\Controller as BaseController;
use Illuminate\Http\Request;
use App\Repositories\CourseRepository;
use App\Models\Cn2\Student;
use DB;
use Carbon\Carbon;
use Validator;

class CourseController extends BaseController
{

    private $student;
    private $courseService;

    public function __construct(Request $req, CourseRepository $course)
    {
        $token         = $req->header('Authorization');
        $this->student = Student::where("token", $token)->first();
        $this->courseService = $course;
    }

    /**
     * getDetail
     * get course detail
     * @param  int $id
     * @return void
     */
    public function getDetail($id)
    {
        $data = $this->courseService->getCourseById($id);
        if ($data) {
            return response()->json(['status' => 'ok', 'info' => $data]);
        }
        return response()->json(['status' => 'error', 'message' => "not found"], 404);
    }



        
    /**
     * enrollInCourse
     *
     * @param  mixed $req
     * @return void
     */
    public function enrollInCourse(Request $req)
    {
        $validator = Validator::make(
            $req->all(),
            [
                'course'  => 'required',
            ],
            [
                'required' => __('commons.validation.required'),
            ]
        );

        if ($validator->fails()) {
            $error = $validator->errors()->first();
            return response()->json(['status' => 'error', 'message' => $error], 400);
        }

        $courseId = $req->course;
        $studentId = $this->student->id;
        $result = $this->courseService->enrollInCourse($courseId, $studentId);
        if ($result) {
            return response()->json(['status' => 'ok', 'message' => __('students.course.enroll.success')]);
        }
        return response()->json(['status' => 'error', 'message' => "error"], 500);
    }
}
