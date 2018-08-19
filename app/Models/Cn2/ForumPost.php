<?php

namespace App\Models\Cn2;

use Illuminate\Database\Eloquent\Model;
use Carbon\Carbon;

class ForumPost extends Model
{
    protected $table = 'tbl_foro_comentario';


    public function likes(){
        return $this->hasMany('App\Models\Cn2\ForumPostLike', 'comentario_id');
    }
 
    public function forum()
    {
        return $this->belongsTo('App\Models\Cn2\Forum', 'foro_id');
    }

    public function person()
    {
        if ($this->tipo_sujeto == 'est')
            return $this->belongsTo('App\Models\Cn2\Student', 'sujeto_id', 'id');
        else
            return $this->belongsTo('App\Models\Cn2\Admin', 'sujeto_id', 'id');
    }

    public function statusName()
    {
        return ($this->valido) ? trans('students.classroom.forum.post.status.confirmed') : trans('students.classroom.forum.post.status.unconfirmed');
    }

    public function date()
    {
        return Carbon::parse($this->created_at)->format(env('APP_DATEFORMAT'));
    }

}