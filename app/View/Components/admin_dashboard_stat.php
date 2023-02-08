<?php

namespace App\View\Components;

use Illuminate\View\Component;

class admin_dashboard_stat extends Component
{
    /**
     * Create a new component instance.
     *
     * @return void
     */
    protected $type;
    protected $data;
    public function __construct($data, $type)
    {
        $this -> data = $data;
        $this -> type = $type;
    }

    /**
     * Get the view / contents that represent the component.
     *
     * @return \Illuminate\Contracts\View\View|\Closure|string
     */
    public function render()
    {
        return view('components.admin_dashboard_stat');
    }

    public function getAltertext() {
        var_dump($this -> type);
        switch ($this -> type) {
            case "1":
                return "Đơn hàng";
            case "2":
                return "Doanh thu";
            case "3":
                return "Đơn hàng";
            case "4":
                return "SP đã bán";    
        }
    }
}
