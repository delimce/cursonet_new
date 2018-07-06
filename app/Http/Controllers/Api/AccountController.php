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
use Validator;

class AccountController extends BaseController
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

        $students = GroupStudent:: with(['Student' => function ($q) use ($estId) {
            // Query the name field in status table
            $q->where('id', '!=', $estId)->where("share_info", 1);
        }])->whereIn('grupo_id', $group_array)->get();

        $data_student = array();

        $students->each(function ($item) use (&$data_student) {
            if ($item->Student != null) $data_student[] = $item->Student->only(['id', 'nombre', 'apellido', 'email', 'foto', 'sexo', 'fecha_nac', 'telefono_p']);
        });

        ///get teachers
        $teachers = Admin::whereIn('id', $teacher_array)->get();
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
            'status' => 'required',
            'field' => 'required'
        ], ['required' => trans('commons.validation.required')
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
        ], ['required' => trans('commons.validation.required'),
            'min' => trans('commons.validation.min'),
        ]);

        if ($validator->fails()) {
            $error = $validator->errors()->first();
            return response()->json(['status' => 'error', 'message' => $error], 400);
        }

        if($req->input('pass')===$req->input('pass2')){
            $this->student->pass = Hash::make($req->input('pass'));
            $this->student->save();
            return response()->json(['status' => 'ok', 'message' => trans('students.profile.change.password.success')]);
        }else{
            return response()->json(['status' => 'error', 'message' => trans('students.profile.change.password.nomatch')], 400);
        }


    }

}