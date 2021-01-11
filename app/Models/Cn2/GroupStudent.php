<?php

namespace App\Models\Cn2;

use Illuminate\Database\Eloquent\Model;

class GroupStudent extends Model
{
    protected $table = 'tbl_grupo_estudiante';

    /**
     * The attributes that are mass assignable. & use insert method
     * @var array
     */
    protected $fillable = [
        'curso_id', 'est_id', 'grupo_id',
    ];

    public function course()
    {
        return $this->belongsTo('App\Models\Cn2\Course', 'curso_id');
    }

    public function group()
    {
        return $this->belongsTo(Group::class, 'grupo_id');
    }

    public function student()
    {
        return $this->belongsTo('App\Models\Cn2\Student', 'est_id');
    }

    public function plan()
    {
        return $this->hasOne('App\Models\Cn2\Plan', 'grupo_id');
    }
}
