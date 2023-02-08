<?php

namespace App\View\Components;

use Illuminate\View\Component;

class OptionItem extends Component
{
    public $children;
    public $tab;
    public $selected;
    /**
     * Create a new component instance.
     *
     * @return void
     */
    public function __construct($children, $tab, $selected)
    {
        $this->children = $children;
        $this->tab  = $tab;
        $this->selected = $selected;
    }

    /**
     * Get the view / contents that represent the component.
     *
     * @return \Illuminate\Contracts\View\View|\Closure|string
     */
    public function render()
    {
        return view('admin.components.option-item');
    }

    public function isSameID($id) {
        return $this -> selected == $id;
    }
}
