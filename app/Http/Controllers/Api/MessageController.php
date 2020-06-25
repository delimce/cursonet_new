<?php

namespace App\Http\Controllers\Api;

use App\Models\Cn2\AdminMessage;
use App\Models\Cn2\StudentMessage;
use App\Models\Cn2\StudentMessageSent;
use Laravel\Lumen\Routing\Controller as BaseController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Mail;
use App\Models\Cn2\Student;
use DB;
use Carbon\Carbon;
use Validator;

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
        $data = [];
        if (count($messages) > 0) {
            foreach ($messages as $message) {
                $data[] = [
                    "id" => $message->id,
                    "asunto" => $message->subject,
                    "nombre" => $message->sender(),
                    "fecha" => $message->datetime()
                ];
            }
        }
        return response()->json(['status' => 'ok', 'list' => $data]);
    }

    /**
     * 
     */
    public function getMessagesSent()
    {
        $messages = $this->student->messagesSent()->orderBy("id", "DESC")->get();
        $data = [];
        if (count($messages) > 0) {
            foreach ($messages as $msg) {
                $data[] = [
                    "id" => $msg->id,
                    "name" => $msg->sender(),
                    "subject" => $msg->subject,
                    "datetime" => $msg->datetime()
                ];
            }
        }
        return response()->json(['status' => 'ok', 'list' => $data]);
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


    /**
     * get message sent
     */
    public function getMessageSent($id)
    {
        $sent = StudentMessageSent::where("id", $id)->whereEstId($this->student->id)->first();
        if (isset($sent->id)) {
            $data = [
                "id" => $sent->id,
                "content" => $sent->content,
                "subject" => $sent->subject,
                "profile" => $sent->tipo,
                "sender" => $sent->senderObject(),
                "date" => $sent->datetime()
            ];
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
            StudentMessage::where("id", $id)->wherePara($this->student->id)->delete();
            return response()->json(['status' => 'ok', 'message' => trans('commons.message.deleted')]);
        } catch (\Exception $ex) {
            return response()->json(['status' => 'error', 'message' => trans('commons.message.notfound')], 403);
        }
    }

    /**
     * delete message sent
     * @param $id
     */
    public function deleteMessageSent($id)
    {
        try {
            StudentMessageSent::where("id", $id)->whereEstId($this->student->id)->delete();
            return response()->json(['status' => 'ok', 'message' => trans('commons.message.deleted')]);
        } catch (\Exception $ex) {
            return response()->json(['status' => 'error', 'message' => trans('commons.message.notfound')], 403);
        }
    }


    /** create new message
     * @param Request $req
     * @return mixed
     */
    public function createMessage(Request $req)
    {

        $validator = Validator::make($req->all(), [
            'subject' => 'required|max:150',
            'type' => 'required|numeric',
            'to' => 'required|numeric',
            'message' => 'required|min:5'
        ], [
            'required' => trans('commons.validation.required.all'),
            'numeric' => trans('commons.validation.numeric'),
            'min' => trans('commons.validation.min'),
            'max' => trans('commons.validation.max'),
        ]);

        if ($validator->fails()) 
        {
            $error = $validator->errors()->first();
            return response()->json(['status' => 'error', 'message' => $error], 400);
        }

        DB::beginTransaction();

        if ($req->type) {
            $message = new AdminMessage();
        } else {
            $message = new StudentMessage();
        }

        $message->tipo = $req->type;
        $message->de = $this->student->id;
        $message->para = $req->to;
        $message->subject = $req->subject;
        $message->content = $req->message;
        $message->fecha = Carbon::now();
        $message->save();

        // create message sent
        StudentMessageSent::create([
            'est_id' => $this->student->id,
            'tipo' => $req->type,
            'para' => $req->to,
            'subject' => $req->subject,
            'content' => $req->message,
        ]);
        DB::commit();

        return response()->json(['status' => 'ok', 'message' => trans('students.inbox.new.success')]);
    }
}
