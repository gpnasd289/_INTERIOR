<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Product_Promotion extends Model
{
    use HasFactory;
    protected $primaryKey   = "ID"; 
    protected $table        = "product_promotion";
    protected $fillable = [
        'productID',
        'promotionID',
    ];
}
