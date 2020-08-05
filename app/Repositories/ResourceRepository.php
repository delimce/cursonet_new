<?php

namespace App\Repositories;

use App\Models\Cn2\File;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Log;
use PDOException;

class ResourceRepository
{

    /**
     * createResource
     *
     * @param  array $resourceData
     * @return Model|bool
     */
    public function createResource($resourceData)
    {
        try {
            $size = bcdiv(intval($resourceData['size']), 1048576, 2); ///size mb
            $file = new File();
            $file->tipo = $resourceData['type'];
            $file->add_by = $resourceData['addBy'];
            $file->persona = $resourceData['personId'];
            $file->descripcion = $resourceData['desc'];
            $file->dir = $resourceData['filename'];
            $file->mime = $resourceData['mime'];
            $file->size = $size . ' Mb';
            $file->extension = $resourceData['ext'];
            $file->filepath = $resourceData['path'];
            $file->save();
            $result = $file;
        } catch (PDOException $ex) {
            Log::error($ex);
            $result = false;
        } finally {
            return $result;
        }
    }


        
    /**
     * getResourceById
     *
     * @param  int $resourceId
     * @return Collection
     */
    public function getResourceById($resourceId)
    {
        return File::findOrFail($resourceId);
    }

    
    /**
     * deleteResource
     *
     * @param  int $resourceId
     * @return bool
     */
    public function deleteResourceById($resourceId)
    {
        $result = true;
        try {
            $resource = File::findOrFail($resourceId);
            $resource->delete();
        } catch (PDOException $ex) {
            Log::error($ex);
            $result = false;
        } finally {
            return $result;
        }
    }

}