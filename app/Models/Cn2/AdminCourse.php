<?php
namespace App\Models\Cn2;

use Illuminate\Database\Eloquent\Model;

class AdminCourse extends Model
{
    protected $table = 'tbl_admin_curso';

    public function admin()
    {
        return $this->belongsTo('App\Models\Cn2\Admin', 'admin_id');
    }
 

}