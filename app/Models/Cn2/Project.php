<?php

namespace App\Models\Cn2;

use Illuminate\Database\Eloquent\Model;
use Carbon\Carbon;

class Project extends Model
{
    protected $table = 'tbl_proyecto';

    const STATUS_PENDING = 0;
    const STATUS_ANSWERED = 1;
    const STATUS_NOT_ANSWERED = 2;

    public function topic()
    {
        return $this->belongsTo('App\Models\Cn2\Topic', 'contenido_id');
    }

    public function group()
    {
        return $this->belongsTo('App\Models\Cn2\Group', 'grupo');
    }

    public function students()
    {
        return $this->hasMany('App\Models\Cn2\ProjectStudent', 'proy_id');
    }

    public function dateInit()
    {
        return Carbon::parse($this->fecha_edit)->format(env('APP_DATEFORMAT'));
    }

    public function dateEnd()
    {
        return Carbon::parse($this->fecha_entrega)->format(env('APP_DATEFORMAT'));
    }

    public function resources()
    {
        return $this->hasMany('App\Models\Cn2\ProjectFile','proy_id');
    }

    public function status()
    {
        if($this->students->count())
        {
            return static::STATUS_ANSWERED;
        }

        $now = Carbon::now();

        if ($now->greaterThanOrEqualTo($this->fecha_edit) && $now->lessThan($this->fecha_entrega)) {
            return static::STATUS_PENDING;
        }

        if ($now->greaterThan($this->fecha_entrega)) {
            return static::STATUS_NOT_ANSWERED;
        }
    }

    public function statusName()
    {
        $name = '';
        switch ($this->status()) {
            case static::STATUS_PENDING:
                $name = __('students.classroom.project.status.pending');
                break;
            case static::STATUS_ANSWERED:
                $name = __('students.classroom.project.status.answered');
                break;
            case static::STATUS_NOT_ANSWERED:
                $name = __('students.classroom.project.status.notanswered');
                break;
        }
        return $name;
    }

}
