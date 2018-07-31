<?php

namespace App\Models\Cn2;

use Illuminate\Database\Eloquent\Model;
use Carbon\Carbon;

class Forum extends Model
{
    protected $table = 'tbl_foro';

    public function group()
    {
        return $this->belongsTo('App\Models\Cn2\Group','grupo_id');
    }

    public function posts(){
        return $this->hasMany('App\Models\Cn2\ForumPost', 'foro_id');
    }
 
    public function dateInit(){
        return Carbon::parse($this->fecha_post)->format(env('APP_DATEFORMAT'));
    }

    public function dateEnd(){
        return Carbon::parse($this->fecha_fin)->format(env('APP_DATEFORMAT'));
    }

}