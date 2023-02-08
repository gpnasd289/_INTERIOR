<?php

namespace App\Http\Controllers;

use App\Models\Client;
use App\Models\Person;
use Exception;
use Illuminate\Http\Request;

use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Session;
use Laravel\Socialite\Facades\Socialite;

class GoogleController extends Controller
{
    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function redirectToGoogle()
    {
        Session::flush();
        return Socialite::driver('google')->redirect();
    }
        
    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function handleGoogleCallback()
    {
        try {
            $user = Socialite::driver('google')->stateless()->user();
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
                $saveUser -> save();
                Auth::guard('client')->loginUsingId($userProfile->ID);
              
                if(Auth::guard('client') -> user() -> verify_account == 0) {
                    return redirect() -> route('client.customer.verify', ['id' => Auth::guard('client')->id()]);
                }
                
                CartController::loadUserCart(Auth::guard('client')->id());
                return redirect() -> route('home');
            }
          
            return redirect()->route('home');
            
      
        } catch (Exception $e) {
            dd($e);
        }
    }
}
