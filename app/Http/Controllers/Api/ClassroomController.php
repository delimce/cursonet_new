<?php

namespace App\Http\Controllers\Api;

use App\Models\Cn2\File;
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
        $token = $req->header('Authorization');
        $this->student = Student::where("token", $token)->first();
    }

    /**get topics title list
     * @param $course_id
     * @return mixed
     */
    public function getTopics($course_id)
    {
        $topics = Topic::select('id', 'titulo', 'leido')->where("curso_id", $course_id)->where("borrador", 0)->get();
        if ($topics->count() > 0) {
            return response()->json(['status' => 'ok', 'data' => $topics]);
        } else {
            return response()->json(['status' => 'error', 'message' => trans('students.classroom.modules.nofound')], 400);
        }
    }

    /**get whole topic info
     * @param $topic_id
     * @param $group_id
     * @return mixed
     */
    public function getTopicInfo($topic_id, $group_id = false)
    {
        $info = Topic::findOrFail($topic_id);
        $files = $info->files()->with('File')->get();
        if ($group_id) {
            $forums = Forum::whereContenidoId($info->id)
            ->with('Group')->whereIn("grupo_id", [0, $group_id])->get();
        } else {
            $forums = $info->forums()->with('Group')->get();
        }
        $info->leido++;
        $info->save();
        $data = array("id" => $info->id, "titulo" => $info->titulo, "contenido" => $info->contenido);
        ///files
        $resources = array();
        $files->each(function ($item) use (&$resources) {
            $temp = array();
            $temp["tipo"] = $item->file->getType();
            $temp["tipo_id"] = $item->file->tipo;
            $temp["id"] = $item->file->id;
            $temp["dir"] = $item->file->dir;
            $temp["fecha"] = $item->file->date();
            $resources[] = $temp;
        });
        $data["files"] = $resources;
        ///forums
        $infoForums = array();
        $forums->each(function ($item) use (&$infoForums) {
            $temp = array();
            $temp["id"] = $item->id;
            $temp["titulo"] = $item->titulo;
            $temp["grupo_id"] = $item->grupo_id;
            $temp["grupo_desc"] = $item->group->nombre ?? trans('commons.all');
            $temp["fecha_ini"] = $item->dateInit();
            $temp["fecha_fin"] = $item->dateEnd();
            $infoForums[] = $temp;
        });
        $data["forums"] = $infoForums;
        return response()->json(['status' => 'ok', 'info' => $data]);

    }


    public function getFile($res_id)
    {
        try {
            $resource = File::findOrFail($res_id);
            //file exist
            if ($resource->tipo == 0 && Storage::disk('courses')->has($resource->filepath)) {
                $resource->download++;
                $resource->save();
                $file = Storage::disk('courses')->url($resource->filepath);
                return response()->download($file);
            } else {
                return response()->json(['status' => 'error', 'message' => trans('commons.file.notfound')], 404);
            }
        } catch (Exception $ex) {
            return response()->json(['status' => 'error', 'message' => $ex->getTraceAsString()], 500);
        }


    }


}