<?php

namespace App\Models\Cn2;

use Illuminate\Database\Eloquent\Model;

class Student extends Model
{
    protected $table = 'tbl_estudiante';

    public function logs()
    {
        return $this->hasMany('App\Models\Cn2\StudentLog');
    }

    public function messages()
    {
        return $this->hasMany('App\Models\Cn2\StudentMessage', 'para');
    }

    public function messagesSent()
    {
        return $this->hasMany('App\Models\Cn2\StudentMessageSent', 'est_id');
    }

    public function groups()
    {
        return $this->hasMany('App\Models\Cn2\GroupStudent', 'est_id');
    }

    /**
     * The attributes excluded from the model's JSON form.
     *
     * @var array
     */
    protected $hidden = [
        'pass', 'clave_preg', 'clave_resp',
    ];
}