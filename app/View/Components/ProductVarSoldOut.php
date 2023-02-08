<?php

namespace App\View\Components;

use Illuminate\View\Component;

class ProductVarSoldOut extends Component
{
    /**
     * Create a new component instance.
     *
     * @return void
     */
    public function __construct()
    {
        //
    }

    /**
     * Get the view / contents that represent the component.
     *
     * @return \Illuminate\Contracts\View\View|\Closure|string
     */
    public function render()
    {
        return view('client.components.product_items.product_variable_with_sold_out');
    }
}
