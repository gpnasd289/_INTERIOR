<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ThumbnailImage extends Model
{
    use HasFactory;
    protected $primaryKey   = "ID"; 
    protected $table        = "dashboard_img";
    protected $fillable = [
        'file_path',
        'status',
        'position'
    ];
    public function created_at() {
        return $this -> created_at -> format('h:m:s - d/m/Y') ;
    }

    public function updated_at() {
        return $this -> updated_at -> format('h:m:s - d/m/Y') ;
    }
}
