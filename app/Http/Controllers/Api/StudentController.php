<?php

namespace App\Http\Controllers\Api;

use Laravel\Lumen\Routing\Controller as BaseController;
use Illuminate\Support\Facades\Hash;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use App\Models\Cn2\Student;

class StudentController extends BaseController
{
    /**
     * Create a new controller instance.
     * @return void
     */
    public function __construct()
    {
        //  $this->middleware('auth:api');
    }

    public function login(Request $req)
    {

        $this->validate($req, [
            'email' => 'required|email',
            'password' => 'required'
        ]);

        $user = Student::where('email', $req->input('email'))->first();
        if (is_null($user))
            return response()->json(['status' => 'error','message'=>'Email desconocido'], 401);
        if (Hash::check($req->input('password'), $user->pass)) {
            $apikey = md5(str_random(40));
            Student::where('email', $req->input('email'))->update(['api_key' => "$apikey"]);
            return response()->json(['status' => 'success', 'api_key' => $apikey]);
        } else {
            return response()->json(['status' => 'fail','message'=>'el password no es correcto'], 401);
        }
    }


    public function forgotten(Request $req)
    {

        $this->validate($req, [
            'email' => 'required|email'
        ]);

        $user = Student::where('email', $req->input('email'))->first();
        if (!is_null($user)){
            return response()->json(['status' => 'ok']);
        }else{
            return response()->json(['status' => 'error','message'=>'Email desconocido'], 401);
        }



    }


}
