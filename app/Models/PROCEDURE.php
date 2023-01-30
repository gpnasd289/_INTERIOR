<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class PROCEDURE extends Model
{
    use HasFactory;
    const sum_bill_total_year = 'CALL sum_by_month_in_year()';
    const get_bill_status = 'CALL get_bill_status()';
    
}
