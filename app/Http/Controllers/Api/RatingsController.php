<?php

namespace App\Http\Controllers\Api;

use App\Models\Cn2\Plan;
use App\Models\Cn2\PlanItemStudent;
use Laravel\Lumen\Routing\Controller as BaseController;
use Illuminate\Http\Request;
use App\Models\Cn2\Student;
use DB;

class RatingsController extends BaseController
{
    private $student;

    /**
     * Create a new controller instance.
     * @return void
     */
    public function __construct(Request $req)
    {
        $token = $req->header('Authorization');
        $this->student = Student::where("token", $token)->first();
    }

    public function list()
    {
        $plans = Plan::join('tbl_grupo_estudiante', 'tbl_plan_evaluador.grupo_id', '=', 'tbl_grupo_estudiante.grupo_id')
            ->with('group')
            ->with('items')
            ->whereEstId($this->student->id)->get();

        return response()->json(['status' => 'ok', 'list' => $plans]);
    }

    public function getDetail(int $planId)
    {
        $planDetail = [];
        $detail = Plan::findOrFail($planId);
        $detail->with('group')->with('items')->get();

        $planDetail["name"] = $detail->titulo;
        $planDetail["group"] = $detail->group->nombre;
        $planDetail["course"] = $detail->group->course->nombre;
        $planDetail["items"] = array_map(function ($item) {
            $itemPlan =
                [
                    "name" => $item['titulo'],
                    "base" => $item['en_base'],
                    "percent" => $item['porcentaje'],
                    "type" => $item['tipo'],
                    "rating" => PlanItemStudent::whereEstId($this->student->id)->whereItemId($item['id'])->first()
                ];
            return $itemPlan;
        }, $detail->items->toArray());

        return response()->json(['status' => 'ok', 'detail' => $planDetail]);
    }
}
