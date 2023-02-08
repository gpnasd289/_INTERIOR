<?php

namespace App\Http\Controllers;

use App\Models\Category;
use App\Models\Material;
use App\Models\Prod_Specification;
use App\Models\Product;
use App\Models\Specification_Type;
use App\Models\Specifications;
use Exception;
use App\Http\Requests\createProduct;
use Illuminate\Http\Request;
use Illuminate\Support\Str;
class ProductController extends Controller
{
    public static function getFileName($file_path) {
        $arr_string = explode('/',$file_path);
        array_shift($arr_string); 
        array_shift($arr_string); 
        array_shift($arr_string); 
        return join('/', $arr_string);
    }

    public function index() {
        $list = Product::getAllProduct();
        $route_prefix = "admin.product";
        return view('admin.product.view',compact(['list','route_prefix']));
    }

    public function product_detail($id) {
        $product = Product::find($id);
        $category = Category::all();
        $silbingColor = $product -> getSiblingColor();
        $relevent_product = Product::where('product_category', $product->product_category) -> where('ID', '!=', $id) ->get();
        return view('client.product_detail.view', compact(['product','category','relevent_product','silbingColor']));
    }

    public function create() {
        $preview = null;
        $specification_type = Specification_Type::all();
        $specification_image        = [];
        $specification_color        = [];
        $specification_promotion    = [];
        $specification_material     = [];
        $material = Material::all();
        foreach ($specification_type as $type) {
            if ($type -> type == "image") {
                array_push($specification_image, $type);
            } 

            if ($type -> type == "color") {
                array_push($specification_color, $type);
            } 

            if ($type -> type == "promotion") {
                array_push($specification_promotion, $type);
            } 

            if ($type -> type == "material") {
                array_push($specification_material, $type);
            } 
        }
        $option = Category::getTree();
        $product_parent = Product::getTree();
        return view('admin.product.create',compact(['option',
        'specification_image',
        'specification_color',
        'specification_promotion' ,
        'specification_material','material','preview','product_parent']));
    }

    public function store(createProduct $request) {
        $valid = $this -> validate($request,  [
                'name'        => 'required',
                'description' => 'required',
                'price_entry'             => 'required',
                'price_sell'       => 'required',
                'price_sale'          => 'required',
                'quantity'          => 'required',
                'display_state'          => 'required',
                'product_category'          => 'required|integer',
                'material'          => 'required'
        ],[
            'product_category.integer' => "Loại sản phẩm không được để trống",
            'material.required' => 'Chất liệu không được để trống',
            'display_state.required' => 'Trạng thái hiển thị không được để trống',
            'quantity.required' => 'Số lượng không được để trống',
            'price_entry.required'   => 'Giá nhập không được để trống',
            'price_sell.required'    => 'Giá bán không được để trống',
            'price_sale.required'    => 'Giá khuyến mãi không được để trống',
            'name.required' => 'Tên không được để trống',
            'description.required' => 'Mô tả không được để trống'
        ]
        );

        $specificationType = Specification_Type::all();
        $image_1_id                 = $specificationType -> where('name','=','image_1') -> first() -> ID;
        $image_2_id                 = $specificationType -> where('name','=','image_2') -> first() -> ID;
        $image_3_id                 = $specificationType -> where('name','=','image_3') -> first() -> ID;
        $image_with_background_id   = $specificationType -> where('name','=','image_with_background') -> first() -> ID;
        $image_no_background_id     = $specificationType -> where('name','=','image_no_background') -> first() -> ID;
        $color_id                   = $specificationType -> where('name','=','color') -> first() -> ID;
        $material_id                = $specificationType -> where('name','=','material') -> first() -> ID; 
        if ($request -> product_parent == "NULL") {
            unset($request['product_parent']);
        }
        $data = $request -> all();
        $product = Product::create($data);
        $product -> slug =  Str::slug($product->title.' '. $product -> ID);
        $product->save();
        $specification_image_1 = Specifications::create([
            'specification_type' => $image_1_id,
            'value'              => ProductController::getFileName($request -> file_1)
        ]);
        $specification_image_2 = Specifications::create([
            'specification_type' => $image_2_id,
            'value'              => ProductController::getFileName($request -> file_2)
        ]);
        
        $specification_image_3 = Specifications::create([
            'specification_type' => $image_3_id,
            'value'              => ProductController::getFileName($request -> file_3)
        ]);
    
        $specification_image_with_background = Specifications::create([
            'specification_type' => $image_with_background_id,
            'value'              => ProductController::getFileName($request -> file_4)
        ]);
        
        $specification_image_no_background = Specifications::create([
            'specification_type' => $image_no_background_id ,
            'value'              => ProductController::getFileName($request -> file_5)
        ]);

        $specification_color = Specifications::create([
            'specification_type' => $color_id,
            'value'              => $request -> color
        ]);

        $specification_material = Specifications::create([
            'specification_type' => $material_id,
            'value'              => $request -> material
        ]);

        $specification_image_1                  -> save();
        $specification_image_2                  -> save();
        $specification_image_3                  -> save();
        $specification_image_with_background    -> save();
        $specification_image_no_background      -> save();
        $specification_color                    -> save();
        $specification_material                 -> save();

        $product_specification = Prod_Specification::insert([[
            'productID' => $product->ID,
            'specificationID' => $specification_image_1 -> ID
        ],[
            'productID' => $product->ID,
            'specificationID' => $specification_image_2 -> ID
        ],[
            'productID' => $product->ID,
            'specificationID' => $specification_image_3 -> ID
        ],[
            'productID' => $product->ID,
            'specificationID' => $specification_image_with_background -> ID
        ],[
            'productID' => $product->ID,
            'specificationID' => $specification_image_no_background -> ID
        ],[
            'productID' => $product->ID,
            'specificationID' => $specification_color -> ID 
        ],[
            'productID' => $product->ID,
            'specificationID' => $specification_material -> ID
        ]]);

        if($product_specification) {
            return redirect() -> route('admin.product.list') -> with('createSuccess','Create success');
        } else {
            return redirect() -> route('admin.product.list') -> with('createFail','Fail to create');
        }
    }

