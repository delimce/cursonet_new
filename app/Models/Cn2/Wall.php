<?php
namespace App\Models\Cn2;

use Illuminate\Database\Eloquent\Model;
use Carbon\Carbon;

class Wall extends Model
{
    protected $table = 'tbl_cartelera';
    protected $visible = array('id','mensaje'); ///only fields that return

    public function course()
    {
        return $this->belongsTo('App\Models\Cn2\Course','curso_id');
    }

    public function createdAt(){
        return Carbon::parse($this->fecha_creado)->format(env('APP_DATEFORMAT'));
    }


}