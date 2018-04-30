<?php

namespace App\Http\Controllers\Api;

use Laravel\Lumen\Routing\Controller as BaseController;
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
        //
    }

    public function login(Request $req)
    {

        $this->validate($req, [
            'email' => 'required|email',
            'password' => 'required'
        ]);

        return response()->json(['name' => 'Abigail', 'state' => 'CA']);

    }


    public function forgotten(Request $req)
    {

        $this->validate($req, [
            'email' => 'required|email'
        ]);

        return response()->json(['name' => 'Abigail', 'state' => 'CA']);

    }


}
