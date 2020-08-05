<?php

namespace App\Http\Controllers\Student;

use App\Repositories\ClassroomRepository;
use Laravel\Lumen\Routing\Controller as BaseController;
use Illuminate\Http\Request;
use App\Repositories\StudentRepository;

class ClassRoomController extends BaseController
{
    private  $student;
    private  $classroomRepository;
    private  $studentRepository;

    /**
     * Create a new controller instance.
     * @return void
     */
    public function __construct(
        Request $req,
        ClassroomRepository $classroom,
        StudentRepository $student
    ) {
        $myUser = $req->session()->get("myUser");
        $this->classroomRepository = $classroom;
        $this->studentRepository = $student;
        $this->student = $this->studentRepository->getStudentById($myUser->id);
    }


    public function main(Request $req)
    {
        $course_id = $req->session()->get('courseSelected');
        $myGroup = $this->classroomRepository->getGroupByCourseAndStudentId($course_id, $this->student->id);
        $req->session()->put("groupId", $myGroup->grupo_id);
        $topics = $this->classroomRepository->getTopicsByCourseId($course_id);
        $firstTopic = $topics->first();
        $topicData = $this->classroomRepository->getTopicElementsByIdAndStudentId($firstTopic->id, $this->student->id);
        return view('student.pages.classroom.main', [
            "topics" => $topics,
            'title' => $topicData['title'],
            'content' => $topicData['content'],
            'files' => $topicData['files'],
            'forums' => $topicData['forums'],
            'projects' => $topicData['projects'],
        ]);
    }


    public function getForumById($forum_id)
    {
        $forum = $this->classroomRepository->getForumById($forum_id);
        return view('student.pages.classroom.ajax.forum', ["content" => $forum]);
    }

    public function getProjectById($project_id)
    {
        $project = $this->classroomRepository->getProjectById($project_id);
        return view('student.pages.classroom.ajax.project', ["content" => $project]);
    }
}
