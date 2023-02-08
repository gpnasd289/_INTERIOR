<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Category_Promotion extends Model
{
    use HasFactory;
    protected $primaryKey   = "ID"; 
    protected $table        = "category_promotion";
    protected $fillable = [
        'categoryID',
        'promotionID',
    ];
}
