<?php

namespace App\Http\Controllers;
use App\Services\PayPalService;
use App\Jobs\SendEmail;
use App\Models\Bill;
use App\Models\BillDetail;
use App\Models\Client;
use App\Models\MailType;
use App\Models\Promotion;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Barryvdh\DomPDF\Facade\Pdf;
use Carbon\Carbon;
use Exception;
use Gloudemans\Shoppingcart\Facades\Cart;
use Illuminate\Support\Carbon as SupportCarbon;

class BillController extends Controller
{
    public function index() {
        $list = Bill::paginate(15);
        $route_prefix = Bill::route_prefix;
        $bill = Bill::find(48);
        // dd($bill -> bill_detail());
        return view('admin.bill.view',compact(['list','route_prefix']));
    }

    public function detail($id) {
        $bill = Bill::find($id);
        if (isset($bill)) {
            return response() -> json([
                'code' => 200,
                'message' => 'Success',
                'data' => [
                    'products' => $bill -> bill_detail()
                ]
            ]);
        } else {
            return response() -> json([
                'code' => 201,
                'message' => 'Fail to get Data',
                'data' => [
                    
                ]
            ]);
        }
    }

    public function process_checkout(Request $request) {
        $data = $request -> all();
        $data['buyer'] = Auth::guard('client')->id();
        $cart = Cart::instance('shopping');
        $valid_products = [];
        if ($data['promotion_title']) {
            $promotion = Promotion::where('title', $data['promotion_title']) -> first();
            $valid_products = $promotion -> getValidProduct_ForPromotion($cart ->content() -> toArray());
            $valid_products = array_map(function ($item) {
                return $item['id'];
            }, $valid_products);
            $data['total'] = (float)str_replace('.','',$cart->subtotal()) - $promotion -> getDiscount($cart ->content() -> toArray());
        }else {
            $data['total'] = (float)str_replace('.','',$cart->subtotal());
        }

        $bill = Bill::create($data);
        $bill-> payment_type = $request -> payment_method;
        foreach($cart->content() as $item) {
            if (in_array($item -> id, $valid_products)){
                BillDetail::insert([[
                    'bill_id' => $bill -> ID,
                    'product_id' => $item -> id,
                    'quantity' => $item -> qty,
                    'price' => $item -> price,
                    'promotion_title' => $data['promotion_title']
                ]]);
            } else {
                BillDetail::insert([[
                    'bill_id' => $bill -> ID,
                    'product_id' => $item -> id,
                    'quantity' => $item -> qty,
                    'price' => $item -> price,
                ]]);
            }
        }
        $bill -> save();

        if ($request -> payment_method == 2) {
            // thanh toán paypal
            // account : mim.bussiness@personal.com
            // password : testpaypal
            $bill -> payment_type = 2;
            $bill -> save();
            return response() -> json([
                'code' => 200,
                'type' => 'paypal',
                'messages' => 'Thanh toán thành công',
                'route' => route('processTransaction',['billid' => $bill -> ID, 'total' => 1]),
            ]);
        }
        // Gửi mail đến khách hàng
        $user = Client::where('ID', Auth::guard('client')->id())->get();
        
        SendEmail::dispatch( $bill ,   $user  , MailType::SubmitPayment);
        // Xóa tất cả sản phẩm khỏi giỏ hàng
        Cart::instance('shopping')->destroy();

        return response() -> json([
            'code' => 200,
            'messages' => 'Thanh toán thành công',
            'data' => [
                'route' => route('home')
            ] 
        ]);
    }

    public function edit($id) {
        $data = Bill::find($id);
        return view('admin.bill.edit',compact(['data']));
    }

    public function update(Request $request) {
        $bill = Bill::find($request -> id);
        $bill -> status = $request -> status;
        $bill -> save();
        return redirect() -> route('admin.bill.list');
    }

    public function updateCancelBill(Request $request) {
        $bill = Bill::find($request -> id);
        $bill -> status = 7;
        $bill -> save();

        return response() -> json([
            'success' => $bill
        ]);
    }

    public function pdf($id) {
        $bill = Bill::find($id);
        $today = SupportCarbon::now();
        return view('admin.pdf.bill_history',compact('bill','today'));
    }


    public function clientPDF($id) { 
    
        $bill = Bill::find($id);
        $today = SupportCarbon::now();
        return view('client.pdf.bill_history',compact('bill','today'));
    }


    function currencyConverter($currency_from, $currency_to, $currency_input) {
        $yql_base_url = "http://query.yahooapis.com/v1/public/yql";
        $yql_query = 'select * from yahoo.finance.xchange where pair in ("' . $currency_from . $currency_to . '")';
        $yql_query_url = $yql_base_url . "?q=" . urlencode($yql_query);
        $yql_query_url .= "&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys";
        $yql_session = curl_init($yql_query_url);
        curl_setopt($yql_session, CURLOPT_RETURNTRANSFER, true);
        $yqlexec = curl_exec($yql_session);
        $yql_json =  json_decode($yqlexec, true);
        $currency_output = (float) $currency_input * $yql_json['query']['results']['rate']['Rate'];
    
        return $currency_output;
    }
}
