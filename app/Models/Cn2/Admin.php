<?php
namespace App\Models\Cn2;

use Illuminate\Database\Eloquent\Model;

class Admin extends Model
{
    protected $table = 'tbl_admin';
    protected $visible = array('id','nombre','apellido','foto','email','user','pass','es_admin'); ///only fields that return


}