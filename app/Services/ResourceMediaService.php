<?php

namespace App\Services;

use Illuminate\Support\Facades\Storage;
use Illuminate\Http\UploadedFile;

class ResourceMediaService
{
    const RESOURCE_DISC = 'courses';
    const RESOURCE_PATH = 'files';


    /**
     * getMetadata
     *
     * @param  UploadedFile $file
     * @return array
     */
    public function getMetadata(UploadedFile $file)
    {
        $data = [];
        $data['filename'] = $file->getClientOriginalName();
        $data['mime'] = $file->getMimeType();
        $data['ext'] = $file->guessClientExtension();
        $data['size'] = $file->getSize(). ' Mb'; //size mb
        return $data;
    }


    /**
     * moveToResourcesPath
     *
     * @param  UploadedFile $file
     * @return string
     */
    public function moveToResourcesPath(UploadedFile $file)
    {
        return Storage::disk(static::RESOURCE_DISC)->putFile(static::RESOURCE_PATH, $file);
    }

        
    /**
     * hasPath
     *
     * @param  string $pathfile
     * @return bool
     */
    public function hasPath($pathfile)
    {
        return Storage::disk(static::RESOURCE_DISC)->has($pathfile);
    }


    /**
     * getFromResourcePath
     *
     * @param  string $path
     * @return void|bool
     */
    public function getFromResourcePath($path)
    {
        if ($this->hasPath($path)) {
            return Storage::disk(static::RESOURCE_DISC)->url($path);
        }
        return false;
    }


    /**
     * deleteFromResourcePath
     *
     * @param  mixed $path
     * @return void|bool
     */
    public function deleteFromResourcePath($path)
    {
        if ($this->hasPath($path)) {
            return  Storage::disk(static::RESOURCE_DISC)->delete($path);
        }
        return false;
    }
}
