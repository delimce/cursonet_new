<?php

namespace App\Models\Cn2;

use Illuminate\Database\Eloquent\Model;
use Carbon\Carbon;

class ForumPost extends Model
{
    protected $table = 'tbl_foro_comentario';

    public function forum()
    {
        return $this->belongsTo('App\Models\Cn2\Forum','foro_id');
    }

    public function date(){
        return Carbon::parse($this->create_at)->format(env('APP_DATEFORMAT'));
    }

}