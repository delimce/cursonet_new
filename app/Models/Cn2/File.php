<?php

namespace App\Models\Cn2;

use Illuminate\Database\Eloquent\Model;
use Carbon\Carbon;

class File extends Model
{
    protected $table = 'tbl_recurso';

    public function getType()
    {
        switch ($this->tipo) {
            case 0:
                return trans('students.classroom.file.type.file');
                break;

            case 1:
                return trans('students.classroom.file.type.link');
                break;
            default:
                return trans('students.classroom.file.type.default');
                break;
        }
    }

    public function date(){
        return Carbon::parse($this->fecha)->format(env('APP_DATEFORMAT'));
    }

}