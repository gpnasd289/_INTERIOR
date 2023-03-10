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
        return $this -> customer() -> first() -> profile() -> first() -> name ?? "Khach vang lai";
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
            return "Kh??ng";
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
                return "Thanh to??n b???ng th???";
            case 1:
                return "Thanh to??n b???ng v?? ??i???n t???";
            case 2:
                return "Thanh to??n chuy???n kho???n";
            case 3:
                return "Thanh to??n b???ng ti???n m???t khi nh???n h??ng";
            case -1:
                return "Ch??a c??";
        }
    }

    public function status() {
        switch ($this -> status) {
            case 1:
                return "????n h??ng m???i";
            case 2:
                return "???? x??c nh???n";
            case 3:
                return "??ang ????ng g??i";
            case 4: 
                return "??ang giao h??ng";
            case 5:
                return "???? giao h??ng";
            case 6:
                return "Ho??n th??nh";
            case 7: 
                return "???? h???y";
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
