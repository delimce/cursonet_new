<?php

namespace App\Services;

use App\Models\Cn2\Student;
use DB;
use Illuminate\Support\Facades\Log;
use PDOException;
use Illuminate\Support\Facades\Hash;
use App\Models\Cn2\StudentLog;
use Carbon\Carbon;
use Ramsey\Uuid\Uuid;

class StudentService
{

    const FIELDS = ['id', 'nombre', 'apellido', 'email', 'pass', 'activo', 'token'];


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
}
