<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;
use Cart;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Product extends Model {
    use HasFactory;
    protected $primaryKey   = "ID"; 
    protected $table        = "product";
    protected $fillable = [
        'name',
        'product_category',
        'product_parent',
        'price_entry',
        'price_sell',
        'price_sale',
        'quantity',
        'status',
        'description',
        'content_review',
        'display_state',
        'rate',
    ];
    
    protected $hidden = [
        'pivot'
    ];

    const max_number_display_page_shop = 16;

    public function parent() {
        return $this->belongsTo(Product::class,'product_parent','ID');
    }
    
    public function children(): HasMany {
        return $this->hasMany(Product::class,'product_parent','ID')->with('children');
    }

    public static function getTree(): array
    {
        return Product::whereNull('product_parent')->with('children')->get()->toArray();
    }

    public function category() {
        return $this->belongsTo(Category::class,'product_category','ID');
    }
    
    public function specification(): BelongsToMany {
        return $this->belongsToMany(Specifications::class,'product_spec','productID','specificationID') -> with ('specificationType');
    }

    public static function getAllProduct() {
        return Product::whereNotNull('product_parent') -> orderBy('created_at','desc')->paginate(10);
    }

    public static function getProductById($id) {
        return Product::find($id);
    }

    public static function deleteProductById($id) { 
        $product = Product::find($id);
        $product -> delete();
    }

    public function getSiblingColor() {
        return Product::where('product_parent', $this -> ID) -> get();
    }

    public function image_1_path() {
        return $this -> specification -> where('specificationType.ID', 3) -> first() -> value;
    }

    public function image_2_path() {
        return $this -> specification -> where('specificationType.ID', 4) -> first() -> value;
    }

    public function image_3_path() {
        return $this -> specification -> where('specificationType.ID', 5) -> first() -> value;
    }

    public function image_with_background_path() {
        return $this -> specification -> where('specificationType.ID', 2) -> first() -> value;
    }

    public function image_no_background_path() {
        return $this -> specification -> where('specificationType.ID', 6) -> first() -> value;
    }

    public function color() {
        return $this -> specification -> where('specificationType.ID', 1) -> first() -> value;
    }

    public function material() {
        $materialID = $this -> specification -> where('specificationType.ID', 7) -> first() -> value;
        $material = Material::find($materialID);
        return $material -> name ?? ''; 
    }

    public function promotion() {
        return $this -> specification -> where('specificationType.ID', 8);
    }

    public function getPrice() {
        return number_format($this -> price_sell, 0, '', '.');
    }
    public function getEntryPrice() {
        return number_format($this -> price_entry, 0, '', '.');
    }
    public function getPriceSale() {
        return number_format($this -> price_sale, 0, '', '.');
    }
    public function getQuantity() {
        return number_format($this -> quantity, 0, '', '.');
    }
    public function created_at() {
        return $this -> created_at -> format('h:m:s - d/m/Y') ;
    }

    public function updated_at() {
        return $this -> updated_at -> format('h:m:s - d/m/Y') ;
    }

    public static function createRule(): array {
        return [
            'name'              => 'required',
            'product_category'  => 'required',
            'price_entry'       => 'required', 
            'price_sell'        => 'required',
            'price_sale'        => 'required',
            'quantity'          => 'required',
            'status'            => 'required',
            'description'       => 'required',
        ];
    }

    public static function messages(): array {
        return [

        ];
    }

    public function status() {
        switch ($this -> status) {
            case 1:
                return "Đang hoạt động";
            case 2:
                return "Ngưng hoạt động";
            case 3:
                return "Hết hàng";
        }
    }

    public function badgeStatus() {
        switch ($this -> status) {
            case 1:
                return "badge badge-success badge-pill";
            case 2:
                return "badge badge-primary badge-pill";
            case 3:
                return "badge badge-warning badge-pill";
        }
    }

    public function colorStyle() {
        return "background-color: " . $this -> color() . ";"; 
    }

    public function selectedColorStyle() {
        return "background-color: " . $this -> color() . "; border: 2px solid red;"; 
    }
}
