<?php

namespace App\Http\Controllers\Api;

use App\Models\Cn2\Topic;
use Laravel\Lumen\Routing\Controller as BaseController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Mail;
use App\Models\Cn2\Student;
use DB;
use Carbon\Carbon;
use Validator;

class ClassroomController extends BaseController
{
    private $student;

    /**
     * Create a new controller instance.
     * @return void
     */
    public function __construct(Request $req)
    {
        $token = $req->header('Authorization');
        $this->student = Student::where("token", $token)->first();
    }

    /**get topics title list
     * @param $course_id
     * @return mixed
     */
    public function getTopics($course_id)
    {
        $topics = Topic::select('id','titulo','leido')->where("curso_id", $course_id)->where("borrador", 0)->get();
        if ($topics->count()>0) {
            return response()->json(['status' => 'ok', 'data' => $topics]);
        } else {
            return response()->json(['status' => 'error', 'message' => trans('students.classroom.modules.nofound')], 400);
        }
    }


}