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

    <x-cardbody title="Create Employee">
        <form class="form" action="{{ route('admin.employee.store') }}" method="POST" enctype="multipart/form-data">
            @csrf
            <x-inputtext title="Name" name="name" value="{{ old('name', 't')}}" placeholder="Enter employee name ..." id="name"></x-inputtext>
            @if($errors->has('name'))
                <div class="error"> {{ $errors->first('name') }} </div>
            @endif
            <div class="row">
                <div class="col-sm">
                <x-inputdate title="Date Of Birth" name="date" value="{{ old('date', '')}}" id="date"></x-inputdate>
                @if($errors->has('date'))
                <div class="error"> {{ $errors->first('date') }} </div>
                @endif
                </div>
                <div class="col-sm">
                    <x-inputtext title="Address" name="address" value="{{ old('address', 't')}}" placeholder="Enter your address ..." id="address"></x-inputtext>
                    @if($errors->has('address'))
                        <div class="error"> {{ $errors->first('address') }} </div>
                    @endif
                </div>
                <div class="col-sm">
                    <x-inputtext title="Born Place" name="born_place" value="{{ old('born_place', 't')}}" placeholder="Enter your born place ..." id="born_place"></x-inputtext>
                    @if($errors->has('born_place'))
                        <div class="error"> {{ $errors->first('born_place') }} </div>
                    @endif
                </div>
            </div>
            
            <div class="row">
                <div class="col-sm">
                    <x-inputtext title="CCID" type="number" name="ccid" value="{{ old('ccid', '1')}}" placeholder="Enter your CCID" id="ccid"></x-inputtext>  
                    @if($errors->has('ccid'))
                        <div class="error"> {{ $errors->first('ccid') }} </div>
                    @endif
                </div>
                <div class="col-sm">
                    <x-inputtext title="Phone Number" type="number" name="phonenumber" value="{{ old('phonenumber', '1')}}" placeholder="Enter your Phone Number ..." id="phonenumber"></x-inputtext>
                    @if($errors->has('phonenumber'))
                        <div class="error"> {{ $errors->first('phonenumber') }} </div>
                    @endif
                </div>
                <div class="col-sm">
                    <x-inputtext title="Email" name="email" type="email" value="{{ old('email', 'hihi@gmail.com')}}" placeholder="youemail@gmail.com" id="email"></x-inputtext>
                    @if($errors->has('email'))
                        <div class="error"> {{ $errors->first('email') }} </div>
                    @endif
                </div>
            </div>

            <x-inputtext title="Username" name="username" value="{{ old('username', '')}}" placeholder="Enter new username" id="username"></x-inputtext>
            @if($errors->has('username'))
                <div class="error"> {{ $errors->first('username') }} </div>
            @endif
            <x-inputtext title="Password" name="password" type="text" value="{{ old('password', '12345678') }}" placeholder="Enter Password" id="password"></x-inputtext>
            @if($errors->has('password'))
                <div class="error"> {{ $errors->first('password') }} </div>
            @endif
            <x-inputtext title="Confirm Password" type="text" name="confirm_password" value="{{ old('confirm_password', '123456789') }}" placeholder="Confirm password" id="confirm_password"></x-inputtext>
            @if(session('error')) 
                <div class="error"> {{ session('error') }} </div>
            @endif
            @if($errors->has('confirm_password'))
                <div class="error"> {{ $errors->first('confirm_password') }} </div>
            @endif
            <x-inputtext title="Role" name="role" value="{{ old('role', '1')}}" placeholder="Enter role" id="role"></x-inputtext>
            @if($errors->has('role'))
                <div class="error"> {{ $errors->first('role') }} </div>
            @endif
            @include('admin.components.form-status')
            <button class="btn btn-danger" type="submit">Create</button>
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