<?php

namespace App\Http\Controllers;

use App\Http\Requests\PromotionCreateRequest;
use App\Models\Category;
use App\Models\Category_Promotion;
use App\Models\Product;
use App\Models\Product_Promotion;
use App\Models\Promotion;
use DateTime;
use Exception;
use Illuminate\Http\Request;
use Gloudemans\Shoppingcart\Facades\Cart;

class PromotionController extends Controller
{
    public function index() {
        $route_prefix = "admin.promotion";
        $list = Promotion::paginate(15);
        return view('admin.promotion.view',compact(['route_prefix','list']));
    }
 
    public function create() { 
        $product = Product::getAllProduct();
        $category = Category::getAllCategory();
        return view('admin.promotion.create', compact(['product','category']));
    }

    public function store(PromotionCreateRequest $request) {
        $data = $request -> all();

        if ($data['promotion_condition'] == 1) {
            $data['condition_value'] =  $request -> condition_value_lowest_bill;
        } 
        else if ($data['promotion_condition']  == 2) {
            $data['condition_value'] = $request -> condition_value_minimum_money;
        } 
        else if ($data['promotion_condition']  == 3) {
            $data['condition_value'] = $request -> condition_value_minimum_product;
        } 
        $promotion = Promotion::create($data);
        $promotion -> save();
        if ( isset($request -> promotion_product_apply_value) ) {
            $product_ID  = explode(',', $request -> promotion_product_apply_value);
            foreach ($product_ID as $id) {
                Product_Promotion::insert([[
                    'promotionID'=> $promotion -> ID,
                    'productID' => $id
                ]
                ]);
            }
        } else if( isset($request -> promotion_category_apply_value)) {
            $category_ID = explode(',', $request -> promotion_category_apply_value);
            foreach ($category_ID as $id) {
                Category_Promotion::insert([[
                    'promotionID'=> $promotion -> ID,
                    'categoryID' => $id
                ]
             ]);
            }
        }
        if($promotion) {
            return redirect() -> route('admin.promotion.list') -> with('createSuccess','Create success');
        } else {
            return redirect() -> back() -> with('errors','Fail to create');
        }
    }

    public function edit($id) {
        $promotion = Promotion::find($id);
        $product = Product::getAllProduct();
        $category = Category::getAllCategory();
        return view('admin.promotion.edit', compact(['promotion','product','category']));
    }

    public function update(PromotionCreateRequest $request) {
        // $promotion = Promotion::createOrUpdate([
        //     'title' => $request-> title,
        //     'description' => $request -> description,
        //     'promotion_apply' => $request -> promotion_apply,
        //     'status'    => $request -> status,
        //     'promotion_condition' => $request -> promotion_condition,
        //     'quantity'  => $request -> quantity,
        //     'start_date' => $request -> start_date,
        //     'end_date'  => $request -> end_date,
        // ]);
        // if ($promotion -> promotion_condition == 1) {
        //     $promotion -> condition_value =  $request -> condition_value_lowest_bill;
        // } 
        // else if ($promotion -> promotion_condition == 2) {
        //     $promotion -> condition_value = $request -> condition_value_minimum_money;
        // } 
        // else if ($promotion -> promotion_condition == 3) {
        //     $promotion -> condition_value = $request -> condition_value_minimum_product;
        // } else {
        //     $promotion -> condition_value = null;
        // }

        // $promotion -> save();
        // if ( isset($request -> promotion_product_apply_value) ) {
        //     $product_ID  = explode(',', $request -> promotion_product_apply_value);
        //     foreach ($product_ID as $id) {
        //         Product_Promotion::insert([[
        //             'promotionID'=> $promotion -> ID,
        //             'productID' => $id
        //         ]
        //         ]);
        //     }
        //     Category_Promotion::where('promotionID', $promotion -> ID) -> delete();
        // } else if( isset($request -> promotion_category_apply_value)) {
        //     $category_ID = explode(',', $request -> promotion_category_apply_value);
        //     foreach ($category_ID as $id) {
        //         Category_Promotion::insert([[
        //             'promotionID'=> $promotion -> ID,
        //             'categoryID' => $id
        //         ]]);
        //     }
        //     Product_Promotion::where('promotionID', $promotion -> ID) -> delete();
        // }
        // if($promotion) {
        //     return redirect() -> route('admin.promotion.list') -> with('createSuccess','Create success');
        // } else {
        //     return redirect() -> back() -> with('errors','Fail to create');
        // }
    }

