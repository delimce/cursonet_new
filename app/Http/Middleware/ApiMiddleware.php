<?php

namespace App\Http\Middleware;

use App\Models\Cn2\Student;
use Closure;
use \Illuminate\Http\Request;

class ApiMiddleware
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request $request
     * @param  \Closure $next
     * @return mixed
     */
    public function handle($request, Closure $next)
    {
        $token = $request->header('Authorization');
        if (!$token) {
            return response()->json(['status' => 'error', 'message' => trans('commons.error.401.title')], 401);
        } else {
            $user = Student::where("token", $token)->first();
            if (!isset($user->id))
                return response()->json(['status' => 'error', 'message' => trans('commons.error.401.token')], 401);
        }
        return $next($request);
    }
}
