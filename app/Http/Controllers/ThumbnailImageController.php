<?php

namespace App\Http\Controllers;

use App\Models\ThumbnailImage;
use Exception;
use Illuminate\Http\Request;

class ThumbnailImageController extends Controller
{
    public function index() {
        $list = ThumbnailImage::paginate(10);
        $route_prefix = "admin.thumbnail";
        return view('admin.thumbnail_image.view',compact(['list','route_prefix']));
    }

    public function create() {
        return view('admin.thumbnail_image.create');
    }

    public function store(Request $request) {
        $request->validate([
            'file_1' => 'required',
            'status' => 'max:1|min:0|required',
            'position' => 'max:5|min:1|required'
        ],[
            'file_1.required' => 'File không được bỏ trống' 
        ]);
    
        $image = ThumbnailImage::create([
            'file_path' => $request -> file_1,
            'status'    => $request -> status,
            'position'  => $request -> position
        ]);


        $image-> save();
        if($image) {
            return redirect() -> route('admin.thumbnail.list') -> with('createSuccess','Create success');
        } else {
            return redirect() -> route('admin.thumbnail.list') -> with('createFail','Fail to create');
        }
    }

    public function edit($id) {
        $thumbnail = ThumbnailImage::find($id);
        return view('admin.thumbnail_image.edit', compact(['thumbnail']));
    }

    public function update(Request $request) {
        
    }

    public function delete($id) {
        try {
            $product = ThumbnailImage::find($id);
            $product -> delete();
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
}
