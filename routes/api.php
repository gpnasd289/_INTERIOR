<?php

use App\Http\Controllers\StatisticController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::get('statistic/bill-sum-by-month',[StatisticController::class,'get_sum_bill_month'])-> name("statistic.get_sum_bill_month");
Route::get('statistic/get-bill-status',[StatisticController::class,'get_bill_status'])-> name("statistic.get_bill_status");