@extends('client.layouts.main')
@section('main-content')
    <div class="page-header-area">
        <div class="container">
            <div class="row">
            <div class="col-12 text-center">
                <div class="page-header-content">
                <h4 class="title" data-aos="fade-down" data-aos-duration="1200">Login</h4>
                <nav class="breadcrumb-area" data-aos="fade-down" data-aos-duration="1000">
                    <ul class="breadcrumb">
                    <li><a href="{{ route('home') }}">Home</a></li>
                    <li class="breadcrumb-sep">-</li>
                    <li>Login</li>
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
                    <h2>Đăng nhập</h2>
            </div>
            <form action="{{ route('client.customer.clogin') }}" method="GET">
                
          
                <div class="form-item">
                    <x-inputtext title="Tên Đăng Nhập" name="username" placeholder="Nhập tên đăng nhập" id="username" value="{{ old('username','') }}" ></x-inputtext>
                    @if($errors->has('username'))
                        <div class="error"> {{ $errors->first('username') }} </div>
                    @endif
                </div>
                <div class="form-item">
                    <x-inputtext title="Mật khẩu" name="password" placeholder="Nhập mật khẩu" type="password" id="password" value="{{ old('password','')}}" ></x-inputtext>
                    @if($errors->has('password'))
                        <div class="error"> {{ $errors->first('password') }} </div>
                    @endif
                </div>
                @if(session('error')) 
                    <div class="error"> {{ session('error') }} </div>
                @endif
                <div class="row form-item"  >
                    <div class="col-lg-8"></div>
                    <div class="col-lg-4">
                        <a href="#" alt="" style="padding-left:30px">Quên mật khẩu ?</a>
                    </div>
                    <div class="col-lg-12 d-flex justify-content-center">             
                        <button class="btn btn-register" type="submit">Đăng nhập</button>
                    </div>
                    
                    </div>
                </div>
        
            </form>
            <div class="justify-content-center d-flex">
                <div class="mb-1 mt-1 d-flex justify-content-center login-seperator">
                    Hoặc đăng nhập với
                </div>
            </div>
            <div class="">
                    
                <div class="row ">
                    <div class="col-md-12  d-flex justify-content-center ">
                        <a class="btn btn-login-facebook" href="{{ route('facebook.login') }}" ><i class="fa-brands fa-facebook"></i> <span>Đăng nhập với Facebook</span></a>
                    </div>
                    <div class="col-md-12 d-flex justify-content-center">
                        <a class="btn btn-login-google" href="{{ route('google.login') }}"><i class="fa-brands fa-google"></i> <span>Đăng nhập với Google</span></a>
                    </div>
                </div>
            </div>
        </x-cardbody>
    </div>
@endsection
