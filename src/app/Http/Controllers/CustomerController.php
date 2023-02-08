<?php

namespace App\Http\Controllers;
use App\Http\Requests\LoginRequest;
use App\Http\Requests\RegisterRequest;
use App\Jobs\SendEmail;
use App\Models\Bill;
use App\Models\BillDetail;
use App\Models\Category;
use App\Models\Client;
use App\Models\MailType;
use App\Models\Person;
use Exception;
use Gloudemans\Shoppingcart\Facades\Cart;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Symfony\Component\HttpKernel\Profiler\Profile;

class CustomerController extends Controller
{
    public function index() {
        $route_prefix = "admin.customer";
        $list = Client::paginate(15);
        return view('admin.customer.view', compact(['route_prefix','list']));
    }

    public function create() {
        return view('admin.customer.create');
    }

    public function store() {

    }

    public function edit($id) {
        return view('admin.customer.edit');
    }

    public function update(Request $request) {
        
    }

    public function login() {
        $category = Category::all();
        return view('client.customer.login',compact('category'));
    }

    public function logout() {
        Auth::shouldUse('client');
        Auth::logout();
        Cart::instance('shopping')->destroy();
        return redirect() -> route('home');
    }

    public function handlelogin(LoginRequest $request) {
        if (Auth::guard('client')->attempt(['username' => $request-> username, 'password' => $request -> password ])) {
            if(Auth::guard('client') -> user() -> verify_account == 0) {
                return redirect() -> route('client.customer.verify', ['id' => Auth::guard('client')->id()]);
            }
            CartController::loadUserCart(Auth::guard('client') -> user() -> ID);
            return redirect() -> route('home');
        } else {
            return redirect() -> route('client.customer.login') -> with('error', "Sai tên đăng nhập hoặc mật khẩu !");
        }
    }

    public function register() {
        $category = Category::all();
        return view('client.customer.register',compact(['category']));
    }
    


    public function handle_register(RegisterRequest $request) {
        if($request -> password != $request -> confirm_password) {
            return redirect() -> back() -> with('error','Mật khẩu không khớp');
        } 
        
        $isExistEmail = Person::where('email',$request -> email) -> get();
        $isExistUsername = Client::where('username', $request -> username) -> get();

        if (count($isExistUsername) > 0) {
            return redirect() -> back() -> with('error','Tên tài khoản đã được sử dụng');
        }
        
        if (count($isExistEmail) > 0) {
            return redirect() -> back() -> with('error','Email này đã được sử dụng');
        }

    
        $profile = Person::create([
            'email' => $request -> email
        ]);
        $profile -> save();

        $client = Client::create([
            'belong_to' => $profile -> ID,
            'username' => $request -> username,
            'password' => bcrypt($request -> password),
        ]);

        $client -> save();
        if ($client) {
            $this-> resent_verify_account($client -> ID);
            return redirect() -> route('client.customer.login') -> with('success_register','Tạo tài khoản thành công');
        } else {
            return redirect() -> back() -> with('error','Đã xảy ra lỗi ');
        } 
    }

    public function verify_account($id) {
        $customer = Client::find($id);
        $customer -> verify_account = 1 ; 
        Auth::guard('client') -> logout();
        $customer -> save();
        return redirect() -> route('home') -> with('verify_success','Xác minh tài khoản thành công');
    }

    public function verify($id) {
        $category = Category::all();
        $customer = Client::find($id);
        return view('client.customer.verify-account', compact(['customer','category']));
    }

    public function resent_verify_account($id) {
        $user = Client::where('ID', $id)->get();
        try {
            SendEmail::dispatch('', $user, MailType::verifyAccount);
            return response() -> json([
                'code' => 200 ,
                'message' => 'Success Send Email' 
            ]);
        } catch (Exception $e) {
            return response() -> json([
                'code' => 203 ,
                'message' => 'Fail Send Email' 
            ]);
        }
    }

    public function profile($id) {
        $category = Category::all();
        $customer = Client::find($id);
        return view('client.customer.profile', compact('customer','category'));
    }

    public function update_profile(Request $request) {
        $customer = Client::find($request -> id);
        $profile = Person::find($customer -> belong_to);
        if ($request -> name) {
            $profile -> name = $request -> name;
            $profile -> save();
            return response() -> json([
                'code'      => '200',
                'message'   => 'Cập nhật thành công',
                'data'      => [
                    'view'  => "<span id='name-" . $customer -> ID ."'>".  $profile -> name . "</span>",
                    'value' => $profile -> name
                ],
            ]);
        }

        if ($request -> old_password) {
            $old_password           = $request -> old_password;
            $new_pasword            = $request -> new_password;
            $confirm_new_password   = $request -> confirm_new_password;
            if (!Hash::check($old_password, $customer -> password)  ) {
                return response() -> json([
                    'code'      => '201',
                    'message'   => 'Mật khẩu cũ không khớp',
                    'data'      => [
                        'view'  => "<div class='error'> Mật khẩu cũ không chính xác. Vui lòng thử lại </div>",
                        
                    ],
                ]);
            } else if ($new_pasword != $confirm_new_password) {
                return response() -> json([
                    'code'      => '201',
                    'message'   => 'Mật khẩu mới không khớp',
                    'data'      => [
                        'view'  => "<div class='error'> Mật khẩu xác nhận không khớp với mật khẩu mới </div>",
                        'value' => $new_pasword,
                        'value1'=> $confirm_new_password,
                    ],
                ]);
            }
            $customer -> password = bcrypt($new_pasword);
            $customer -> save();
            return response() -> json([
                'code'      => '200',
                'message'   => 'Cập nhật mật khẩu thành công',
                'data'      => [
                    'view'  => "<span id='password-" . $customer -> ID ."'> ******** </span>",
                ],
            ]);
        }
     
    }

    public function deleteCus($id) {
        try {
            $employee = Client::find($id);
            $employee->delete();
            return response() -> json([
                'code'=> 200,
                'message'=> "Success"
            ]);
        } catch(Exception $e) {
            return response() -> json([
                'code'=> 201,
                'message'=> "Error"
            ]);
        }
    }

    public function customerOrders($id) {
        $orders = Bill::where('buyer', $id) -> orderByDesc('ID') -> get();
        if (!$orders) {
            $orders = [];
        }
        return response() -> json([
            'profileView' => view('client.customer.orders',compact(['orders'])) -> render()
        ]);
    }

    public function customerInfo($id) {
        $customer = Client::where('ID', $id) -> first();
        return response() -> json([
            'profileView' => view('client.customer.profile-info',compact(['customer'])) -> render()
        ]);
    }
}
