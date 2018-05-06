<?php

namespace App\Http\Controllers\Student;

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

    public function index()
    {
       return  view('student.pages.initial.login');
    }

    public function forgotPassword()
    {
        return  view('student.pages.initial.forgotPassword');
    }

    public function register()
    {
        return  view('student.pages.initial.register');
    }

    public function userActivated($apikey)
    {

        $user = Student::where('token',$apikey)->first();
        if(!is_null($user)){
            $newapikey = md5(str_random(40));
            Student::where('email', $user->email)->update(['token' => "$newapikey","activo"=>1]);
        }

        return  view('student.pages.initial.activated',['user' => $user]);
    }

    public function registerSuccess($email)
    {
        return  view('student.pages.initial.registerSuccess', ['email' => $email]);
    }
}