    public function delete($id) {
        try {
            $product = Promotion::find($id);
            $product->delete();
            return response() -> json([
                'code'=> 200,
                'message'=> "Success"
            ]);
        } catch(Exception $e) {
            return response() -> json([
                'code'=> 201,
                'message'=> "Error"
            ]);
        }
    } 


    public function apply_promotion(Request $request) {
        $promotion = Promotion::where('title', $request -> voucher) -> first();
     
        $cart = Cart::instance('shopping');
        $valid_product = [];
        $discount_value = 0;

        if(!isset($promotion)) {
            return response() -> json([
                'code' => 201,
                'message' => 'Mã giảm giá không tồn tại',
                'data' => []
            ]);
        }

        if ($promotion -> status == 0) {
            return response() -> json([
                'code' => 201,
                'message' => 'Mã giảm giá không còn khả dụng',
                'data' => []
            ]);
        }

        $now = new DateTime();
        $startdate = new DateTime($promotion -> start_date);
        $enddate = new DateTime($promotion -> end_date);

        if($startdate <= $now && $now >= $enddate) {
            return response() -> json([
                'code' => 201,
                'message' => 'Mã giảm giá đã hết hạn sử dụng',
                'data' => []
            ]);
        }
        // CHECK CONDITION
        // Giá trị đơn hàng phải lớn hơn giá trị yêu cầu
        if ($promotion -> promotion_condition == 1) {
      
            if ($request -> billTotal < $promotion -> condition_value) {
                return response() -> json([
                    'code' => 201,
                    'message' => 'Đơn hàng không đáp ứng đủ điều kiện sử dụng mã giảm giá',
                    'data' => []
                ]);
            } else {
                return response() -> json([
                    'code' => 200,
                    'message' => 'Áp dụng thành công',
                    'data' => [   
                        'discount_type'   => $promotion -> discount_type_string(),
                        'discount_value'  => $promotion -> discount_value,
                        'discount_price'  => $promotion -> getDiscount($cart ->content() -> toArray()),
                        'promotion_title' => $promotion -> title,
                        'checkout_total'  => (float)str_replace('.','',$cart->subtotal()) - $promotion -> getDiscount($cart ->content() -> toArray())]
                ]); 
            }
        }

        // Đơn hàng chỉ được có 1 số lượng sản phẩm nhất định
        if ($promotion -> promotion_apply == 1) {
            return response() -> json([
                'code' => 200,
                'message' => 'Thêm mã giảm giá thành công',
                'data' => [
                    'discount_type'   => $promotion -> discount_type_string(),
                    'discount_value'  => $promotion -> discount_value,
                    'discount_price'  => $promotion -> getDiscount($cart ->content() -> toArray()),
                    'promotion_title' => $promotion -> title,
                    'checkout_total'  => (float)str_replace('.','',$cart->subtotal()) - $promotion -> getDiscount($cart ->content() -> toArray()),
                ]
            ]);
        }

        // Mã giảm giá áp dụng cho những sản phẩm thuộc loại sản phẩm
        if ($promotion -> promotion_apply == 2) {            
            return response() -> json([
                'code' => 200,
                'message' => 'Thêm mã giảm giá thành công',
                'data' => [
                    'discount_type'   => $promotion -> discount_type_string(),
                    'discount_value'  => $promotion -> discount_value,
                    'discount_price'  => $promotion -> getDiscount($cart ->content() -> toArray()),
                    'promotion_title' => $promotion -> title,
                    'checkout_total'  => (float)str_replace('.','',$cart->subtotal()) - $promotion -> getDiscount($cart ->content() -> toArray()),
                ]
            ]); 
        }
        
        // Mã giảm giá áp dụng cho những sản phẩm nhất định
        if ($promotion -> promotion_apply ==  3) {           
            return response() -> json([
                'code' => 200,
                'message' => 'Thêm mã giảm giá thành công',
                'data' => [
                    'discount_type'   => $promotion -> discount_type_string(),
                    'discount_value'  => $promotion -> discount_value,
                    'discount_price'  => $promotion -> getDiscount($cart ->content() -> toArray()),
                    'promotion_title' => $promotion -> title,
                    'checkout_total'  => (float)str_replace('.','',$cart->subtotal()) - $promotion -> getDiscount($cart ->content() -> toArray()),
                ]
            ]); 
        }
    }
    



}
