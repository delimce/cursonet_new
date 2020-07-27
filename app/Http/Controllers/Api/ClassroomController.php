<?php

namespace App\Http\Controllers\Api;

use App\Decorators\ClassroomDecorator;
use App\Models\Cn2\ForumPost;
use App\Models\Cn2\ForumPostLike;
use App\Models\Cn2\ForumPostReply;
use App\Models\Cn2\Topic;
use App\Models\Cn2\Forum;
use Laravel\Lumen\Routing\Controller as BaseController;
use Illuminate\Http\Request;
use App\Repositories\ClassroomRepository;
use App\Repositories\ResourceRepository;
use App\Repositories\StudentRepository;
use App\Services\ResourceMediaService;
use Exception;
use Validator;

class ClassroomController extends BaseController
{
    private $student;
    private ClassroomRepository $classroomRepository;
    private ResourceRepository $resourceRepository;
    private StudentRepository $studentRepository;


    /**
     * Create a new controller instance.
     * @return void
     */
    public function __construct(
        Request $req,
        ClassroomRepository $classroom,
        ResourceRepository $resource,
        StudentRepository $student
    ) {
        $token         = $req->header('Authorization');
        $this->studentRepository = $student;
        $this->student = $this->studentRepository->getUserByToken($token);
        $this->classroomRepository = $classroom;
        $this->resourceRepository = $resource;
    }


    /**get topics title list
     *
     * @param $course_id
     *
     * @return mixed
     */
    public function getTopics($course_id)
    {
        $topics = Topic::select('id', 'titulo', 'leido')->where("curso_id", $course_id)->where("borrador", 0)->get();
        if ($topics->count() > 0) {
            return response()->json(['status' => 'ok', 'data' => $topics]);
        } else {
            return response()->json(
                ['status' => 'error', 'message' => __('students.classroom.modules.nofound')],
                400
            );
        }
    }


    /**
     * getTopicDataById
     *
     * @param  int $topicId
     * @param  ClassroomDecorator $decorator
     * @return void
     */
    public function getTopicDataById($topicId, ClassroomDecorator $decorator)
    {
        $data = $this->classroomRepository->getTopicElementsByIdAndStudentId($topicId,  $this->student->id);
        $data["files"] = $decorator->resourcesApiList($data["files"]);
        $data["forums"] = $decorator->forumsApiList($data["forums"]);
        $data["projects"] = $decorator->projectsApiList($data["projects"]);
        return response()->json(['status' => 'ok', 'info' => $data]);
    }


    public function getFile($res_id, ResourceMediaService $media)
    {
        try {
            $resource = $this->resourceRepository->getResourceById($res_id);
            //file exist
            if ($resource->tipo == 0 && $media->hasPath($resource->filepath)) {
                $resource->downloads++;
                $resource->save();
                $file = $media->getFromResourcePath($resource->filepath);
                return response()->download($file);
            } else {
                return response()->json(['status' => 'error', 'message' => __('commons.file.notfound')], 404);
            }
        } catch (Exception $ex) {
            return response()->json(['status' => 'error', 'message' => $ex->getTraceAsString()], 500);
        }
    }


    public function saveForumPost(Request $req)
    {
        $validator = Validator::make(
            $req->all(),
            [
                'person'  => 'required',
                'forum'   => 'required',
                'type'    => 'required',
                'content' => 'required',
            ],
            [
                'required' => __('commons.validation.required'),
            ]
        );

        if ($validator->fails()) {
            $error = $validator->errors()->first();

            return response()->json(['status' => 'error', 'message' => $error], 400);
        }

        ///forum post >= 5
        $content = strip_tags($req->content);
        if (strlen($content) < 5) {
            return response()->json(
                ['status' => 'error', 'message' => __('students.classroom.forum.post.tooshort')],
                400
            );
        }

        try {
            $post              = new ForumPost();
            $post->foro_id     = $req->forum;
            $post->sujeto_id   = $req->person;
            $post->tipo_sujeto = $req->type;
            $post->content     = trim($req->content);
            $post->save();

            return response()->json(
                ['status' => 'ok', 'message' => __('students.classroom.forum.post.save.success')]
            );
        } catch (\PDOException $ex) {
            return response()->json(['status' => 'error', 'message' => $ex->getMessage()], 500);
        }
    }


