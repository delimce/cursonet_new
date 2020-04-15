<?php

namespace App\Models\Cn2;

use Illuminate\Database\Eloquent\Model;

class TechSupport extends Model
{
    protected $table = 'tbl_soporte';
    protected $fillable = ['persona_id','tipo','titulo','contenido'];


}