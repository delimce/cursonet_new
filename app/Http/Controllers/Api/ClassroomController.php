<?php

namespace App\Http\Controllers\Api;

use App\Models\Cn2\File;
use App\Models\Cn2\Topic;
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
     * @return mixed
     */
    public function getTopicInfo($topic_id)
    {
        $info = Topic::findOrFail($topic_id);
        $files = $info->files()->with('File')->get();
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