<?php

namespace App\Models\Cn2;

use Illuminate\Database\Eloquent\Model;

class PlanItem extends Model
{
    protected $table = 'tbl_plan_item';

    public function plan()
    {
        return $this->belongsTo('App\Models\Cn2\Plan', 'plan_id');
    }

    public function ratings()
    {
        return $this->hasMany('App\Models\Cn2\PlanItemStudent', 'item_id');
    }


}