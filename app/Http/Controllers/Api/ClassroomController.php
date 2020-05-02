<?php

namespace App\Http\Controllers\Api;

use App\Models\Cn2\File;
use App\Models\Cn2\ForumPost;
use App\Models\Cn2\ForumPostLike;
use App\Models\Cn2\ForumPostReply;
use App\Models\Cn2\Topic;
use App\Models\Cn2\Forum;
use Laravel\Lumen\Routing\Controller as BaseController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Facades\Storage;
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
        $token         = $req->header('Authorization');
        $this->student = Student::where("token", $token)->first();
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
                ['status' => 'error', 'message' => __('students.classroom.modules.nofound')], 400
            );
        }
    }


    /**get whole topic info
     *
     * @param $topic_id
     * @param $group_id
     *
     * @return mixed
     */
    public function getTopicInfo($topic_id, $group_id = false)
    {
        $info  = Topic::findOrFail($topic_id);
        $files = $info->files()->with('File')->get();
        if ($group_id) {
            $forums = Forum::whereContenidoId($info->id)
                           ->with('Group')->whereIn("grupo_id", [0, $group_id])->get();
        } else {
            $forums = $info->forums()->with('Group')->get();
        }
        $info->leido++;
        $info->save();
        $data = ["id" => $info->id, "titulo" => $info->titulo, "contenido" => $info->contenido];
        ///files
        $resources = [];
        $files->each(
            function ($item) use (&$resources) {
                $temp            = [];
                $temp["tipo"]    = $item->file->getType();
                $temp["tipo_id"] = $item->file->tipo;
                $temp["id"]      = $item->file->id;
                $temp["dir"]     = $item->file->dir;
                $temp["fecha"]   = $item->file->date();
                $resources[]     = $temp;
            }
        );
        $data["files"] = $resources;
        ///forums
        $infoForums = [];
        $forums->each(
        /**
         * @param $item
         */
            function ($item) use (&$infoForums) {
                $temp               = [];
                $temp["id"]         = $item->id;
                $temp["titulo"]     = $item->titulo;
                $temp["grupo_id"]   = $item->grupo_id;
                $temp["grupo_desc"] = $item->group->nombre ?? __('commons.all');
                $temp["posts"]      = $item->posts->count();
                $temp["fecha_ini"]  = $item->dateInit();
                $temp["fecha_fin"]  = $item->dateEnd();
                $infoForums[]       = $temp;
            }
        );
        $data["forums"] = $infoForums;

        return response()->json(['status' => 'ok', 'info' => $data]);

    }


    public function getFile($res_id)
    {
        try {
            $resource = File::findOrFail($res_id);
            //file exist
            if ($resource->tipo == 0 && Storage::disk('courses')->has($resource->filepath)) {
                $resource->downloads++;
                $resource->save();
                $file = Storage::disk('courses')->url($resource->filepath);

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
            $req->all(), [
            'person'  => 'required',
            'forum'   => 'required',
            'type'    => 'required',
            'content' => 'required',
        ], [
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
                ['status' => 'error', 'message' => __('students.classroom.forum.post.tooshort')], 400
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
            $req->all(), [
            'post'    => 'required|numeric',
            'type'    => 'required',
            'person'  => 'required|numeric',
            'message' => 'required',
        ], [
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
            $req->all(), [
            'post' => 'required',
        ], [
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
                    "fecha_fin"  => $item->dateEnd()
                ];
            }
        );

        return response()->json(['status' => 'ok', 'list' => $list]);
    }


}