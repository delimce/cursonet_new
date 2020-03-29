<?php

namespace App\Models\Cn2;

use Illuminate\Database\Eloquent\Model;

class PlanItemStudent extends Model
{
    protected $table = 'tbl_plan_estudiante';

    public function item()
    {
        return $this->belongsTo('App\Models\Cn2\PlanItem', 'item_id');
    }


}