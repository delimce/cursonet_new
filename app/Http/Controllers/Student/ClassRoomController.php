<?php

namespace App\Http\Controllers\Student;

use Laravel\Lumen\Routing\Controller as BaseController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Session;
use App\Models\Cn2\Student;
use App\Models\Cn2\Topic;

class ClassRoomController extends BaseController
{
    private $student;
    /**
     * Create a new controller instance.
     * @return void
     */
    public function __construct(Request $req)
    {
        $myUser = $req->session()->get("myUser");
        $this->student = Student::findOrFail($myUser->id);
    }

    //
    public function main(Request $req)
    {
        $course_id = $req->session()->get('courseSelected');
        $topics = Topic::select('id', 'titulo', 'leido')->where("curso_id", $course_id)->where("borrador", 0)->get();
        $content = null;
        if ($topics->count() > 0) { //more than 0
            $content1 = $topics->first();
            Topic::where('id', $content1->id)->update(['leido' => $content1->leido + 1]);
            $content = Topic::findOrFail($content1->id);
        }
        return view('student.pages.classroom.main', ["topics" => $topics, 'content1' => $content]);
    }

}
