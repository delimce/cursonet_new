<?php


namespace App\Models\Cn2;

use Illuminate\Database\Eloquent\Model;

class ProjectFile extends Model
{
    protected $table = 'tbl_proyecto_recurso';

    public function project()
    {
        return $this->belongsTo('App\Models\Cn2\Project', 'proy_id');
    }

    public function file()
    {
        return $this->belongsTo('App\Models\Cn2\File', 'rec_id');
    }
    

}