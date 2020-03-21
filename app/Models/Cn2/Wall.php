<?php
namespace App\Models\Cn2;

use Illuminate\Database\Eloquent\Model;
use Carbon\Carbon;

class Wall extends Model
{
    protected $table = 'tbl_cartelera';
    protected $visible = array('id','mensaje','fecha_c'); ///only fields that return

    public function course()
    {
        return $this->belongsTo('App\Models\Cn2\Course','curso_id');
    }

    public function createdAt(){
        return Carbon::parse($this->fecha_c)->format(env('APP_DATEFORMAT'));
    }

    public function detDate(){
        return (is_null($this->update_at))?$this->fecha_c:$this->updated_at;
    }

    


}