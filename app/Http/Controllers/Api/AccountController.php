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
use DB;
use Carbon\Carbon;
use App\Models\Cn2\Student;
use App\Models\Cn2\GroupStudent;

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


    public function getContacts()
    {

        $estId = $this->student->id;
        ///student's groups
        $groups = $this->student->groups()->with('group')->get();
        $teacher_array = array();
        $group_array = array();
        $groups->each(function ($value) use (&$group_array,&$teacher_array) {
            $group_array[] = $value->grupo_id;
            $teacher_array[] = $value->group->prof_id;
        });

        $students = GroupStudent:: with(['Student' => function ($q) use ($estId) {
            // Query the name field in status table
            $q->where('id', '!=', $estId);
        }])->whereIn('grupo_id', $group_array)->get();

        $data_student = array();

        $students->each(function ($item) use (&$data_student) {
            if ($item->Student != null) $data_student[] = $item->Student->only(['id','nombre', 'apellido','email','foto','sexo','fecha_nac','telefono_p']);
        });

        ///get teachers
        $teachers = Admin::whereIn('id',$teacher_array)->get();
        $output = array_merge($data_student, $teachers->toArray());

        return response()->json(['status' => 'ok', 'contacts' => $output]);
    }

}