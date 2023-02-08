<?php

namespace App\View\Components;

use Illuminate\View\Component;

class RowFunction extends Component
{
    /**
     * Create a new component instance.
     *
     * @return void
     */

    public $route_prefix;
    public $item;
    public function __construct($item, $prefix)
    {
        $this -> route_prefix = $prefix;
        $this -> item = $item;
    }

    /**
     * Get the view / contents that represent the component.
     *
     * @return \Illuminate\Contracts\View\View|\Closure|string
     */
    public function render()
    {
        return view('components.row-function');
    }
}
