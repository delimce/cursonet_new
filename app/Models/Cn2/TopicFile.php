<?php
namespace App\Models\Cn2;

use Illuminate\Database\Eloquent\Model;
use Carbon\Carbon;

class TopicFile extends Model
{
    protected $table = 'tbl_contenido_recurso';

    public function topic()
    {
        return $this->belongsTo('App\Models\Cn2\Topic','contenido_id');
    }

    public function file()
    {
        return $this->belongsTo('App\Models\Cn2\File','recurso_id');
    }


}