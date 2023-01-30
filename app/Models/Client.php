<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;

class Client extends Authenticatable
{
    use HasApiTokens, HasFactory, Notifiable;
    protected $primaryKey   = "ID"; 
    protected $table        = "client_account";
    protected $fillable = [
        'username',
        'password',
        'role',
        'token',
        'belong_to',
        'verify_account',
        'remember_token',
        'facebook_id',
        'google_id',
        'avatar',
    ];

    public function created_at() {
        return $this -> created_at -> format('h:m:s - d/m/Y') ;
    }

    public function updated_at() {
        return $this -> updated_at -> format('h:m:s - d/m/Y') ;
    }
    
    public function profile() {
        return $this->belongsTo(Person::class,'belong_to','ID');
    }

    public function getAuthPassword() {
        return $this->password;
    }

    public static function messages() {
        return [
            'username.required' => 'Tên đăng nhập không được bỏ trống',
            'password.required' => 'Mật khẩu không được bỏ trống',
            'password.min'      => 'Mật khẩu phải có ít nhất 8 kí tự',
            'confirm_password.required' => 'Mật khẩu không khớp',
            'email.required' => 'Email không được bỏ trống',
            'email.email'   => 'Email không đúng định dạng'
        ];
    }

    public static function createRule() {
        return [
            'username'          => 'required|max:100',
            'password'          => 'required|min:8',
            'confirm_password'  => 'required',
            'email'             => 'required|email'
        ];
    }

    public function rank_icon() {
        switch($this -> rank) {
            case "Thành viên Mới":
                return "";
            case "Thành viên Bạc":
                return "<i class='fa fa-star' style='color:#aaa9ad'></i>";
            case "Thành viên Vàng":
                return "<i class='fa fa-star' style='color:#D4AF37'></i>";
            case "Thành viên Kim Cương":
                return "<img src='/assets/images/diamond.png' style='height: 20px; width:20px'>";
               
        }
    }

    public function totalpay() {
        return number_format($this -> totalpay, 0, '', ',');
    }
}
