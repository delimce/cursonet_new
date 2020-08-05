<?php

/**
 * Created by PhpStorm.
 * User: Luis De Lima
 * Date: 24-Jul-18
 * Time: 9:13 PM
 */

namespace App\Http\Controllers\Api;

use App\Repositories\ResourceRepository;
use App\Services\ResourceMediaService;
use Laravel\Lumen\Routing\Controller as BaseController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;
use Validator;
use Exception;

class AdminController extends BaseController
{

    private $mediaService;
    private $resourceRepository;

    /**
     * Create a new controller instance.
     * @return void
     */
    public function __construct(
        Request $req,
        ResourceMediaService $service,
        ResourceRepository $repository
    ) {
        $this->mediaService = $service;
        $this->resourceRepository = $repository;
    }

    /**
     * save file to resources
     * @param Request $req
     * @return mixed
     */
    public function saveFileResource(Request $req)
    {

        $validator = Validator::make($req->all(), [
            'persona' => 'required',
            'descripcion' => 'required|min:5',
            'file' => 'required|file'
        ], [
            'required' => trans('commons.validation.required'),
            'min' => trans('commons.validation.min'),
        ]);

        if ($validator->fails()) {
            $error = $validator->errors()->first();
            Log::warning($error);
            return response()->json(['status' => 'error', 'message' => $error], 400);
        }

        try {
            if ($req->file('file')->isValid()) {
                $data = $this->mediaService->getMetadata($req->file('file'));
                $data["type"] = 0;
                $data["addBy"] = 'admin';
                $data["personId"] = $req->persona;
                $data["desc"] = $req->descripcion;
                $data["path"] = $this->mediaService->moveToResourcesPath($req->file('file'));
                $this->resourceRepository->createResource($data);
                return response()->json(['status' => 'ok', 'message' => trans('commons.file.upload.successfully')]);
            } else {
                return response()->json(['status' => 'error', 'message' => trans('commons.file.upload.error')], 400);
            }
        } catch (Exception $ex) {
            return response()->json(['status' => 'error', 'message' => $ex->getTraceAsString()], 500);
        }
    }

    /**
     * open file of resource
     * @param $res_id
     * @return mixed
     */
    public function openFileResource($res_id)
    {
        try {
            $resource = $this->resourceRepository->getResourceById($res_id);
            $file = $this->mediaService->getFromResourcePath($resource->filepath);
            //file exist
            if ($resource->tipo == 0 && $file) {
                return response()->download($file);
            } else {
                return response()->json(['status' => 'error', 'message' => trans('commons.file.notfound')], 404);
            }
        } catch (Exception $ex) {
            return response()->json(['status' => 'error', 'message' => $ex->getTraceAsString()], 500);
        }
    }

    /**
     * delete file resource
     * @param $res_id
     * @return mixed
     */
    public function deleteFileResource($res_id)
    {
        try {
            $resource = $this->resourceRepository->getResourceById($res_id);
            $this->mediaService->deleteFromResourcePath($resource->filepath);
            $this->resourceRepository->deleteResourceById($res_id);
            return response()->json(['status' => 'ok', 'message' => trans('commons.file.deleted.successfully')]);
        } catch (Exception $ex) {
            return response()->json(['status' => 'error', 'message' => $ex->getTraceAsString()], 500);
        }
    }
}
