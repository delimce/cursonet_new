<?php
namespace App\Models\Cn2;

use Illuminate\Database\Eloquent\Model;
use Carbon\Carbon;

class Topic extends Model
{
    protected $table = 'tbl_contenido';
    protected $visible = array('id','autor','titulo','contenido','borrador','leido'); ///only fields that return

    public function course()
    {
        return $this->belongsTo('App\Models\Cn2\Course','curso_id');
    }

    public function files()
    {
        return $this->hasMany('App\Models\Cn2\TopicFile','contenido_id');
    }

    public function forums()
    {
        return $this->hasMany('App\Models\Cn2\Forum','contenido_id');
    }

    public function projects()
    {
        return $this->hasMany('App\Models\Cn2\Project','contenido_id');
    }

    public function createdAt(){
        return Carbon::parse($this->fecha_creado)->format(env('APP_DATEFORMAT'));
    }

    protected $fillable = ['leido'];


}