<?php

namespace App\Http\Controllers;

use App\Http\Requests\CategoryCreateRequest;
use App\Models\Category;
use Exception;
use Illuminate\Http\Request;

class CategoryController extends Controller
{
    public function index() {
        $list = Category::getAllCategory();
        $route_prefix = "admin.category";
        return view('admin.category.view', compact(['list','route_prefix']));
    }

    public function create() {
        $option = Category::getTree();
        return view('admin.category.create',compact(['option']));
    }

    public function store(CategoryCreateRequest $request) {
        if($request->parent_id == "NULL") {
            $request->request->remove('parent_id');
        }
        $category = Category::create($request->all());
        $category -> save();
        if($category) {
            return redirect() -> route('admin.category.list') -> with('createSuccess','Create new category success');
        } else {
            return redirect() -> route('admin.category.list') -> with('createFail','Fail to create');
        }
    }

    public function edit($id) {
        $data = Category::find($id);
        $option = Category::getTree();
        $selected = $data -> parent_id ?? -1;
        
        return view('admin.category.edit',compact(['data','option','selected']));
    }

    public function update(CategoryCreateRequest $request) {
        $category = Category::find($request->id);
        if($request->parent_id == "NULL") {
            $request->request->remove('parent_id');
        } else {
            $category -> parent_id = $request -> parent_id;
        }
        $category -> description = $request -> description;
        $category -> name        = $request -> name;
        $category -> status      = $request -> status;
        $category -> save();
        if($category) {
            return redirect() -> route('admin.category.list') -> with('createSuccess','Create new category success');
        } else {
            return redirect() -> route('admin.category.list') -> with('createFail','Fail to create');
        }
    }

    public function delete($id) {
        try {
            $category = Category::find($id);
            $category->delete();
            return response() -> json([
                'code'=> 200,
                'message'=> "Success"
            ]);
        } catch(Exception $e) {
            return response() -> json([
                'code'=> 201,
                'detail' => $e,
                'message'=> "Error"
            ]);
        }
    }
}
