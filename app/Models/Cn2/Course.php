<?php
namespace App\Models\Cn2;

use Illuminate\Database\Eloquent\Model;
use Carbon\Carbon;

class Course extends Model
{
    protected $table = 'tbl_curso';
    protected $visible = array('id','nombre','alias','duracion','descripcion','created_at'); ///only fields that return

    public function author()
    {
        return $this->belongsTo('App\Models\Cn2\Admin','resp');
    }

    public function createdAt(){
        return Carbon::parse($this->fecha_creado)->format(env('APP_DATEFORMAT'));
    }


}