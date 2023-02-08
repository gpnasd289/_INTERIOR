<?php

namespace App\Http\Controllers;

use App\Models\PROCEDURE;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class StatisticController extends Controller
{
    public function get_sum_bill_month() {
        $sum_bill_total_year = DB::select(PROCEDURE::sum_bill_total_year);
        $sum = 0;
        foreach($sum_bill_total_year as $s) {
            $sum = $s;
            break;
        }
        return response() -> json([
            'statistic' => $sum
        ]);
    }


    public function get_bill_status() {
        $bill_status = DB::select(PROCEDURE::get_bill_status);
        $sum = 0;
        foreach($bill_status as $s) {
            $sum = $s;
            break;
        }
        return response() -> json([
            'statistic' => $sum
        ]);

    }
}
