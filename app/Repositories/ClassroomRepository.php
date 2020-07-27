<?php

namespace App\Repositories;

use App\Models\Cn2\Forum;
use App\Models\Cn2\GroupStudent;
use App\Models\Cn2\Project;
use App\Models\Cn2\ProjectStudent;
use App\Models\Cn2\Topic;
use Illuminate\Support\Facades\Log;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Support\Facades\DB;
use PDOException;

class ClassroomRepository
{

    /**
     * getTopicsByCourseId
     *
     * @param  int $courseId
     * @return Collection|bool
     */
    public function getTopicsByCourseId($courseId)
    {
        // retrieve active courses
        return Topic::whereCursoId($courseId)->whereBorrador(0)->get();
    }


    /**
     * getGroupByCourseAndStudentId
     *
     * @param  int $courseId
     * @param  int $studentId
     * @return Collect|bool
     */
    public function getGroupByCourseAndStudentId($courseId, $studentId)
    {
        $myGroup = GroupStudent::whereCursoId($courseId)->whereEstId($studentId)->first();
        if (is_null($myGroup)) {
            return false;
        }
        return $myGroup;
    }


    /**
     * getTopicElementsByIdAndStudentId
     * get topics content By id and student's permissions over his group
     * only can see forums, projects etc in groups in where he has been added
     * @param  mixed $topicId
     * @param  mixed $studentId
     * @return array
     */
    public function getTopicElementsByIdAndStudentId($topicId, $studentId)
    {
        $myTopic = Topic::findOrFail($topicId);
        $myTopic->update(['leido' => $myTopic->leido + 1]);
        $myGroup = $this->getGroupByCourseAndStudentId($myTopic->curso_id, $studentId);

        $info['id'] = $myTopic->id;
        $info['title'] = $myTopic->titulo;
        $info['content'] = $myTopic->contenido;
        $info['files'] = $myTopic->files()->with('file')->get();
        $info['forums'] = $this->filterByStudentGroupId($myTopic->forums()->with('group')->get(), $myGroup->grupo_id);
        $info['projects'] = $this->filterByStudentGroupId($myTopic->projects()->with('group')
            ->with(['students' => function ($q) use ($studentId) {
                $q->where('est_id', '=', $studentId);
            }])->get(), $myGroup->grupo_id);

        return $info;
    }


    /**
     * filterByStudentGroupId
     * filter activities by group id if [0 => all groups]
     * @param  Collection $activities
     * @param  int $groupId
     * @return Collection
     */
    private function filterByStudentGroupId(Collection $activities, $groupId)
    {
        return $activities->filter(function ($item) use ($groupId) {
            return in_array($item->group->id ?? 0, [0, $groupId]);
        });
    }


    /**
     * getClassroomForumById
     *
     * @param  int $forumId
     * @return Collection
     */
    public function getForumById($forumId)
    {
        return Forum::findOrFail($forumId);
    }


    /**
     * getClassroomProjectById
     *
     * @param  int $projectId
     * @return Collection
     */
    public function getProjectById($projectId)
    {
        return Project::findOrFail($projectId);
    }


    /**
     * getProjectsByTopicAndStudentId
     *
     * @param  int $topicId
     * @param  int $groupId
     * @param  int $studentId
     * @return Collection
     */
    public function getProjectsByTopicAndStudentId($topicId, $groupId, $studentId)
    {
        $projects = Project::whereContenidoId($topicId)->with(['students' => function ($q) use ($studentId) {
            $q->where('est_id', '=', $studentId);
        }])->get();

        return $this->filterByStudentGroupId($projects, $groupId);
    }


    /**
     * saveStudentProject
     *
     * @param  int $projectId
     * @param  int $studentId
     * @param  array $resource
     * @return void
     */
    public function saveStudentProject($projectId, $studentId, $resource)
    {
        DB::transaction(function () use ($projectId, $studentId, $resource) {
            // new File record created
            $rec = new ResourceRepository();
            $new = $rec->createResource($resource);
            //update or create new 
            ProjectStudent::updateOrCreate(
                ['proy_id' => $projectId, 'est_id' => $studentId],
                ['proy_id' => $projectId, 'est_id' => $studentId, 'rec_id' => $new->id]
            );
            //@todo: if is update delete old resource file (see observer)
        });
    }
}
