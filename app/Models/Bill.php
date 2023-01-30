<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\HasOne;
use Illuminate\Hashing\HashManager;

class Bill extends Model
{
    use HasFactory;
    protected $primaryKey   = "ID"; 
    protected $table        = "bill_sell";
    protected $fillable = [
        'buyer',
        'seller',
        'payment_type',
        'delivery_type',
        'address',
        'receive_place_detail_1',
        'receive_place_detail_2',
        'recipient_firstname',
        'recipient_lastname',
        'receipent_phone_number',
        'latitute_end',
        'longtitude_end',
        'status',
        'bill_type',
        'promotion_title',
        'total',
    ];
    const route_prefix = "admin.bill";
    static $bill_total = 0;
    public function created_at() {
        return $this -> created_at -> format('h:m:s - d/m/Y') ;
    }

    public function updated_at() {
        return $this -> updated_at -> format('h:m:s - d/m/Y') ;
    }

    public function customer() : BelongsTo {
        return $this->belongsTo(Client::class, 'buyer','ID');
    }

    public function customer_name() {
        return $this -> customer() -> first() -> profile() -> first() -> name;
    }

    public function total() {
        return number_format($this -> total, 0, '', '.');
    }

    public function products(): BelongsToMany {
        return $this-> BelongsToMany(Product::class,'bill_sell_detail','bill_id','product_id');
    }

    public function bill_detail() {
        return json_encode(BillDetail::where('bill_id', $this -> ID) -> with('product') -> get());
    }

    public function bill_detail_raw() {
        return BillDetail::where('bill_id', $this -> ID) -> with('product') -> get();
    }
    public function listProduct() {
        return json_encode($this -> products()-> get()) ;
    }
    public function promotion() {
        if ($this -> promotion_title == "") {
            return "Không";
        } 
        return $this -> promotion_title;
    }

    public function getPromotion() {
        $promotion = Promotion::where('title', $this -> promotion_title)-> first();
        return $promotion;
    }

    public function payment() {
        switch ($this -> payment_type) {
            case 0:
                return "Thanh toán bằng thẻ";
            case 1:
                return "Thanh toán bằng ví điện tử";
            case 2:
                return "Thanh toán chuyển khoản";
            case 3:
                return "Thanh toán bằng tiền mặt khi nhận hàng";
            case -1:
                return "Chưa có";
        }
    }

    public function status() {
        switch ($this -> status) {
            case 1:
                return "Đơn hàng mới";
            case 2:
                return "Đã xác nhận";
            case 3:
                return "Đang đóng gói";
            case 4: 
                return "Đang giao hàng";
            case 5:
                return "Đã giao hàng";
            case 6:
                return "Hoàn thành";
            case 7: 
                return "Đã hủy";
            default:
                return "";
        }
    }

    public function badgeStatus() {
        switch ($this -> status) {
            case 1:
                return "badge badge-warning badge-pill";
            case 2:
                return "badge badge-success badge-pill";
            case 3:
                return "badge badge-success badge-pill";
            case 4: 
                return "badge badge-success badge-pill";
            case 5:
                return "badge badge-success badge-pill";
            case 6:
                return "badge badge-success badge-pill";
            case 7:
                return "badge badge-primary badge-pill";
            default:
                return "";
        }
    }
}
