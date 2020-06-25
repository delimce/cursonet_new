<?php

namespace App\Http\Middleware;

use App\Services\StudentService;
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
    public function handle(Request $request, Closure $next)
    {
        $token = $request->header('Authorization');
        if (!$token) {
            return response()->json(['status' => 'error', 'message' => trans('commons.error.401.title')], 401);
        }
        if (!StudentService::isTokenActive($token)) {
            return response()->json(['status' => 'error', 'message' => trans('commons.error.401.token')], 401);
        }
        return $next($request);
    }
}
