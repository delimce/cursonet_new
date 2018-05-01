<?php
namespace App\Models\Cn2;

use Illuminate\Database\Eloquent\Model;

class Course extends Model
{
    protected $table = 'tbl_curso';
    protected $visible = array('id','nombre','alias'); ///only fields that return

    public function author()
    {
        return $this->belongsTo('App\Models\Cn2\Admin','resp');
    }
}