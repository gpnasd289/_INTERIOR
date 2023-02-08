<?php

namespace App\Models;


use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;
class Employee extends Authenticatable
{
    use HasApiTokens, HasFactory, Notifiable;
    protected $primaryKey   = "ID"; 
    protected $table        = "employee";
    protected $fillable = [
        'username',
        'password',
        'role',
        'belong_to',
        'token',
        'remember_token',
    ];

    public function profile() {
        return $this->belongsTo(Person::class,'belong_to','ID');
    }

    public function getAuthPassword() {
        return $this->password;
    }
    
    public function created_at() {
        return $this -> created_at -> format('h:m:s - d/m/Y') ;
    }

    public function updated_at() {
        return $this -> updated_at -> format('h:m:s - d/m/Y') ;
    }

    public static function createRule() {
        return  [
            'name'          => 'required',
            'date'          => 'required',
            'address'       => 'required',
            'born_place'    => 'required',
            'ccid'          => 'required',
            'phonenumber'   => 'required',
            'email'         => 'required',
            'username'      => 'required',
            'password'      => 'required|min:8',
            'confirm_password' => 'required',
            'role'          => 'required'
        ];
    }

    public static function messages() {
        return [
            'name'                  => 'Name is required',
            'username.required'     => 'Username must not be blank',
            'password.required'     => 'Password must not be blank',
            'password.min'          => 'Password minimum character is 8',
            'date.required'         => 'You need to provide your date of birth',
            'ccid.required'         => 'You need to provide your CCID',
            'born_place.required'   => 'You need to provide your born place',
            'address.required'      => 'You need to provide your address',
            'role.required'         => 'You need to add role',
            'email.required'        => 'Email must not be blank',
            'confirm_password'      => 'Cornfirm password must not be blank',
            'phonenumber.required'  => 'Phone Number must not be blank'
        ];
    }
}
