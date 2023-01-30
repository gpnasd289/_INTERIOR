<?php

namespace App\View\Components;

use Illuminate\View\Component;

class InputDate extends Component
{
    /**
     * Create a new component instance.
     *
     * @return void
     */
    var $isDisable = false;
    public function __construct($disable = false)
    {
        $this -> isDisable = $disable;
    }

    /**
     * Get the view / contents that represent the component.
     *
     * @return \Illuminate\Contracts\View\View|\Closure|string
     */
    public function render()
    {
        return view('admin.components.text-date-edit');
    }
}
