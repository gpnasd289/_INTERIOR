<?php

namespace App\View\Components;

use Illuminate\View\Component;

class ProductNewSale extends Component
{
    /**
     * Create a new component instance.
     *
     * @return void
     */

    public $product;
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
        return view('client.components.product_items.product_new_sale_item');
    }

    public function getImageWithBackground() {
        return $this -> product -> specification() -> where('specification_type',2) -> first() -> get();
    }
}
