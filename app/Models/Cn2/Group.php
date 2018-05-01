<?php
namespace App\Models\Cn2;

use Illuminate\Database\Eloquent\Model;

class Group extends Model
{
    protected $table = 'tbl_grupo';
    protected $visible = array('id','nombre','descripcion'); ///only fields that return

    public function course()
    {
        return $this->belongsTo('App\Models\Cn2\Course','curso_id');
    }
}