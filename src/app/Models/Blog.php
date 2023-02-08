<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Blog extends Model
{
    use HasFactory;
    protected $primaryKey   = "ID"; 
    protected $table        = "blog";
    protected $fillable = [
        'author',
        'title',
        'content',
        'description',
        'edited_by',
        'thumbnail',
        'slug',
    ];

    public function authorPost() {
        return $this->belongsTo(Employee::class,'author','ID');
    }


    public static function createRule() {
        return [
            'title' => 'required|max:255',
            'description' => 'required|max:255',
            'file_1'    => 'required',
            'content'   => 'required',
            'author'    => 'required'
        ];
    }

    public static function messages() {
        return [
            'title.required' => 'Tiêu đề bài viết không được để trống',
            'description.required'  => 'Mô tả không được để trống',
            'file_1.required'   => 'Ảnh bìa không được để trống',
            'content.required'  => 'Nội dung bài viết không được để trống',
            'author.required'   =>  'Tác giả không được để trống' 
        ];
    }

    public function created_at() {
        return $this -> created_at -> format('h:m:s - d/m/Y') ;
    }

    public function updated_at() {
        return $this -> updated_at -> format('h:m:s - d/m/Y') ;
    }

    public function getCreateDate() {
        return $this -> created_at -> format('d M , Y') ;
    }
}
