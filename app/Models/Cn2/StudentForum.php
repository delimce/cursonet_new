<?php
namespace App\Models\Cn2;

use Illuminate\Database\Eloquent\Model;

class StudentForum extends Model
{
    protected $table = 'tbl_foro_estudiante';
    protected $visible = array('id','nota','correccion'); ///only fields that return

    public function student()
    {
        return $this->belongsTo('App\Models\Cn2\Student','est_id');
    }
}