<?php

namespace App\Models\Cn2;

use Illuminate\Database\Eloquent\Model;

class Plan extends Model
{
    protected $table = 'tbl_plan_evaluador';

    public function group()
    {
        return $this->belongsTo('App\Models\Cn2\Group', 'grupo_id');
    }

    public function items()
    {
        return $this->hasMany('App\Models\Cn2\PlanItem', 'plan_id');
    }

    public function groupStudent()
    {
        return $this->belongsTo('App\Models\Cn2\GroupStudent', 'grupo_id');
    }

}