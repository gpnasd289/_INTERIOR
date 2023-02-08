<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Material extends Model
{
    use HasFactory;
    protected $primaryKey   = "ID"; 
    protected $table        = "material";
    protected $fillable = [
        'name',
    ];
    public function created_at() {
        return $this -> created_at -> format('h:m:s - d/m/Y') ;
    }

    public function updated_at() {
        return $this -> udpated_at -> format('h:m:s - d/m/Y') ;
    }
}
