<?php
namespace App\Models\Cn2;

use Illuminate\Database\Eloquent\Model;
use Carbon\Carbon;

class StudentMessage extends Model
{
    protected $table = 'tbl_mensaje_est';
    protected $visible = array('id','created_at','tipo','subject','content','leido'); ///only fields that return

    public function student()
    {
        return $this->belongsTo('App\Models\Cn2\Student','para');
    }

    public function datetime(){
       return Carbon::parse($this->created_at)->format(env('APP_DATETIMEFORMAT'));
    }

    //get sender of message

    /**sender name and profile
     * @return string
     */
    public function sender(){

        if($this->tipo){
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

        if($this->tipo){
            $sender = Admin::findOrFail($this->de);
        }else{
            $sender = Student::findOrFail($this->de);
        }

        return $sender;
    }

}