@extends('client.layouts.main')
@section('header')
    <link href="{{ asset('assets/css/password-strength.css') }}" rel="stylesheet" />
@endsection
@section('main-content')
    <div class="page-header-area">
        <div class="container">
            <div class="row">
            <div class="col-12 text-center">
                <div class="page-header-content">
                <h4 class="title" data-aos="fade-down" data-aos-duration="1200">Đăng ký</h4>
                <nav class="breadcrumb-area" data-aos="fade-down" data-aos-duration="1000">
                    <ul class="breadcrumb">
                    <li><a href="{{ route('home') }}">Home</a></li>
                    <li class="breadcrumb-sep">-</li>
                    <li>Đăng ký</li>
                    </ul>
                </nav>
                </div>
            </div>
            </div>
        </div>
    </div>


    <div class="container" style="margin-top:50px; margin-bottom:50px; width: 600px;">
        <x-cardbody title="">
            <div class="d-flex justify-content-center mt-1">
                <h2> Đăng ký tài khoản </h2>
            </div>
            <form action="{{ route('client.customer.cregister') }}" method="POST" onsubmit="return validate();">
                @csrf
                @if(session('error')) 
                    <div class="error"> {{ session('error') }} </div>
                @endif
                <div class="form-item">
                    <x-inputtext title="Tên Đăng Nhập" name="username" placeholder="Nhập tên đăng nhập" id="username" value="{{ old('username','') }}" ></x-inputtext>
                    @if($errors->has('username'))
                        <div class="error"> {{ $errors->first('username') }} </div>
                    @endif
                </div>

                <div class="form-item">
                    <x-inputtext title="Email" name="email" placeholder="Nhập email" type="email" id="email" value="{{ old('email','')}}" ></x-inputtext>
                    @if($errors->has('email'))
                        <div class="error"> {{ $errors->first('email') }} </div>
                    @endif
                </div>

                <div class="form-item">
                    <x-inputtext title="Mật khẩu" name="password" placeholder="Nhập mật khẩu" type="password" id="password" value="{{ old('password','')}}" >
                        <div class="input-group-addon">
                            <span><i class="fa fa-eye-slash" id="togglePassword"></i></span>
                        </div>
                    </x-inputtext>
                    <ul class="pswd_info" id="passwordCriterion">
                        <li data-criterion="length" class="invalid">Mật khẩu có 8-15 <strong>Kí tự</strong></li>
                        <li data-criterion="capital" class="invalid">Mật khẩu có ít nhất <strong> một kí tự viết hoa [A-Z]</strong></li>
                        <li data-criterion="small" class="invalid">Mật khẩu có ít nhất<strong> một kí tự viết thường [a-z]</strong></li>
                        <li data-criterion="number" class="valid">Mật khẩu có ít nhất<strong> một chữ số [0-9] </strong></li>
                        <li data-criterion="special" class="invalid">Mật khẩu có ít nhất<strong> một kí tự đặc biệt ví dụ !@#$%^&*,... </strong></li>
                    </ul>
                    <!-- <div id="password-strength-status" class="veryweak-password">Mật khẩu rất yếu</div> -->
                    @if($errors->has('password'))
                        <div class="error"> {{ $errors->first('password') }} </div>
                    @endif
                </div>

                <div class="form-item">
                    <x-inputtext title="Xác nhận mật khẩu" name="confirm_password" placeholder="Xác nhận mật khẩu" type="password" id="confirm_password" value="{{ old('confirm_password','')}}" >
                        <div class="input-group-addon">
                            <span><i class="fa fa-eye-slash" id="toggleConfirmPassword"></i></span>
                        </div>
                    </x-inputtext>
                    @if($errors->has('confirm_password'))
                        <div class="error"> {{ $errors->first('confirm_password') }} </div>
                    @endif
                </div>
            
                <div class="row form-item"  >
                    <div class="col-lg-8"></div>
                    <div class="col-lg-4">
                        Bạn đã có tài khoản ? <a href="{{ route('client.customer.login') }}" alt="login"> <u style="color: blue;">Đăng nhập ngay</u></a>
                    </div>
                    <div class="col-lg-12 d-flex justify-content-center">
                        <button class="btn btn-register" id="btn-register">Đăng ký</button>      
                    </div>
                </div>
            </form>
        </x-cardbody>
       
    </div>
@endsection

@section('script')
    <script src="{{ asset('assets/js/password-strength.js') }}"></script>
    <script>
        $(function() {
            checkPasswordStrength($('#password').val());
        });
    </script>


@endsection