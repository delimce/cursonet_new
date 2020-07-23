<?php

namespace App\Http\Controllers\Student;

use App\Models\Cn2\GroupStudent;
use App\Models\Cn2\Forum;
use Laravel\Lumen\Routing\Controller as BaseController;
use Illuminate\Http\Request;
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
        $myGroup = GroupStudent::whereCursoId($course_id)->whereEstId($this->student->id)->first();
        ///student's group_id
        $req->session()->put("groupId", $myGroup->grupo_id);
        $topics = Topic::select('id', 'titulo', 'leido')->whereCursoId($course_id)->whereBorrador(0)->get();
        $content = null;
        $files = null;
        $forums = null;
        if ($topics->count() > 0) { //more than 0
            $content1 = $topics->first();
            Topic::where('id', $content1->id)->update(['leido' => $content1->leido + 1]);
            $content = Topic::findOrFail($content1->id);
            $files = $content->files()->with('File')->get();
            ///forums
            $forums = Forum::whereContenidoId($content1->id)
                ->with(['Group'])->whereIn("grupo_id", [0, $myGroup->grupo_id])->get();

        }
        return view('student.pages.classroom.main', ["topics" => $topics, 'content1' => $content, 'files' => $files, 'forums' => $forums]);
    }


    public function getForumById($forum_id)
    {
        $forum = Forum::findOrFail($forum_id);
        return view('student.pages.classroom.ajax.forum', ["content" => $forum]);
    }

}
