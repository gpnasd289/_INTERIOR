<?php

namespace App\View\Components;

use Illuminate\View\Component;

class imagebutton extends Component
{
    /**
     * Create a new component instance.
     *
     * @return void
     */

    public  $preview;
    public  $product;
    public function __construct($preview, $product)
    {     
        $this -> preview  = $preview;
        $this -> product  = $product;
    }

    /**
     * Get the view / contents that represent the component.
     *
     * @return \Illuminate\Contracts\View\View|\Closure|string
     */
    public function render()
    {
        return view('components.imagebutton');
    }

    public function image_url() {      
        if($this-> preview == null) {
            return '';
        }
        switch($this -> preview -> ID) {
            case 2:
                return $this -> product -> image_with_background_path();
            case 3:
                return $this -> product -> image_1_path();
            case 4:
                return $this -> product -> image_2_path();
            case 5:
                return $this -> product -> image_3_path();
            case 6:
                return $this -> product -> image_no_background_path();
        }
    }
}
