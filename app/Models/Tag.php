<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;

class Tag extends Model
{
    use HasFactory;
    protected $primaryKey   = "ID"; 
    protected $table        = "tag";
    protected $fillable = [
        'title',
    ];

    
}
