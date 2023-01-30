<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class BillDetail extends Model
{
    use HasFactory;
    protected $primaryKey   = "ID"; 
    protected $table        = "bill_sell_detail";
    protected $fillable = [
        'bill_id ',
        'product_id',
        'quantity',
        'price',
        'promotion_title'
    ];
    
    public function product() {
        return $this -> belongsTo(Product::class, 'product_id','ID');
    }

    public function price() {
        return number_format($this -> price, 0, '', '.');
    }

    public function getDiscountProductPrice() {
        $promotion = Promotion::where('title', $this -> promotion_title) -> first();
        if(!$promotion) {
            return 0;
        }
        $price = $promotion -> getPriceProductAfterApplyPromotion($this -> product() ->first(), $this -> quantity);
        return number_format($price, 0, '', '.');
    } 

    public function total() {
        return number_format($this -> quantity * $this -> price - $this -> getDiscountProductPrice(), 0, '', '.');
 
    }
}
