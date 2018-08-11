<?php

namespace App\Models\Cn2;

use Illuminate\Database\Eloquent\Model;
use Carbon\Carbon;

class ForumPostLike extends Model
{
    protected $table = 'tbl_foro_comentario_like';

    public function post()
    {
        return $this->belongsTo('App\Models\Cn2\ForumPost', 'comentario_id');
    }

    public function person()
    {
        if ($this->tipo_sujeto == 'est')
            return $this->belongsTo('App\Models\Cn2\Student', 'sujeto_id', 'id');
        else
            return $this->belongsTo('App\Models\Cn2\Admin', 'sujeto_id', 'id');
    }

    public function date()
    {
        return Carbon::parse($this->create_at)->format(env('APP_DATEFORMAT'));
    }

}