<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Person extends Model
{
    use HasFactory;
    protected $primaryKey   = "ID"; 
    protected $table        = "person";
    protected $fillable = [
        'name',
        'email',
        'address',
        'phone_number',
        'born_place',
        'date_of_birth',
        'CCID'
    ];
    
    public function getName() {
        $arr_string = explode(' ', $this -> name);
        return end($arr_string);
    }

    public function created_at() {
        return $this -> created_at -> format('h:m:s - d/m/Y') ;
    }

    public function updated_at() {
        return $this -> updated_at -> format('h:m:s - d/m/Y') ;
    }
}