    public function saveForumPostReply(Request $req)
    {
        $validator = Validator::make(
            $req->all(),
            [
                'post'    => 'required|numeric',
                'type'    => 'required',
                'person'  => 'required|numeric',
                'message' => 'required',
            ],
            [
                'required' => __('commons.validation.required.all'),
                'numeric'  => __('commons.validation.numeric'),
            ]
        );

        if ($validator->fails()) {
            $error = $validator->errors()->first();

            return response()->json(['status' => 'error', 'message' => $error], 400);
        }

        try {
            $reply                = new ForumPostReply();
            $reply->comentario_id = $req->post;
            $reply->tipo_sujeto   = $req->type;
            $reply->sujeto_id     = $req->person;
            $reply->content       = $req->message;
            $reply->save();

            return response()->json(
                ['status' => 'ok', 'message' => __('students.classroom.forum.post.reply.save.success')]
            );
        } catch (\PDOException $ex) {
            return response()->json(['status' => 'error', 'message' => $ex->getMessage()], 500);
        }
    }


    /**
     * rating forum post
     */
    public function forumPostLike(Request $req)
    {
        $validator = Validator::make(
            $req->all(),
            [
                'post' => 'required',
            ],
            [
                'required' => __('commons.validation.required'),
            ]
        );

        if ($validator->fails()) {
            $error = $validator->errors()->first();

            return response()->json(['status' => 'error', 'message' => $error], 400);
        }

        $like    = ForumPostLike::whereComentarioId($req->post)
            ->whereTipoSujeto('est')->whereSujetoId($this->student->id)->first();
        $my_like = false;

        if (is_null($like)) {

            try {
                $toLike                = new ForumPostLike();
                $toLike->comentario_id = $req->post;
                $toLike->tipo_sujeto   = 'est';
                $toLike->sujeto_id     = $this->student->id;
                $toLike->save();
                $my_like = true;
            } catch (\PDOException $ex) {
                return response()->json(['status' => 'error', 'message' => $ex->getMessage()], 500);
            }
        } else {
            $like->delete();
        }

        return response()->json(['status' => 'ok', 'message' => $my_like]);
    }


    public function getForumByTopic($topic_id, $group_id)
    {
        $forums = Forum::whereContenidoId($topic_id)
            ->with(['Group', 'posts'])->whereIn("grupo_id", [0, $group_id])->get();

        $list = [];
        $forums->each(
            function ($item) use (&$list) {
                $list[] = [
                    "id"         => $item->id,
                    "titulo"     => $item->titulo,
                    "grupo_desc" => isset($item->group->id) ? $item->group->nombre : __('commons.all'),
                    "posts"      => $item->posts->count(),
                    "fecha_ini"  => $item->dateInit(),
                    "fecha_fin"  => $item->dateEnd(),
                    "status"  => $item->statusName()
                ];
            }
        );

        return response()->json(['status' => 'ok', 'list' => $list]);
    }


    /**
     * getProjectsByTopic
     *
     * @param  int $topic_id
     * @param  int $group_id
     * @param  ClassroomDecorator $decorator
     * @return void
     */
    public function getProjectsByTopic($topic_id, $group_id, ClassroomDecorator $decorator)
    {
        $projects = $this->classroomRepository
            ->getProjectsByTopicAndStudentId($topic_id, $group_id, $this->student->id);
        $list = $decorator->projectsApiList($projects);

        return response()->json(['status' => 'ok', 'list' => $list]);
    }



    public function uploadProject(Request $req, ResourceMediaService $mediaService)
    {
        $validator = Validator::make(
            $req->all(),
            [
                'projectId'    => 'required|numeric',
                'file' => 'required|file',
            ],
            [
                'required' => __('commons.validation.required.all'),
                'numeric'  => __('commons.validation.numeric'),
            ]
        );

        if ($validator->fails()) {
            $error = $validator->errors()->first();
            return response()->json(['status' => 'error', 'message' =>  $error], 400);
        }

        try {
            if ($req->file('file')->isValid()) {
                $data = $mediaService->getMetadata($req->file('file'));
                $data["type"] = 0;
                $data["addBy"] = 'est';
                $data["personId"] = $this->student->id;
                $data["desc"] = __('students.classroom.project.answer');
                $data["path"] = $mediaService->moveToResourcesPath($req->file('file'));
                $this->classroomRepository->saveStudentProject($req->projectId, $this->student->id, $data);
                return response()->json(
                    [
                        'status' => 'ok',
                        'statusname' => __('students.classroom.project.status.answered'),
                        'message' => __('commons.file.upload.successfully')
                    ]
                );
            } else {
                return response()->json(['status' => 'error', 'message' => __('commons.file.upload.error')], 400);
            }
        } catch (Exception $ex) {
            return response()->json(['status' => 'error', 'message' => $ex->getTraceAsString()], 500);
        }
    }
}
