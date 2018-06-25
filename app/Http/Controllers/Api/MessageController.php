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
    private $student;

    /**
     * Create a new controller instance.
     * @return void
     */
    public function __construct(Request $req)
    {
        $token = $req->header('Authorization');
        $this->student = Student::where("token", $token)->first();
    }


    /**get messages of student
     * @return mixed
     */
    public function getMessages()
    {

        $messages = $this->student->messages()->orderBy("id", "DESC")->get();
        $data = array();
        if (count($messages) > 0) {

            foreach ($messages as $message) {
                $data[] = array(
                    "id" => $message->id,
                    "subject" => $message->subject,
                    "sender" => $message->sender(),
                    "date" => $message->datetime(),
                    "leido" => $message->leido,
                );
            }

        }
        return response()->json(['status' => 'ok', 'messages' => $data]);

    }

    /** get message by id
     * @param $id
     * @return mixed
     */
    public function getMessage($id)
    {
        $message = StudentMessage::where("id", $id)->where("para", $this->student->id)->first();

        if (isset($message->id)) {
            ///set read
            StudentMessage::where('id', $message->id)->where("leido", 0)->update(['leido' => 1]);
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

    /** delete message by id
     * @param $id
     * @return mixed
     */
    public function deleteMessage($id)
    {
        try {
            $message = StudentMessage::where("id", $id)->where("para", $this->student->id)->first();
            $message->delete();
            return response()->json(['status' => 'ok', 'message' => trans('commons.message.deleted')]);
        } catch (\Exception $ex) {
            return response()->json(['status' => 'error', 'message' => trans('commons.message.notfound')], 500);
        }

    }

}
