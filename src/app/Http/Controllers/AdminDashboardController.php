<?php

namespace App\Http\Controllers;
use App\Models\Bill;
use App\Models\Client;
use App\Models\PROCEDURE;
use Illuminate\Http\Request;
use DB;
class AdminDashboardController extends Controller
{
    public function dashboard() {
        $order = Bill::all();
        $customer = Client::all();
        $sum_bill_total_year = DB::select(PROCEDURE::sum_bill_total_year);
        $sum = 0;
        foreach($sum_bill_total_year as $s) {
            $sum = $s;
            break;
        }
        $bill_new = Bill::where('status',1);
        return view('admin.home.dashboard', compact(['order','customer','sum','bill_new']));
    }
}
