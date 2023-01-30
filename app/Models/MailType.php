<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Validation\Rules\Enum;

class MailType extends Enum
{
    use HasFactory;
    const verifyAccount = "verify-account";
    const cartNotification = 'cart-notification';
    const SubmitPayment = 'submit-payment';
}
