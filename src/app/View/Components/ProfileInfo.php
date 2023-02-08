<?php

namespace App\View\Components;

use Illuminate\View\Component;
use Tymon\JWTAuth\Claims\Custom;

class ProfileInfo extends Component
{
    /**
     * Create a new component instance.
     *
     * @return void
     */
    public $type;
    public $customerid;
    public function __construct( $type, $customerid)
    {
        $this -> type   = $type;
        $this -> customerid  = $customerid;
    }

    /**
     * Get the view / contents that represent the component.
     *
     * @return \Illuminate\Contracts\View\View|\Closure|string
     */
    public function render()
    {
        return view('components.profile-info');
    }

    public function icon() {
        switch ($this -> type) {
            case 1:
                return "fa fa-user";
            case 2:
                return "fa fa-address-card";
            case 3:
                return "fa fa-lock";
            case 4:
                return "fa-solid fa-map";
            case 5:
                return "fa fa-envelope";
            case 6:
                return "fa fa-phone";
            case 7: 
                return "fa-solid fa-globe"; 
        } 
    }

    public function title() {
        switch ($this -> type) {
            case 1:
                return "Họ và tên";
            case 2:
                return "Tên đăng nhập";
            case 3:
                return "Mật khẩu";
            case 4:
                return "Địa chỉ";
            case 5:
                return "Email";
            case 6: 
                return "Điện thoại"; 
            case 7:
                return "Mạng xã hội";
        } 
    }

    public function url() {
        return route('client.profile.update');
    }
}
