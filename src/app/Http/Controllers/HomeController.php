<?php

namespace App\Http\Controllers;

use App\Http\Requests\searchRequest;
use App\Models\Blog;
use App\Models\PROCEDURE;
use App\Models\Category;
use App\Models\Product;
use App\Models\ThumbnailImage;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
class HomeController extends Controller
{
    public function index() {  
        CartController::loadUserCart(Auth::guard('client')->id());
        $new_feature    = Product::whereNotNull('product_parent')->where('display_state', 2)->orderBy('created_at','desc')->with('specification')->take(20)->get();
        $most_sell_prod = Product::whereNotNull('product_parent')->where('display_state', 3)->orderBy('created_at','desc')->with('specification')->take(20)->get();
        $comming_soon_prd = Product::whereNotNull('product_parent')->where('display_state', 5)->orderBy('created_at','desc')->with('specification')->take(8)->get();
        $single_image   = ThumbnailImage::where('status', 1) -> where('position', 5) -> first();
        $carosel_image  = ThumbnailImage::where('status', 1) -> where('position', 1) -> first();
        $other_image    = ThumbnailImage::where('status', 1) -> where('position','<', 5)  -> get();

        $chair          = Product::whereNotNull('product_parent')->where('product_category',11) -> take(2)->get();
        $lamp           = Product::whereNotNull('product_parent')->where('product_category',13) -> take(5)->get();
        $ward           = Product::whereNotNull('product_parent')->where('product_category',12) -> take(5)->get();
        $blogs = Blog::orderBy('created_at','desc')->take(8)->get();
        $category = Category::all();
        return view('client.home.view',compact(['ward','lamp','chair','carosel_image','other_image','new_feature','single_image','blogs','comming_soon_prd','category','most_sell_prod']));
    }

    public function search(searchRequest $request) {
        $category = Category::all();
        $products =Product::where('name','like','%'.$request -> keyword.'%')->paginate(20);
        return view('client.search.view',compact(['products','category']));
    }

    public function showBlog($slug) {
        $category = Category::all();
        $blog = Blog::where('slug', $slug) -> first();
        $nextPost = Blog::where('ID', '>' , $blog -> ID) -> first(); 
        $previousPost = Blog::where('ID', '<' , $blog -> ID) -> first();
        $recentPost  = Blog::where('ID','!=',$blog-> ID) -> orderBy('created_at','desc')->take(5)->get();
        return view('client.blog.view',compact(['blog', 'nextPost' , 'previousPost','recentPost','category']));  
    }

    public function contact() { 
        $category = Category::all();
        return view('client.contact.view', compact(['category']));
    }
}
