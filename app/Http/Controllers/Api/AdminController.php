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
                $file->size = $size.' Mb';
                $file->extension = $req->file('file')->guessClientExtension();
                $file->save();
                Storage::disk('courses')->put("files/{$file->dir}", $req->file('file'));
                return response()->json(['status' => 'ok', 'message' => trans('commons.file.upload.successfully')]);
            } else {
                return response()->json(['status' => 'error', 'message' => trans('commons.file.upload.error')], 400);
            }
        } catch (Exception $ex) {
            return response()->json(['status' => 'error', 'message' => $ex->getTraceAsString()], 500);
        }

    }


}