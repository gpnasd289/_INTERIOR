<?php

namespace App\Http\Controllers;

use App\Http\Requests\CreateBlogRequest;
use App\Models\Blog;
use App\Models\Tag;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;
class BlogController extends Controller
{
    public function index() {
        $route_prefix = "admin.blog";
        $list = Blog::paginate(10);
        return view('admin.blog.view',compact(['route_prefix','list']));
    }

    public function create() {
        return view('admin.blog.create');
    }

    public function store(CreateBlogRequest $request) {
        $blog = Blog::create([
            'title' => $request -> title,
            'description' => $request -> description,
            'slug'  => Str::slug($request->title),
            'author'    => $request-> author,
            'content'   => $request -> content,
            'thumbnail' => $request -> file_1,
        ]);
        $blog->save();
        if ($blog) {
            return redirect() -> route('admin.blog.list') -> with('createSuccess','Tạo mới bài viết thành công');
        } else {
            return redirect() -> back()-> with('error','Lỗi không tạo mới được bài viết');
        }
    }

    public function edit($id) {
        $blog = Blog::find($id);
        return view('admin.blog.edit', compact(['blog']));
    }

    public function update(Request $request) {
        $form_data = collect($request -> all()) -> except(['file_1', '_token']);

        $form_data = $form_data -> merge(['thumbnail' => $request -> file_1 ]);
        
        $blog = DB::table('blog') -> update($form_data -> toArray());
        if ($blog) {
            return redirect() -> route('admin.blog.list') -> with('createSuccess','Tạo mới bài viết thành công');
        } else {
            return redirect() -> back()-> with('error','Lỗi không tạo mới được bài viết');
        }
    }

    public function delete($id) {
        try {
            $product = Blog::find($id);
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
    public function store_tag(Request $request) {
        $data = $request -> all();
        $tag = Tag::create($data);
        $tag -> save();
        return redirect() -> route('admin.blog.list') -> with('createSuccess','Tạo mới thẻ thành công');
    }
    
    public function create_tag() {
        return view('admin.blog.create_tag');
    }
}
