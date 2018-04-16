<?php
namespace App\Models\Cn2;

use Illuminate\Database\Eloquent\Model;

class StudentLog extends Model
{
    protected $table = 'tbl_log_est';
    protected $visible = array('id','fecha','ip_acc','ncontenidos','ndescargas'); ///only fields that return

    public function student()
    {
        return $this->belongsTo('App\Models\Cn2\Student','est_id');
    }
}