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

        if(!$user->activo){
            return response()->json(['status' => 'fail','message'=>'Disculpe, su usuario no está habilitado.'], 401);
        }else if (Hash::check($req->input('password'), $user->pass)) {
            $apikey = md5(str_random(40));
            Student::where('email', $req->input('email'))->update(['api_key' => "$apikey"]);
            return response()->json(['status' => 'ok', 'api_key' => $apikey]);
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

    public function emailValidation(Request $req){

        $this->validate($req, [
            'email' => 'required|email'
        ]);

        $user = Student::where('email', $req->input('email'))->first();
        if (!is_null($user)){
            return response()->json(['status' => 'error','message'=>'El email ya se encuentra registrado'],422);
        }else{
            return response()->json(['status' => 'ok'], 200);
        }

    }


    public function signUp(Request $req){

        $this->validate($req, [
            'email' => 'required|email',
            'nombre' => 'required',
            'apellido' => 'required',
            'id_number' => 'required',
            'fecha_nac' => 'required',
            'pass' => 'required'
        ]);


        $user = Student::where('email', $req->input('email'))->orWhere('id_number',$req->input('id_number'))->first();
        if (!is_null($user)){

            $student = new Student();
            $student->nombre = $req->nombre;
            $student->apellido = $req->apellido;
            $student->id_number = $req->id_number;
            $student->fecha_nac = $req->fecha_nac;
            $student->pass = Hash::make($req->pass);

            $student->save();

            return response()->json(['status' => 'ok', 'message'=>'usuario creado con éxito']);

        }else{
            return response()->json(['status' => 'error','message'=>'El email o la cédula ya se encuentra registrada'],422);
        }



    }


}
