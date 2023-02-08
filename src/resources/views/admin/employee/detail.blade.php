@extends('admin.layouts.main')
@section('head')
<link href="{{ asset('admin/assets/plugins/bootstrap-colorpicker/css/bootstrap-colorpicker.min.css') }}" rel="stylesheet">
<link href="{{ asset('admin/assets/plugins/bootstrap-md-datetimepicker/css/bootstrap-material-datetimepicker.css') }}" rel="stylesheet">
<link href="{{ asset('admin/assets/plugins/select2/css/select2.min.css')}}" rel="stylesheet" type="text/css">
<link href="{{ asset('admin/assets/plugins/bootstrap-touchspin/css/jquery.bootstrap-touchspin.min.css')}}" rel="stylesheet">
@endsection
@section('main-content')
    <div class="row">
        <div class="col-sm-12">
            <div class="page-title-box">
                <h4 class="page-title">Manage Employee</h4>
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="javascript:void(0);">Dashboard</a></li>
                    <li class="breadcrumb-item"><a href="javascript:void(0);">List Employee</a></li>
                    <li class="breadcrumb-item active"><a href="javascript:void(0);">Create</a></li>
                </ol>
            </div>
        </div>
    </div>

    <x-cardbody title="Chi tiết nhân viên">
        <form class="form" action="{{ route('admin.employee.update') }}" method="POST" enctype="multipart/form-data">
            @csrf
            <input type="hidden" value="{{ $data->ID}}" name="id"> 
            <input type="hidden" value="{{ $data->profile->ID}}" name="belong_to"> 
            <x-inputtext title="Họ và tên" name="name" value="{{ old('name', $data->profile->name)}}" placeholder="Nhập họ và tên" id="name" disable="true"></x-inputtext>
            @if($errors->has('name'))
                <div class="error"> {{ $errors->first('name') }} </div>
            @endif
            <div class="row">
                <div class="col-sm">
                <x-inputdate title="Ngày sinh" name="date" value="{{ old('date', $data->profile->date_of_birth)}}" id="date" disable="true" ></x-inputdate>
                @if($errors->has('date'))
                <div class="error"> {{ $errors->first('date') }} </div>
                @endif
                </div>
                <div class="col-sm">
                    <x-inputtext title="Địa chỉ" name="address" value="{{ old('address', $data->profile->address)}}" placeholder="Nhập địa chỉ" id="address" disable="true"></x-inputtext>
                    @if($errors->has('address'))
                        <div class="error"> {{ $errors->first('address') }} </div>
                    @endif
                </div>
                <div class="col-sm">
                    <x-inputtext title="Nơi sinh" name="born_place" value="{{ old('born_place', $data->profile->born_place)}}" placeholder="Nhập nơi sinh" id="born_place" disable="true"></x-inputtext>
                    @if($errors->has('born_place'))
                        <div class="error"> {{ $errors->first('born_place') }} </div>
                    @endif
                </div>
            </div>
            
            <div class="row">
                <div class="col-sm">
                    <x-inputtext title="Căn cước công dân/ CMND" type="number" name="ccid" value="{{ old('ccid', $data->profile->CCID)}}" placeholder="097362526373" id="ccid" disable="true"></x-inputtext>  
                    @if($errors->has('ccid'))
                        <div class="error"> {{ $errors->first('ccid') }} </div>
                    @endif
                </div>
                <div class="col-sm">
                    <x-inputtext title="Số điện thoại" type="number" name="phonenumber" value="{{ old('phonenumber', $data->profile->phone_number)}}" placeholder="0123 456 789" id="phonenumber" disable="true"></x-inputtext>
                    @if($errors->has('phonenumber'))
                        <div class="error"> {{ $errors->first('phonenumber') }} </div>
                    @endif
                </div>
                <div class="col-sm">
                    <x-inputtext title="Email" name="email" type="email" value="{{ old('email', $data->profile->email)}}" placeholder="youemail@gmail.com" id="email" disable="true"></x-inputtext>
                    @if($errors->has('email'))
                        <div class="error"> {{ $errors->first('email') }} </div>
                    @endif
                </div>
            </div>

            <x-inputtext title="Tài khoản" name="username" value="{{ old('username', $data->username)}}" placeholder="Thêm tài khoản" id="username" disable="true"></x-inputtext>
            @if($errors->has('username'))
                <div class="error"> {{ $errors->first('username') }} </div>
            @endif
            <x-inputtext title="Chức vụ" name="role" value="{{ old('role', $data->role)}}" placeholder="Thêm chức vự" id="role" disable="true"></x-inputtext>
            @if($errors->has('role'))
                <div class="error"> {{ $errors->first('role') }} </div>
            @endif
            @include('admin.components.form-status')
        </form>
        
    </x-cardbody>
@endsection

@section('script')
    <script src="{{ asset('admin/assets/plugins/jquery-sparkline/jquery.sparkline.min.js') }}"></script>
    <script src="{{ asset('admin/assets/plugins/bootstrap-md-datetimepicker/js/moment-with-locales.min.js') }}"></script>
    <script src="{{ asset('admin/assets/plugins/bootstrap-md-datetimepicker/js/bootstrap-material-datetimepicker.js') }}"></script>

    <!-- Plugins js -->
    <script src="{{ asset('admin/assets/plugins/bootstrap-colorpicker/js/bootstrap-colorpicker.min.js') }}"></script>

    <script src="{{ asset('admin/assets/plugins/select2/js/select2.min.js') }}"></script>
    <script src="{{ asset('admin/assets/plugins/bootstrap-maxlength/bootstrap-maxlength.min.js') }}"></script>
    <script src="{{ asset('admin/assets/plugins/bootstrap-filestyle/js/bootstrap-filestyle.min.js') }}"></script>
    <script src="{{ asset('admin/assets/plugins/bootstrap-touchspin/js/jquery.bootstrap-touchspin.min.js') }}"></script>

    <!-- Plugins Init js -->
    <script src="{{ asset('admin/assets/pages/form-advanced.js') }}"></script>
@endsection