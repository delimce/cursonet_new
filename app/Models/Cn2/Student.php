<?php
namespace App\Models\Cn2;

use Illuminate\Database\Eloquent\Model;

class Student extends Model
{
    protected $table = 'tbl_estudiante';
    protected $visible = array('id','nombre','apellido','id_number','user','email','foto','sexo','fecha_nac','token','activo'); ///only fields that return

    public function logs()
    {
        return $this->hasMany('App\Models\Cn2\StudentLog');
    }

    /**
     * The attributes excluded from the model's JSON form.
     *
     * @var array
     */
    protected $hidden = [
        'pass',
    ];
}