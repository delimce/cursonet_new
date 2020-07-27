<?php

namespace App\Decorators;

use Illuminate\Database\Eloquent\Collection;
use  Illuminate\Support\Collection  as Collection2;

class ClassroomDecorator
{

    public function resourcesApiList(Collection $list)
    {
        return $list->map(function ($item) {
            return [
                "tipo" => $item->file->getType(),
                "tipo_id" => $item->file->tipo,
                "id" => $item->file->id,
                "dir" => $item->file->dir,
                "fecha" => $item->file->date()
            ];
        });
    }


    public function forumsApiList(Collection $list)
    {
        return $list->map(function ($item) {
            return [
                "id" => $item->id,
                "titulo" => $item->titulo,
                "grupo_id" => $item->grupo_id,
                "grupo_desc" => $item->group->nombre ?? __('commons.all'),
                "posts" => $item->posts->count(),
                "fecha_ini" => $item->dateInit(),
                "fecha_fin" => $item->dateEnd(),
                "status" => $item->statusName()
            ];
        });
    }

    public function projectsApiList(Collection $list)
    {
        return $list->map(function ($item) {
            return [
                "id" => $item->id,
                "name" => $item->nombre,
                "grupo_desc" => $item->group->nombre ?? __('commons.all'),
                "date_init" => $item->dateInit(),
                "date_end" => $item->dateEnd(),
                "status" => $item->statusName()
            ];
        });
    }
}
