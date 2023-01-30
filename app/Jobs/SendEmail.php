<?php

namespace App\Jobs;

use App\Mail\MailNotify;
use App\Mail\SubmitPayment;
use App\Models\MailType;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldBeUnique;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;
use Illuminate\Support\Facades\Mail;

class SendEmail implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    /**
     * Create a new job instance.
     *
     * @return void
     */
    
    protected $data;
    protected $users;
    protected $type;
    public function __construct($data, $users , $type)
    {
        $this->data = $data;
        $this->users = $users;
        $this->type = $type;
    }


    /**
     * Execute the job.
     *
     * @return void
     */
    public function handle()
    {
        foreach ($this->users as $user) {
            switch ($this -> type) {
                case MailType::verifyAccount:
                    Mail::to($user->profile->email)->send(new MailNotify($user->ID));
                    break;
                case MailType::SubmitPayment:
                    Mail::to($user->profile->email)->send(new SubmitPayment($this -> data));
                    break;
            }
        }
    }
}
