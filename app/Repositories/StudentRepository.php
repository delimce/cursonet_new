<?php

namespace App\Repositories;

use DB;
use Illuminate\Support\Facades\Hash;
use App\Models\Cn2\StudentLog;
use App\Models\Cn2\Student;
use Carbon\Carbon;
use Illuminate\Database\Eloquent\Collection;
use Ramsey\Uuid\Uuid;

class StudentRepository
{

    const FIELDS = ['id', 'id_number', 'nombre', 'apellido', 'email', 'pass', 'activo', 'token', 'sexo', 'telefono_p', 'fecha_nac', 'share_info', 'notify_msg', 'notify_forum', 'notify_exam'];


    /**
     * doLogin
     *
     * @param  string $email
     * @param  string $password
     * @return array
     */
    public function doLogin($email, $password)
    {
        // student doesn't exist
        $result = ["ok" => false, "message" => ""];

        $user = Student::where('email', $email)->select(static::FIELDS)->first();

        if (is_null($user)) {
            $result["message"] = __('students.login.email.unknown');
            return $result;
        }

        // student is not active
        if (!$user->activo) {
            $result["message"] = __('students.login.signin.active.error');
            return $result;
        }

        if (!Hash::check($password, $user->pass)) {
            $result["message"] = __('students.login.password.error');
            return $result;
        }

        DB::beginTransaction();

        $log = new StudentLog();
        $log->est_id = $user->id;
        $log->ip_acc = $_SERVER["REMOTE_ADDR"] ?? '127.0.0.1';
        $log->info_cliente = $_SERVER['HTTP_USER_AGENT'] ?? '';
        $log->fecha_in = Carbon::now();
        $log->save();

        ///new login
        $user->token = static::userNewToken();
        $user->save();
        DB::commit();

        $result["ok"] = true;
        $result["user"] = $user;
        $result["userLog"] = $log->id;

        return $result;
    }


    /**
     * activeUser
     * active new user
     * @param  string $token
     * @return bool|mixed
     */
    public function activeUser($token)
    {
        $user = Student::where('token', $token)->first();
        if (!is_null($user)) {
            $newApikey = static::userNewToken();
            Student::where('email', $user->email)->update(['token' => $newApikey, "activo" => 1]);
            return $user;
        }
        return false;
    }


    /**
     * isTokenActive
     *
     * @param  string $token
     * @return bool
     */
    public static function isTokenActive($token)
    {
        $user = Student::where("token", $token)->where("activo", 1)->first();
        return !is_null($user);
    }


    /**
     * getUserByToken
     * @param  string $token
     * @return mixed|bool
     */
    public function getUserByToken($token)
    {
        $user = Student::where("token", $token)->where("activo", 1)->first();
        if (!is_null($user)) {
            return $user;
        }
        return false;
    }


    /**
     * userNewToken
     * get new student token
     * @return string
     */
    public static function userNewToken()
    {
        $uuid = Uuid::uuid6();
        return $uuid->toString();
    }



    /**
     * getStudentById
     *
     * @param  int $studentId
     * @return Collection
     */
    public function getStudentById($studentId)
    {
        return Student::find($studentId, static::FIELDS);
    }


    /**
     * getPlansByStudentId
     *
     * @param  int $studentId
     * @return Collection
     */
    public function getPlansByStudentId($studentId)
    {
        $plans = DB::table('tbl_plan_evaluador')
            ->join('tbl_grupo_estudiante', 'tbl_plan_evaluador.grupo_id', '=', 'tbl_grupo_estudiante.grupo_id')
            ->join('tbl_grupo', 'tbl_grupo.id', '=', 'tbl_grupo_estudiante.grupo_id')
            ->join('tbl_curso', 'tbl_curso.id', '=', 'tbl_grupo.curso_id')
            ->join('tbl_plan_item', 'tbl_plan_evaluador.id', '=', 'tbl_plan_item.plan_id')
            ->groupBy('plan_id')
            ->select('tbl_plan_evaluador.*', 'tbl_grupo.nombre as grupo', 'tbl_curso.alias as curso')
            ->selectRaw('count(tbl_plan_item.id) as items')
            ->whereEstId($studentId)
            ->get();

        return $plans;
    }
}
