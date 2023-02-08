<?php

namespace App\Http\Controllers;

use App\Http\Requests\AdminRequest;
use App\Http\Requests\CreateEmployeeRequest;
use App\Http\Requests\EmployeeEditRequest;
use App\Http\Requests\LoginRequest;
use App\Models\Employee;
use App\Models\Person;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

use function PHPSTORM_META\map;

class EmployeeController extends Controller
{
    public function login() {
        if (Auth::guard('admin')->user()) {
            return redirect()->route('admin.dashboard');
        }
        return view('admin.login.view');
    }
    
    public function listemployee() {
        $list = Employee::paginate(15);
        $route_prefix = "admin.employee";
        return view('admin.employee.view', compact(['list','route_prefix'])); 
    }

    public function create() {
        return view('admin.employee.create');
    }

    public function handlelogin(LoginRequest $request) {
        if (Auth::guard('admin')->attempt(['username' => $request-> username, 
                                            'password' => $request -> password ], 
                                            $request->rememberme == "on" ? true : false )) {
           // go to dashboard
            return redirect()->route('admin.dashboard');
        } else {
            return redirect()->route('admin.login') -> with('error', "Wrong username or password !");
        }
    }

    public function logout() {
        Auth::shouldUse('admin');
        Auth::logout();
        return redirect()->route('admin.login');
    }

    public function store(CreateEmployeeRequest $request) {
        if($request-> password != $request-> confirm_password) {
            return redirect() -> back() -> with('error','Password not match !!!');
        }

        $person = Person::create([
            'name' => $request-> name,
            'email' => $request-> email,
            'address' => $request -> address,
            'phone_number' => $request -> phonenumber,
            'born_place'    => $request -> born_place,
            'date_of_birth' => $request -> date,
            'CCID'  => $request-> ccid,
        ]);

        $person->save();
        $account = Employee::create([
            'belong_to' => $person -> ID,
            'username'  => $request -> username,
            'password'  => bcrypt($request -> password),
            'role'      => $request -> role ,
        ]);
        $account->save();
        return redirect() -> route('admin.employee.list')-> with('createdSuccess',"Created new Account Success");
    }

    public function edit($id) {
        $data = Employee::find($id);
        return view('admin.employee.edit',compact(['data']));
    } 

    public function update(EmployeeEditRequest $request) {
        $person = Person::find($request->belong_to);
        $account = Employee::find($request->id);

        $person->name = $request -> name;
        $person->email = $request -> email;
        $person->address = $request -> address;
        $person->phone_number = $request -> phonenumber;
        $person->born_place = $request -> born_place;
        $person->date_of_birth = $request -> date;
        $person->CCID = $request -> ccid;

        $account->role = $request->role;
        $person -> save();
        $account -> save();
        return view('admin.employee.edit')->with('editedSuccess','Edited Success');
    } 
    public function deleleEm($id) {
        try {
            $employee = Employee::find($id);
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

    public function detail($id) {
        $data = Employee::find($id);
        return view('admin.employee.detail',compact(['data']));
    }
}
