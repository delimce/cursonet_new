<?php


namespace App\Models\Cn2;

use Illuminate\Database\Eloquent\Model;


class ProjectStudent extends Model
{
    protected $table = 'tbl_proyecto_estudiante';

    public function project()
    {
        return $this->belongsTo('App\Models\Cn2\Project', 'proy_id');
    }

    protected $fillable = ['proy_id', 'rec_id', 'est_id'];
}
