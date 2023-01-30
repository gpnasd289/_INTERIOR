<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Testimonial extends Model
{
    use HasFactory;
    protected $primaryKey   = "ID"; 
    protected $table        = "testimonial";
    protected $fillable = [
        'name',
        'email',
        'productID',
        'rating',
        'title',
        'content',
    ];

    public static function createRule() {
        return [
            'name' => 'required',
            'email' => 'required',
            'rating' => 'required',
            'title' =>   'required|min:0',
            'content' => 'required|min:0|max:1500',
        ];
    }

    public static function messages() {
        return [
            'rating.required' => 'Hãy cho điểm sản phẩm',
            'title.required' =>   'Tiêu đề không được để trống',
            'content.required' => 'Nội dung không được để trống',
            'content.max:1500' => 'Nội dung có nhiều nhất 1500 kí tự',
        ];
    }
}
