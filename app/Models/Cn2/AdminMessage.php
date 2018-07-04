<?php
namespace App\Models\Cn2;

use Illuminate\Database\Eloquent\Model;
use Carbon\Carbon;

class AdminMessage extends Model
{
    protected $table = 'tbl_mensaje_admin';
    protected $visible = array('id','created_at','tipo','subject','content','leido','destinatario'); ///only fields that return

    public function admin()
    {
        return $this->belongsTo('App\Models\Cn2\Admin','para');
    }

    public function datetime(){
       return Carbon::parse($this->created_at)->format(env('APP_DATETIMEFORMAT'));
    }

    //get sender of message

    /**sender name and profile
     * @return string
     */
    public function sender(){

        if(!$this->tipo){ //admin to admin
            $pre = trans('commons.teacher');
            $sender = Admin::findOrFail($this->de);
        }else{
            $pre = trans('commons.student');
            $sender = Student::findOrFail($this->de);
        }

        return "$pre {$sender->nombre} {$sender->apellido}";
    }

    /**object of sender
     * @return mixed
     */
    public function senderObject(){

        if(!$this->tipo){ //admin to admin
            $sender = Admin::findOrFail($this->de);
        }else{
            $sender = Student::findOrFail($this->de);
        }

        return $sender;
    }

}