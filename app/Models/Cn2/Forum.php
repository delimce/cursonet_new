<?php

namespace App\Models\Cn2;

use Illuminate\Database\Eloquent\Model;
use Carbon\Carbon;
use DB;

class Forum extends Model
{
    protected $table = 'tbl_foro';

    const STATUS_PENDING = 0;
    const STATUS_ACTIVE = 1;
    const STATUS_ENDED = 2;

    public function group()
    {
        return $this->belongsTo('App\Models\Cn2\Group', 'grupo_id');
    }

    public function topic()
    {
        return $this->belongsTo('App\Models\Cn2\Topic', 'contenido_id');
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

    public function status()
    {
        $now = Carbon::now();
        if ($now->lessThan($this->fecha_post)) {
            return static::STATUS_PENDING;
        }
        if ($now->greaterThanOrEqualTo($this->fecha_post) && $now->lessThan($this->fecha_fin)) {
            return static::STATUS_ACTIVE;
        }

        if ($now->greaterThan($this->fecha_fin)) {
            return static::STATUS_ENDED;
        }
    }

    public function statusName()
    {
        $name = '';
        switch ($this->status()) {
            case static::STATUS_PENDING:
                $name = __('students.classroom.forum.status.pending');
                break;
            case static::STATUS_ACTIVE:
                $name = __('students.classroom.forum.status.progress');
                break;
            case static::STATUS_ENDED:
                $name = __('students.classroom.forum.status.ended');
                break;
        }
        return $name;
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
