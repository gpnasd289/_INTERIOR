<?php

namespace App\Http\Controllers;

use App\Models\Category;
use App\Models\Product;
use Illuminate\Http\Request;

class ShopController extends Controller
{
    public function index() {
        $products = Product::paginate(Product::max_number_display_page_shop);
        $category = Category::all();
        return view('client.shop.view',compact(['products','category']));
    }


    public function filterByPrice($f) {
        switch ($f) {
            case 'price-ascending':
                $product = Product::orderBy('price_sell','asc')->paginate(Product::max_number_display_page_shop)->get();
                return response()->json([
                    'code' => 200,
                    'message' => 'Success',
                    'data' => [
                        'view' => view('client.shop.list_product',compact(['products' => $product]))->render()
                        ]
                    ]);
            default:
            return response()->json([
                'code' => 200,
                'message' => 'Unknown filter parameter' 
            ]);
        }
    }

    public function shopWithCategory($id) {
        $category = Category::all();
        $products = Product::where('product_category', $id)->paginate(Product::max_number_display_page_shop);
        return view('client.shop.view',compact(['products','category']));
    } 

    public function shopWithProductDisplayType($id) {
        $category = Category::all();
        $products = Product::where('display_state',$id)->paginate(Product::max_number_display_page_shop);
        return view('client.shop.view',compact(['products','category']));
    }

    public function checkout() {
        return view('client.checkout.view');
    }
 }
