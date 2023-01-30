<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Specifications extends Model
{
    use HasFactory;
    protected $primaryKey   = "ID"; 
    protected $table        = "product_specifications";
    protected $fillable = [
        'specification_type',
        'value',
        'unit',
        'specification_name'
    ];

    public function product() {
        return $this -> belongsToMany(Product::class,'product_spec','specificationID','productID');
    }

    public function specificationType() {
        return $this -> belongsTo(Specification_Type::class,'specification_type','ID');
    }
    public function created_at() {
        return $this -> created_at -> format('h:m:s - d/m/Y') ;
    }

    public function updated_at() {
        return $this -> updated_at -> format('h:m:s - d/m/Y') ;
    }
}
