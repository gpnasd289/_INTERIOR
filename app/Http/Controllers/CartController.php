<?php

namespace App\Http\Controllers;

use App\Models\Bill;
use App\Models\BillDetail;
use App\Models\Category;
use App\Models\Product;
use Illuminate\Http\Request;
use Gloudemans\Shoppingcart\Facades\Cart;
use Illuminate\Support\Facades\Auth;

class CartController extends Controller
{
    public static function loadUserCart($user_id) {
        $bill = Bill::where('buyer', $user_id) -> where('bill_type', 2)-> first();
        if ($bill) {
            $bill_detail = BillDetail::where('bill_id', $bill -> ID); 
            foreach($bill_detail as $item) {
                Cart::instance('shopping')->add($item->product_id, $item -> product() -> name , $item -> quantity, $item->price)->associate('App\Models\Product');
            }
        }
    }

    public function index() {
        $category = Category::all();
        return view('client.cart.view',compact(['category']));
    }

    public function add(Request $request) {
        $product = Product::find($request -> id);
        if ($product -> quantity < $request -> qty) {
            return response() -> json([
                'code'      => '201',
                'message'   => 'Error',
                'data'      => [
                    'message'   => 'Số lượng sản phẩm trong cửa hàng không đủ đáp ứng',
                ],
            ]);
        }
        Cart::instance('shopping')->add($product->ID, $product-> name, $request -> qty, $product->price_sell)->associate('App\Models\Product');
        if (Auth::guard('client')->id()) {
            $bill = Bill::where('buyer', Auth::guard('client')->id()) -> where('bill_type', 2) -> first();
            if (!$bill) {
                $bill = Bill::create([
                    'buyer' => Auth::guard('client')->id(),
                    'bill_type'  => 2
                ]);
                $bill -> save();
            }

            $cart = Cart::instance('shopping');

            foreach($cart->content() as $item) {
                $billdetail = BillDetail::where('bill_id', $bill -> ID) -> where('product_id', $item -> id) -> first();
                if ($billdetail) {
                    $billdetail -> quantity = $item -> qty;
                    $billdetail -> save();
                } else {
                    BillDetail::insert([[
                        'bill_id' => $bill -> ID,
                        'product_id' => $item -> id,
                        'quantity' => $item -> qty,
                        'price' => $item -> price,
                    ]]);
                }
            }
        }
        return response() -> json([
            'code'      => '200',
            'message'   => 'Success',
            'data'      => [
                'message'   => 'Thêm sản phẩm thành công',
                'minicart_view'  => view('client.layouts.minicart') -> render(),
                'count' => Cart::instance('shopping') -> content() -> count(),
                'total'     => Cart::instance('shopping') -> subtotal(),

            ],
        ]);
    }

    public function delete(Request $request) {
        Cart::instance('shopping')->remove($request -> id);
        $bill = Bill::where('buyer', Auth::guard('client')->id()) -> where('bill_type', 2) -> first();
        if (!$bill) {
            $bill = Bill::create([
                'buyer' => Auth::guard('client')->id(),
                'bill_type'  => 2
            ]);
            $bill -> save();
        }
        $cart = Cart::instance('shopping');

        foreach($cart->content() as $item) {
            if ($item -> rowId ==  $request->id) {
                $billdetail = BillDetail::where('bill_id',Auth::guard('client')->id()) -> where('product_id',$item-> model -> ID) -> first();
                $billdetail -> delete();
                $billdetail -> save();
            }
        }

        return response() -> json([
            'code' => 200,
            'message' => 'Delete success',
            'data' => [
                'message'   => 'delete_successs',
                'count' => Cart::instance('shopping') -> content() -> count(),
                'total'     => Cart::instance('shopping')->subtotal(),
                'minicart_view'  => view('client.layouts.minicart') -> render(),
            ],
        ]);
    }

    public function update(Request $request) {
        Cart::instance('shopping')->update($request->rowId, $request-> qty);
        $bill = Bill::where('buyer', Auth::guard('client')->id()) -> where('bill_type', 2) -> first();
        if (!$bill) {
            $bill = Bill::create([
                'buyer' => Auth::guard('client')->id(),
                'bill_type'  => 2
            ]);
            $bill -> save();
        }
        $cart = Cart::instance('shopping');

        foreach($cart->content() as $item) {
            if ($item -> rowId ==  $request->rowId) {
                $billdetail = BillDetail::where('bill_id', $bill -> ID) -> where('product_id', $item -> id) -> first();
                if ($billdetail) {
                    $billdetail -> quantity =  $item -> qty;
                    $billdetail -> save();
                } else {
                    BillDetail::insert([[
                        'bill_id' => $bill -> ID,
                        'product_id' => $item -> id,
                        'quantity' => $item -> qty,
                        'price' => $item -> price,
                    ]]);
                }
            }
        }
        return response() -> json([
            "code" => 200,
            "message" => "Cập nhật thành công",
            "data" => [
                "price" => number_format((float)str_replace(".","",$request->price)* $request-> qty,0,'','.')
            ]
        ]);
    }

    public function clearCart() {
        Cart::instance('shopping')->destroy();

        $bill = Bill::where('buyer', Auth::guard('client')->id()) -> where('bill_type', 2) -> first();
        $billDetail = BillDetail::where('bill_id', $bill -> ID) -> get();
        
        foreach ($billDetail as $detail ) {
            $detail -> delete();
        } 

        return response() -> json([
            'code' => 200,
            'message' => 'success',
            'data' => [
                'message'   => 'clear_successs',
                'count' => Cart::instance('shopping') -> content() ->count(),
                'total'     => Cart::instance('shopping')->subtotal(),
                'minicart_view'  => view('client.layouts.minicart') -> render()   
            ]
        ]);
    }

    public function minicart() {
        return view('client.layouts.minicart');
    }

    public function addWishList(Request $request) {
        $product = Product::find($request -> id);
        Cart::instance('wishlist')->add($product->ID, $product-> name, $request -> qty, $product->price_sell)->associate('App\Models\Product');
        return response() -> json([
            'code'      => '200',
            'message'   => 'Success',
            'data'      => [
                'message'   => 'add_successs',
                'minicart_view'  => view('client.layouts.minicart') -> render(),
                'count' => Cart::instance('wishlist') -> content() -> count(),
                'total'     => Cart::instance('wishlist') -> subtotal(),
            ],
         
        ]);
    }
}
