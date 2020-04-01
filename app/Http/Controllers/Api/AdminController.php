<?php
/**
 * Created by PhpStorm.
 * User: Luis De Lima
 * Date: 24-Jul-18
 * Time: 9:13 PM
 */

namespace App\Http\Controllers\Api;

use App\Models\Cn2\Admin;
use App\Models\Cn2\File;
use Laravel\Lumen\Routing\Controller as BaseController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Storage;
use DB;
use Carbon\Carbon;
use Illuminate\Support\Facades\Log;
use Validator;

class AdminController extends BaseController
{

    /**
     * Create a new controller instance.
     * @return void
     */
    public function __construct(Request $req)
    {

    }

    /**save file to resources
     * @param Request $req
     * @return mixed
     */
    public function saveFileResource(Request $req)
    {

        $validator = Validator::make($req->all(), [
            'persona' => 'required',
            'descripcion' => 'required|min:5',
            'file' => 'required|file'
        ], ['required' => trans('commons.validation.required'),
            'min' => trans('commons.validation.min'),
        ]);

        if ($validator->fails()) {
            $error = $validator->errors()->first();
            Log::warning($error);
            return response()->json(['status' => 'error', 'message' => $error], 400);
        }

        try {

            if ($req->file('file')->isValid()) {
                $size = bcdiv(intval($req->file('file')->getClientSize()), 1048576, 2); ///size mb
                $file = new File();
                $file->tipo = 0;
                $file->add_by = "admin";
                $file->persona = $req->persona;
                $file->descripcion = $req->descripcion;
                $file->dir = $req->file('file')->getClientOriginalName();
                $file->mime = $req->file('file')->getMimeType();
                $file->size = $size . ' Mb';
                $file->extension = $req->file('file')->guessClientExtension();
                $file->filepath = Storage::disk('courses')->putFile("files", $req->file('file'));
                $file->save();
                return response()->json(['status' => 'ok', 'message' => trans('commons.file.upload.successfully')]);
            } else {
                return response()->json(['status' => 'error', 'message' => trans('commons.file.upload.error')], 400);
            }
        } catch (Exception $ex) {
            return response()->json(['status' => 'error', 'message' => $ex->getTraceAsString()], 500);
        }

    }

    /**open file of resource
     * @param $res_id
     * @return mixed
     */
    public function openFileResource($res_id)
    {
        try {
            $resource = File::findOrFail($res_id);
            //file exist
            if ($resource->tipo == 0 && Storage::disk('courses')->has($resource->filepath)) {
                $file = Storage::disk('courses')->url($resource->filepath);
                return response()->download($file);
            } else {
                return response()->json(['status' => 'error', 'message' => trans('commons.file.notfound')], 404);
            }
        } catch (Exception $ex) {
            return response()->json(['status' => 'error', 'message' => $ex->getTraceAsString()], 500);
        }

    }

    /**delete file resource
     * @param $res_id
     * @return mixed
     */
    public function deleteFileResource($res_id)
    {
        try {
            $resource = File::findOrFail($res_id);
            Storage::disk('courses')->delete($resource->filepath);
            $resource->delete();
            return response()->json(['status' => 'ok', 'message' => trans('commons.file.deleted.successfully')]);
        } catch (Exception $ex) {
            return response()->json(['status' => 'error', 'message' => $ex->getTraceAsString()], 500);
        }
    }


}