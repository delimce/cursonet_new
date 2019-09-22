<?php

namespace App\Models\Cn2;

use Illuminate\Database\Eloquent\Model;
use Carbon\Carbon;
use DB;

class Forum extends Model
{
    protected $table = 'tbl_foro';

    public function group()
    {
        return $this->belongsTo('App\Models\Cn2\Group', 'grupo_id');
    }

    public function posts()
    {
        return $this->hasMany('App\Models\Cn2\ForumPost', 'foro_id');
    }

    public function dateInit()
    {
        return Carbon::parse($this->fecha_post)->format(env('APP_DATEFORMAT'));
    }

    public function dateEnd()
    {
        return Carbon::parse($this->fecha_fin)->format(env('APP_DATEFORMAT'));
    }

    public function getPostsByPersonLikes($person_id)
    {

        return ForumPost::leftJoin('tbl_foro_comentario_like as l', 'tbl_foro_comentario.id', '=', 'l.comentario_id')
            ->groupBy('tbl_foro_comentario.id')
            ->selectRaw("tbl_foro_comentario.*,count(l.id) as likes,
                         (select ifnull(id,0) from tbl_foro_comentario_like 
                         where comentario_id = tbl_foro_comentario.id and tipo_sujeto = 'est' and sujeto_id = $person_id) as opinion")
            ->whereForoId($this->id)
            ->get();


    }

}