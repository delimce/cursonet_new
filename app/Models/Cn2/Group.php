<?php

namespace App\Models\Cn2;

use Illuminate\Database\Eloquent\Model;

class Group extends Model
{
    protected $table = 'tbl_grupo';
    protected $visible = array('id', 'nombre', 'descripcion', 'prof_id', 'created_at'); ///only fields that return

    public function course()
    {
        return $this->belongsTo('App\Models\Cn2\Course', 'curso_id');
    }

    public function teacher()
    {
        return $this->belongsTo('App\Models\Cn2\Admin', 'prof_id');
    }

}