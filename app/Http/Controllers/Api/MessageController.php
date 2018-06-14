<?php

namespace App\Http\Controllers\Api;

use App\Models\Cn2\StudentMessage;
use Laravel\Lumen\Routing\Controller as BaseController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Mail;
use App\Models\Cn2\Student;
use DB;
use Carbon\Carbon;

class MessageController extends BaseController
{
    /**
     * Create a new controller instance.
     * @return void
     */
    public function __construct()
    {
        //
    }

    //

    public function getMessage($id)
    {
        $message = StudentMessage::where("id", $id)->first();

        if (isset($message->id)) {
            ///set read
            StudentMessage::where('id', $message->id)->where("leido",0)->update(['leido' => 1]);
            $data = array(
                "id" => $message->id,
                "content" => $message->content,
                "subject" => $message->subject,
                "profile" => $message->tipo,
                "sender" => $message->senderObject(),
                "date" => $message->datetime()
            );
            return response()->json(['status' => 'ok', 'message' => $data]);
        } else {
            return response()->json(['status' => 'error', 'message' => trans('students.inbox.no_message')], 403);
        }
    }

}
