<?php
/**
 * Created by PhpStorm.
 * User: Luis De Lima
 * Date: 23-Jun-18
 * Time: 9:13 PM
 */

namespace App\Http\Controllers\Api;

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
        $groups = $this->student->groups()->select("grupo_id")->get();
        $group_array = array();
        $groups->each(function ($value) use (&$group_array) {
            $group_array[] = $value->grupo_id;
        });

        $students = GroupStudent:: with(['Student' => function ($q) use ($estId) {
            // Query the name field in status table
            $q->where('id', '!=', $estId);
        }])->whereIn('grupo_id', $group_array)->get();

        $data_student = array();

        $students->each(function ($item) use (&$data_student) {
            if ($item->Student != null) $data_student[] = $item->Student->only(['id','nombre', 'apellido','email','foto','sexo','fecha_nac','telefono_p']);
        });

        return response()->json(['status' => 'ok', 'contacts' => $data_student]);
    }

}