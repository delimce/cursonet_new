<?php
namespace App\Models\Cn2;

use Illuminate\Database\Eloquent\Model;

class Admin extends Model
{
    protected $table = 'tbl_admin';
    protected $visible = array('id','nombre','apellido','img','email','user','es_admin'); ///only fields that return

    protected $hidden = [
        'pass',
    ];

    public function courses()
    {
        return $this->hasMany('App\Models\Cn2\AdminCourse', 'admin_id');
    }

     /**
     * @return string
     */
    public function fullname()
    {
        return $this->nombre." ".$this->apellido;
    }


}