    public function edit($id) {
        $product = Product::getProductById($id);
        $option  = Category::getTree();
        $specification_type = Specification_Type::all();
        $specification_image        = [];
        $specification_color        = [];
        $specification_promotion    = [];
        $specification_material     = [];

        foreach ($specification_type as $type) {
            if ($type -> type == "image") {
                array_push($specification_image, $type);
            } 

            if ($type -> type == "color") {
                array_push($specification_color, $type);
            } 

            if ($type -> type == "promotion") {
                array_push($specification_promotion, $type);
            } 

            if ($type -> type == "material") {
                array_push($specification_material, $type);
            } 
        }

        $selected_category = $product -> product_category;
        return view('admin.product.edit', compact(['product','option','selected_category','specification_image',
                                                                                            'specification_color',
                                                                                            'specification_promotion' ,
                                                                                            'specification_material']));
    }

    public function update(Request $request) {
        $specificationType = Specification_Type::all();
        $image_1_id                 = $specificationType -> where('name','=','image_1') -> first() -> ID;
        $image_2_id                 = $specificationType -> where('name','=','image_2') -> first() -> ID;
        $image_3_id                 = $specificationType -> where('name','=','image_3') -> first() -> ID;
        $image_with_background_id   = $specificationType -> where('name','=','image_with_background') -> first() -> ID;
        $image_no_background_id     = $specificationType -> where('name','=','image_no_background') -> first() -> ID;
        $color_id                   = $specificationType -> where('name','=','color') -> first() -> ID;
        $material_id                = $specificationType -> where('name','=','material') -> first() -> ID; 
        $product = Product::find($request -> ID);
        $product -> name = $request -> name;
        $product -> product_category = $request -> category;
        $product -> description = $request -> description;
        $product -> content_review = $request -> review_content;
        $product -> price_entry = $request -> price_entry;
        $product -> price_sell = $request -> price_sell;
        $product -> quantity = $request -> quantity;
        $product -> status = $request -> status;
        $product -> display_state = $request -> display_state;
        $product->save();
        
        $product ->  specification -> where('specificationType.ID', $image_1_id) -> first() -> value                =  ProductController::getFileName($request -> file_1);
        $product ->  specification -> where('specificationType.ID', $image_2_id) -> first() -> value                =  ProductController::getFileName($request -> file_2);
        $product ->  specification -> where('specificationType.ID', $image_3_id) -> first() -> value                =  ProductController::getFileName($request -> file_3);
        $product ->  specification -> where('specificationType.ID', $image_with_background_id) -> first() -> value  =  ProductController::getFileName($request -> file_4);
        $product ->  specification -> where('specificationType.ID', $image_no_background_id ) -> first() -> value   =  ProductController::getFileName($request -> file_5);
       
        $product ->  specification -> where('specificationType.ID', $color_id) -> value = $request -> color;
        $product ->  specification -> where('specificationType.ID', $material_id) -> value = $request -> material;
        dd($product ->  specification -> where('specificationType.ID', $image_1_id) -> first() -> value);
        if ($product) {
            return redirect() -> route('admin.product.list') -> with('editSuccess','Chỉnh sửa thành công');
        } else {
            return redirect() -> route('admin.product.list') -> with('error','Có lỗi xảy ra');
        }
    }



    public function delete($id) {
        try {
            $product = Product::find($id);
            $product->delete();
            return response() -> json([
                'code'=> 200,
                'message'=> "Success"
            ]);
        } catch(Exception $e) {
            return response() -> json([
                'code'=> 201,
                'message'=> "Xóa không thành công"
            ]);
        }
    }   


}
