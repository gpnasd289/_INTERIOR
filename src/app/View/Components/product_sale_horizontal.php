<?php

namespace App\View\Components;

use Illuminate\View\Component;

class product_sale_horizontal extends Component
{
    /**
     * Create a new component instance.
     *
     * @return void
     */
    protected $product;
    public function __construct($product)
    {
        $this -> product = $product;
    }


    /**
     * Get the view / contents that represent the component.
     *
     * @return \Illuminate\Contracts\View\View|\Closure|string
     */
    public function render()
    {
        return view('components.product_sale_horizontal');
    }
}
