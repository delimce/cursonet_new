<?php
namespace App\Models\Cn2;

use Illuminate\Database\Eloquent\Model;

class GroupStudent extends Model
{
    protected $table = 'tbl_grupo_estudiante';

    public function course()
    {
        return $this->belongsTo('App\Models\Cn2\Course','curso_id');
    }

    public function group()
    {
        return $this->belongsTo('App\Models\Cn2\Group','grupo_id');
    }

    public function student()
    {
        return $this->belongsTo('App\Models\Cn2\Student','est_id');
    }
}