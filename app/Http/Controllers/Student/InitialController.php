<?php

namespace App\Http\Controllers\Student;

use App\Http\Controllers\Api\StudentController;
use Laravel\Lumen\Routing\Controller as BaseController;
use Illuminate\Http\Request;
use App\Models\Cn2\Student;

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

    public function index(Request $req){

        if($req->session()->has("myUser")){
            return redirect()->route('student.home');
        }else{
            return redirect()->route('student.login');
        }

    }

    public function login()
    {
        return view('student.pages.initial.login');
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
