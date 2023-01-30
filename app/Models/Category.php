<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Category extends Model
{
    use HasFactory;
    protected $primaryKey   = "ID"; 
    protected $table        = "category";
    protected $fillable = [
        'name',
        'description',
        'parent',
        'parent_id',
        'status',
    ];
    
    const max_number_admin_paginate = 16;
    public function parent() {
        return $this->belongsTo(Category::class,'parent_id','ID');
    }
    
    public function children(): HasMany {
        return $this->hasMany(Category::class,'parent_id','ID')->with('children');
    }

    public static function getTree(): array
    {
        return Category::whereNull('parent_id')->with('children')->get()->toArray();
    }

    public static function getAllCategory() {
        return Category::paginate(Category::max_number_admin_paginate);
    }

    public static function createRule(): array 
    {
        return [
            'name' => 'required|max:255',
            'description' => 'required|max:255',
        ];
    }

    public static function messages() {
        return [
            'name.required' => 'Name must not be blank',
            'name.max:255'  => 'Name is too long',
            'description.required' => 'Description must not be blank',
            'description.max:255'   => 'Description is too long', 
        ];
    }
    
    public function created_at() {
        return $this -> created_at -> format('h:m:s - d/m/Y') ;
    }

    public function updated_at() {
        return $this -> updated_at -> format('h:m:s - d/m/Y') ;
    }
}
