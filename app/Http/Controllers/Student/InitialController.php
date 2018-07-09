<?php

namespace App\Http\Controllers\Student;

use App\Http\Controllers\Api\StudentController;
use App\Models\Cn2\StudentLog;
use Laravel\Lumen\Routing\Controller as BaseController;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use App\Models\Cn2\Student;
use DB;
use Illuminate\Support\Facades\Hash;
use Carbon\Carbon;

class InitialController extends BaseController
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

    public function index(Request $req)
    {

        if ($req->session()->has("myUser")) {
            return redirect()->route('student.home');
        } else {
            return redirect()->route('student.login');
        }

    }

    public function login()
    {
        return view('student.pages.initial.login');
    }

    /**login website
     * @param Request $req
     * @return mixed
     */
    public function doLogin(Request $req)
    {
        $fields = ['id', 'nombre', 'apellido', 'email', 'pass', 'activo', 'token'];
        $user = Student::where('email', $req->input('email'))->select($fields)->first();
        if (is_null($user))
            return response()->json(['status' => 'error', 'message' => trans('students.login.email.unknown')], 401);

        if (!$user->activo) {
            return response()->json(['status' => 'fail', 'message' => trans('students.login.signin.active.error')], 401);
        } else if (Hash::check($req->input('password'), $user->pass)) {

            DB::beginTransaction();
            $apikey = StudentController::newUserToken();
            $log = new StudentLog();
            $log->est_id = $user->id;
            $log->ip_acc = $_SERVER['REMOTE_ADDR'];
            $log->info_cliente = $_SERVER['HTTP_USER_AGENT'];
            $log->fecha_in = Carbon::now();
            $log->save();
            ///new login
            $user->token = $apikey;
            $user->save();
            $req->session()->put('myUser', $user);
            $req->session()->put('userLog', $log->id);
            DB::commit();

            return response()->json(['status' => 'ok', 'user' => $user]);
        } else {
            return response()->json(['status' => 'fail', 'message' => trans('students.login.password.error')], 401);
        }

    }

    public function forgotPassword()
    {
        return view('student.pages.initial.forgotPassword');
    }

    public function register()
    {
        return view('student.pages.initial.register');
    }

    public function userActivated($apikey)
    {
        $user = Student::where('token', $apikey)->first();
        if (!is_null($user)) {
            $newapikey = StudentController::newUserToken();
            Student::where('email', $user->email)->update(['token' => $newapikey, "activo" => 1]);
        }
        return view('student.pages.initial.activated', ['user' => $user]);
    }

    public function restoringPassword($apikey)
    {
        $user = Student::where('token', $apikey)->first();
        if (is_null($user)) { //invalid token

        }
        return view('student.pages.initial.restoring', ['user' => $user]);
    }


    public function restored()
    {
        return view('student.pages.initial.restored', ['email' => '']);
    }

    public function registerSuccess($email)
    {
        return view('student.pages.initial.registerSuccess', ['email' => $email]);
    }
}
