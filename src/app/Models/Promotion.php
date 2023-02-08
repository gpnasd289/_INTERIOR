<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Gloudemans\Shoppingcart\Facades\Cart;
class Promotion extends Model
{
  
    use HasFactory;
    protected $primaryKey   = "ID"; 
    protected $table        = "promotion";
    protected $fillable = [
        'title',
        'description',
        'promotion_apply',
        'status',
        'promotion_condition',
        'condition_value',
        'quantity',
        'discount_type',
        'discount_value',
        'start_date',
        'end_date'
    ];
    const discount_percentage = 1;
    const discount_price      = 2;

    public function category() {
        return $this->belongsToMany(Category::class,'category_promotion','promotionID','categoryID');
    }

    public function product() {
        return $this->belongsToMany(Product::class,'product_promotion','promotionID','productID');
    }
  
    public static function createRule(): array 
    {
        return [
            'title' => 'required|max:255',
            'description' => 'required|max:255',
            'promotion_apply' => 'required',
            'status'    => 'required',
            'promotion_condition' => 'required',
            'quantity'  => 'required|min:0',
            'discount_type' => 'required',
            'discount_value' => 'required|min:0|max:10000000',
            'start_date'    => 'required|date:before:end_date',
            'end_date' => 'required|date|after:start_date',
            'condition_value_lowest_bill'   => 'min:0',
            'condition_value_minimum_money'  => 'min:0',
            'condition_value_minimum_product'  => 'min:0',
        ];
    }
    public static function messages():array {
        return [
            'title.required'    => 'Tiêu đề không được để trống',
            'title.max:255' => 'Tiêu đề quá dài',
            'description.required'   => 'Mô tả không được để trống',
            'description.max:255'   => 'Mô tả quá dài',
            'promotion_apply.required'    => 'Loại mã giảm giá không được để trống',
            'status.required'    => 'Trạng thái không được để trống',
            'promotion_condition.required' => 'Điều kiện mã giảm giá không được để trống',
            'quantity.required' => 'Số lượng mã giảm giá không được để trống',
            'start_date.required'   => 'Ngày bắt đầu không được để trống',
            'end_date.required' => 'Ngày kết thúc không được để trống',
            'quantity.min:0'   => 'Số lượng không được nhỏ hơn 0',
            'condition_value_lowest_bill.min:0' => 'Giá trị đơn hàng không thỏa mãn',
            'condition_value_minimum_money.min:0' => 'Giá trị đơn hàng không thỏa mãn',
            'condition_value_minimum_product.min:0' => 'Giá trị sản phẩm không thỏa mãn',
            'end_date.after:start_date' => 'Ngày kết thúc phải nằm sau ngày bắt đầu',
            'start_date.before:end_date' => 'Ngày bắt đầu phải nằm trước ngày kết thúc',
        ];
    }
    
    public function created_at() {
        return $this -> created_at -> format('h:m:s - d/m/Y') ;
    }

    public function updated_at() {
        return $this -> updated_at -> format('h:m:s - d/m/Y') ;
    }

    public function discount_type_string() {
        if ($this -> discount_type == Promotion::discount_percentage) {
            return '%';
        } else if ($this -> discount_type == Promotion::discount_price) {
            return 'VND';
        }
    }

    public function getDiscount($cart) {
        $valid_products = $this -> getValidProduct_ForPromotion($cart);
        $discount_value = 0;
        foreach($valid_products as $discount_item) {
            if ($this -> discount_type == Promotion::discount_percentage) {
                $discount_value += ($discount_item['price'] * ($this-> discount_value / 100) ) * $discount_item['qty'];
            } else if ($this -> discount_type == Promotion::discount_price) {
                $discount_value += $this -> discount_value * $discount_item['qty'];
            } 
        }
        return $discount_value;
    }

    public function getDiscountProduct($product, $qty) {
        $discount_value = 0;
        if ($this -> discount_type == Promotion::discount_percentage) {
            $discount_value += ($product -> price * ($this-> discount_value / 100) ) * $qty ;
        } else if ($this -> discount_type == Promotion::discount_price) {
            $discount_value += $this -> discount_value *  $qty;
        } 
        return $discount_value;
    }

    public function getValidProduct_ForPromotion($cart) {
        $valid_product = [];
        $products = array_map(function($item) {
            return $item;
        }, $cart);

        if($this -> promotion_apply == 2) {
            $listCategoryId = $this -> category -> toArray();
            $listCategoryId = array_map(function ($item) {
                return $item['ID'];
            }, $listCategoryId);

            foreach($products as $item ) {
                $temp_product = Product::find($item['id']);
                if (in_array($temp_product -> category -> ID , $listCategoryId)) {
                    array_push($valid_product, $item);
                }
            }

        } else if($this -> promotion_apply == 3) {
            $listProductId = $this -> product -> toArray();
            $listProductId = array_map(function ($item) {
                return $item['ID'];
            }, $listProductId);

            foreach($products as $item ) {
                if (in_array($item['id'] , $listProductId)) {
                    array_push($valid_product, $item);
                }
            }
        } else {
            foreach($products as $item ) {
                array_push($valid_product, $item); 
            }
        }
        return $valid_product;
    }

    public function getPriceProductAfterApplyPromotion($product, $qty) {
        if($this -> promotion_apply == 2) {
            $listCategoryId = $this -> category -> toArray();
            $listCategoryId = array_map(function ($item) {
                return $item['ID'];
            }, $listCategoryId);

            if (in_array($product -> category -> ID , $listCategoryId)) {
                return $this -> getDiscountProduct($product, $qty);
            }
        } else if($this -> promotion_apply == 3) {
            $listProductId = $this -> product -> toArray();
            $listProductId = array_map(function ($item) {
                return $item['ID'];
            }, $listProductId);

          
            if (in_array($product -> ID , $listProductId)) {
                return $this -> getDiscountProduct($product, $qty);
            }
          
        } else {
            return $this -> getDiscountProduct($product, $qty);
        }
    }
}
