<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Prod_Specification extends Model
{
    use HasFactory;
    protected $primaryKey   = "ID"; 
    protected $table        = "product_spec";
    protected $fillable = [
        'productID',
        'specificationID',
    ];
}
