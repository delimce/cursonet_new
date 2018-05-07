<?php

namespace App\Http\Controllers\Api;

use Laravel\Lumen\Routing\Controller as BaseController;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Mail;
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

    /**string for student token
     * @return string
     */
    static function newUserToken(){
        return md5(str_random(40));
    }

    public function login(Request $req)
    {

        $this->validate($req, [
            'email' => 'required|email',
            'password' => 'required'
        ]);

        $user = Student::where('email', $req->input('email'))->first();
        if (is_null($user))
            return response()->json(['status' => 'error', 'message' => 'Email desconocido'], 401);

        if (!$user->activo) {
            return response()->json(['status' => 'fail', 'message' => 'Disculpe, su usuario no está habilitado.'], 401);
        } else if (Hash::check($req->input('password'), $user->pass)) {
            $apikey = $this->newUserToken();
            Student::where('email', $req->input('email'))->update(['token' => "$apikey"]);
            return response()->json(['status' => 'ok', 'token' => $apikey]);
        } else {
            return response()->json(['status' => 'fail', 'message' => 'el password no es correcto'], 401);
        }
    }


    public function forgotten(Request $req)
    {
        $this->validate($req, [
            'email' => 'required|email'
        ]);

        $user = Student::where('email', $req->input('email'))->first();

        if (!is_null($user)) {
            $apikey = $this->newUserToken();
            Student::where('email', $req->input('email'))->update(['token' => "$apikey"]);
            Mail::send('student.emails.forgotten', ["user" => $user, "token" => $apikey], function ($m) use ($user) {
                $m->to($user->email, $user->nombre . ' ' . $user->apellido)->subject('Recordatorio de contraseña');
            });
            return response()->json(['status' => 'ok', 'message' => 'Se ha enviado un Email de recuperación al recipiente:' . $user->email]);
        } else {
            return response()->json(['status' => 'error', 'message' => 'Email desconocido'], 401);
        }

    }


    public function restorePassword(Request $req){

        $this->validate($req, [
            'token' => 'required',
            'pass' => 'required'
        ]);

        $user = Student::where('token', $req->input('token'))->first();
        if (!is_null($user)) {
            $apikey = $this->newUserToken();
            $newPass =  Hash::make($req->input('pass'));
            Student::where('token', $req->input('token'))->update(['token' => "$apikey","pass"=>$newPass]);

            return response()->json(['status' => 'ok', 'message' => 'cambio de password correctamente']);
        } else {
            return response()->json(['status' => 'error', 'message' => 'token no válido'], 401);
        }

    }


    public function signUp(Request $req)
    {

        $this->validate($req, [
            'email' => 'required|email',
            'nombre' => 'required',
            'apellido' => 'required',
            'id_number' => 'required',
            'fecha_nac' => 'required',
            'pass' => 'required'
        ]);

        $user = Student::where('email', $req->input('email'))->orWhere('id_number', $req->input('id_number'))->first();

        if (is_null($user)) {

            $student = new Student();
            $student->nombre = $req->input('nombre');
            $student->apellido = $req->input('apellido');
            $student->id_number = $req->input('id_number');
            $student->email = $req->input('email');
            $student->fecha_nac = $req->input('fecha_nac');
            $student->pass = Hash::make($req->input('pass'));
            $student->token = $this->newUserToken(); ///for email

            $student->save();

            Mail::send("student.emails.registered", ["user" => $student, "token" => $student->token], function ($m) use ($student) {

                $m->to($student->email, $student->nombre . " " . $student->apellido)->subject('Usuario registrado en Cursonet');
            });

            return response()->json(['status' => 'ok', 'message' => 'usuario creado con éxito']);

        } else {
            return response()->json(['status' => 'error', 'message' => 'El email o la cédula ya se encuentra registrada'], 422);
        }


    }


}
