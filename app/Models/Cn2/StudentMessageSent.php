<?php

namespace App\Models\Cn2;

use Illuminate\Database\Eloquent\Model;
use Carbon\Carbon;

class StudentMessageSent extends Model
{
    protected $table = 'tbl_mensaje_est_enviado';
    protected $fillable = ['est_id', 'tipo', 'para', 'subject', 'content'];
    protected $visible = array('id', 'created_at', 'tipo', 'subject', 'content'); ///only fields that return

    public function student()
    {
        return $this->belongsTo('App\Models\Cn2\Student', 'est_id');
    }

    public function datetime()
    {
        return Carbon::parse($this->created_at)->format(env('APP_DATETIMEFORMAT'));
    }

    //get sender of message


    /**sender name and profile
     * @return string
     */
    public function sender()
    {

        if ($this->tipo) {
            $pre = trans('commons.teacher');
            $sender = Admin::findOrFail($this->para);
        } else {
            $pre = trans('commons.student');
            $sender = Student::findOrFail($this->para);
        }

        return "$pre {$sender->nombre} {$sender->apellido}";
    }

    /**object of sender
     * @return mixed
     */
    public function senderObject()
    {

        if ($this->tipo) {
            $sender = Admin::findOrFail($this->para);
        } else {
            $sender = Student::findOrFail($this->para);
        }

        return $sender;
    }
}
