<?php

/**
 * Created by PhpStorm.
 * User: Luis De Lima
 * Date: 23-Jun-18
 * Time: 9:13 PM
 */

namespace App\Http\Controllers\Api;

use App\Models\Cn2\Admin;
use Laravel\Lumen\Routing\Controller as BaseController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use DB;
use Carbon\Carbon;
use App\Models\Cn2\Student;
use App\Models\Cn2\GroupStudent;
use App\Models\Cn2\TechSupport;
use Validator;

class AccountController extends BaseController
{
    private $student;
    const PREF_STUDENT = 'est';

    /**
     * Create a new controller instance.
     * @return void
     */
    public function __construct(Request $req)
    {
        $token = $req->header('Authorization');
        $this->student = Student::where("token", $token)->first();
    }


    /**get student's contacts
     * @return mixed
     */
    public function getContacts()
    {
        $estId = $this->student->id;
        ///student's groups
        $groups = $this->student->groups()->with('group')->get();
        $teacher_array = array();
        $group_array = array();
        $groups->each(function ($value) use (&$group_array, &$teacher_array) {
            $group_array[] = $value->grupo_id;
            $teacher_array[] = $value->group->prof_id;
        });

        $students = GroupStudent::with(['Student' => function ($q) use ($estId) {
            // Query the name field in status table
            $q->where('id', '!=', $estId)->where("share_info", 1);
        }])->whereIn('grupo_id', $group_array)->get();

        $data_student = [];

        $students->each(function ($item) use (&$data_student) {
            if ($item->Student != null) $data_student[] = $item->Student->only(['id', 'nombre', 'apellido', 'email', 'foto', 'sexo', 'fecha_nac', 'telefono_p']);
        });

        ///get teachers
        $teachers = Admin::whereIn('id', $teacher_array)->get();
        //merge data
        $data_student = collect($data_student)->unique()->toArray();
        $output = array_merge($data_student, $teachers->toArray());

        return response()->json(['status' => 'ok', 'contacts' => $output]);
    }


    /**set value of account setting
     * @param Request $req
     * @return mixed
     */
    public function setSetting(Request $req)
    {
        $validator = Validator::make($req->all(), [
            'field' => 'required',
            'status' => 'required'
        ], [
            'required' => trans('commons.validation.required')
        ]);

        if ($validator->fails()) {
            $error = $validator->errors()->first();
            return response()->json(['status' => 'error', 'message' => $error], 400);
        }
        $status = (boolval($req->status)) ? 1 : 0;
        $field = $req->field;

        try {
            Student::where("id", $this->student->id)->update(array("$field" => $status));
            return response()->json(['status' => 'ok', 'message' => trans('students.profile.setting.success')]);
        } catch (Exception $ex) {
            return response()->json(['status' => 'error', 'message' => "setting do not exists"], 500);
        }
    }


    public function changePassword(Request $req)
    {
        $validator = Validator::make($req->all(), [
            'pass' => 'required|min:5',
            'pass2' => 'required|min:5'
        ], [
            'required' => trans('commons.validation.required'),
            'min' => trans('commons.validation.min'),
        ]);

        if ($validator->fails()) {
            $error = $validator->errors()->first();
            return response()->json(['status' => 'error', 'message' => $error], 400);
        }

        if ($req->input('pass') === $req->input('pass2')) {
            $this->student->pass = Hash::make($req->input('pass'));
            $this->student->save();
            return response()->json(['status' => 'ok', 'message' => trans('students.profile.change.password.success')]);
        } else {
            return response()->json(['status' => 'error', 'message' => trans('students.profile.change.password.nomatch')], 400);
        }
    }

    public function saveProfile(Request $req)
    {

        $validator = Validator::make($req->all(), [
            'id_number' => 'required|min:5',
            'nombre' => 'required|min:2',
            'apellido' => 'required|min:3',
            'sexo' => 'required',
            'fecha_nac' => 'required|date',
            'email' => 'required|email',
        ], [
            'required' => trans('commons.validation.required'),
            'min' => trans('commons.validation.min'),
            'email' => trans('commons.validation.email'),
            'date' => trans('commons.validation.date'),
        ]);

        if ($validator->fails()) {
            $error = $validator->errors()->first();
            return response()->json(['status' => 'error', 'message' => $error], 400);
        }

        //if email or ci exists
        $exist = Student::where("id", "!=", $this->student->id)->where(function ($query) use ($req) {
            $query->where("email", $req->input('email'))
                ->orWhere("id_number", $req->input('id_number'));
        })->count();

        if ($exist > 0) {
            return response()->json(['status' => 'error', 'message' => trans('students.profile.change.exist')], 400);
        }

        $this->student->id_number = $req->input('id_number');
        $this->student->nombre = $req->input('nombre');
        $this->student->apellido = $req->input('apellido');
        $this->student->sexo = $req->input('sexo');
        $this->student->fecha_nac = $req->input('fecha_nac');
        $this->student->email = $req->input('email');
        if ($req->has('telefono'))
            $this->student->telefono_p = $req->input('telefono');
        if ($req->has('foto')) //if has base64 picture
            $this->student->foto = $req->input('foto');
        $this->student->save();

        return response()->json(['status' => 'ok', 'message' => trans('students.profile.data.save')]);
    }



    public function sendSupportMessage(Request $req)
    {
        $validator = Validator::make($req->all(), [
            'contenido' => 'required|min:5',
        ], [
            'required' => trans('commons.validation.required'),
            'min' => trans('commons.validation.min'),
        ]);

        if ($validator->fails()) {
            $error = $validator->errors()->first();
            return response()->json(['status' => 'error', 'message' => $error], 400);
        }

        TechSupport::create([
            'persona_id' => $this->student->id,
            'tipo' => self::PREF_STUDENT,
            'titulo' => trans('students.support.request'),
            'contenido' => $req->contenido,
        ]);
        return response()->json(['status' => 'ok', 'message' => trans('commons.message.sent')]);
    }
}
