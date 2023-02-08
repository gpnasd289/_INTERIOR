<?php

namespace App\View\Components;

use Illuminate\View\Component;

class AdminBreadCrumb extends Component
{
    private $title;
    private $size;
    /**
     * Create a new component instance.
     *
     * @return void
     */
    public function __construct($items)
    {
        $this->title = $items;
        $this->size = sizeof($items);
    }

    /**
     * Get the view / contents that represent the component.
     *
     * @return \Illuminate\Contracts\View\View|\Closure|string
     */
    public function render()
    {
        return view('admin.components.bread-crumb');
    }

    public function listtitle() {
        return $this->title;
    }

    public function size() {
        return $this->size;
    }
}
