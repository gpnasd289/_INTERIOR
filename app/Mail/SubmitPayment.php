<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Support\Carbon as SupportCarbon;

class SubmitPayment extends Mailable
{
    use Queueable, SerializesModels;
    public $bill;
    /**
     * Create a new message instance.
     *
     * @return void
     */
    public function __construct($bill)
    {
        //
        $this->bill = $bill;
    }

    /**
     * Build the message.
     *
     * @return $this
     */
    public function build()
    {
        return $this->from(env('MAIL_FROM_ADDRESS'), env('MAIL_FROM_NAME'))
        ->view('client.pdf.bill_history', ['bill' => $this -> bill, 'today' => SupportCarbon::now()])
        ->subject('CẢM ƠN QUÝ KHÁCH HÀNG ĐÃ MUA HÀNG TẠI DIANA');
    }
}
