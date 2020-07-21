<?php

namespace App\Http\Controllers\Student;

use Laravel\Lumen\Routing\Controller as BaseController;
use Illuminate\Http\Request;
use App\Repositories\StudentRepository;

class InitialController extends BaseController
{
    /**
     * Create a new controller instance.
     * @return void
     */

    private $studentService;

    public function __construct(StudentRepository $student)
    {
        $this->studentService = $student;
    }

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


    /**
     * doLogin
     * login website
     * @param  mixed $req
     * @return void
     */
    public function doLogin(Request $req)
    {
        $email = $req->input('email');
        $pass = $req->input('password');

        $result = $this->studentService->doLogin($email, $pass);

        if (!$result["ok"]) {
            return response()->json(['status' => 'error', 'message' => $result["message"]], 401);
        } else {
            $req->session()->put('myUser', $result["user"]);
            $req->session()->put('userLog', $result["userLog"]);
        }
        return response()->json(['status' => 'ok', 'user' => $result["user"]]);
    }

    public function forgotPassword()
    {
        return view('student.pages.initial.forgotPassword');
    }

    public function register()
    {
        return view('student.pages.initial.register');
    }


    /**
     * userActivate
     * @param  string $apikey
     * @return void
     */
    public function userActivate($apikey)
    {
        $token = trim($apikey);
        $user = $this->studentService->activeUser($token);
        if ($user) {
            return redirect()->route('activated', ['username' => $user->fullname()]);
        }
        return response(view('errors.403'), 403);
    }


    /**
     * userActivatedSuccess
     * @param  mixed $req
     * @return void
     */
    public function userActivatedSuccess(Request $req)
    {
        return view('student.pages.initial.activated', ['username' => $req->username]);
    }


        
    /**
     * restoringPassword
     *
     * @param  string $apikey
     * @return void
     */
    public function restoringPassword($apikey)
    {
        $user = $this->studentService->getUserByToken($apikey);
        if (!$user) { //invalid token
            return response(view('errors.403'), 403);
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
