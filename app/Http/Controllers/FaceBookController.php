<?php

namespace App\Http\Controllers;

use App\Models\Client;
use App\Models\Person;
use App\Models\User;
use Illuminate\Contracts\Session\Session;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Socialite;
class FaceBookController extends Controller
{
    /**
     * Login Using Facebook
     */
    public function loginUsingFacebook()
    {
        Session::flush();
        return Socialite::driver('facebook')->redirect();
    }

    public function callbackFromFacebook()
    {
        try {
            
                $user = Socialite::driver('facebook')->user();
                $person = null;
                $userProfile = Client::where('google_id',$user->getId()) -> first();
                if (!$userProfile) {
                    $person = Person::create([
                        'name' => $user->getName(),
                        'email' => $user->getEmail(),
                    ]);
                    $person ->save();
                    $saveUser = Client::updateOrCreate([
                        'google_id' => $user->getId(),
                    ],[
                        'belong_to' => $person -> ID,
                        'password' => Hash::make($user->getName().'@'.$user->getId()),
                        'total_pay' => 100000
                    ]);
                    Auth::guard('client')->loginUsingId($saveUser->ID);
                    if(Auth::guard('client') -> user() -> verify_account == 0) {
                        return redirect() -> route('client.customer.verify', ['id' => Auth::guard('client')->id()]);
                    }
                    CartController::loadUserCart(Auth::guard('client')->id());
                    return redirect() -> route('home');
                } else {
                    $saveUser = Client::updateOrCreate([
                        'google_id' => $user->getId(),
                    ]);
                    Auth::guard('client')->loginUsingId($userProfile->ID);
                    if(Auth::guard('client') -> user() -> verify_account == 0) {
                        return redirect() -> route('client.customer.verify', ['id' => Auth::guard('client')->id()]);
                    }
                    CartController::loadUserCart(Auth::guard('client')->id());
                    return redirect() -> route('home');
                }
            } catch (\Throwable $th) {
                throw $th;
            }
        }
}


