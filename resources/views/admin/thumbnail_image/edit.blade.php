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
                <h4 class="page-title">Quản lý ảnh</h4>
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="javascript:void(0);">Dashboard</a></li>
                    <li class="breadcrumb-item"><a href="javascript:void(0);">Quản lý ảnh</a></li>
                    <li class="breadcrumb-item active"><a href="javascript:void(0);">Tạo mới</a></li>
                </ol>
            </div>
        </div>
    </div>

    <x-cardbody title="Create Thumbnail">
        <form class="form" action="{{ route('admin.thumbnail.store') }}" method="POST" enctype="multipart/form-data">
            @csrf
          
            <x-imagebutton title="Thêm Ảnh" id="1" src="" :preview="null" :product="null"></x-imagebutton>
            @if($errors->has('file_1'))
                <div class="error"> {{ $errors->first('file_1') }} </div>
            @endif

            <div class="form-group" class="margin-top:20px">
                <label for="status" class="control-label">Trạng thái </label>
                <div class="form-group">
                    <select class="form-control"  name="status" id="status">
                        <option value="1" style="color:green">Hiển thị </option>
                        <option value="0" style="color:red">Ẩn </option>
                    </select>
                </div>
            </div>
            @if($errors->has('status'))
                <div class="error"> {{ $errors->first('status') }} </div>
            @endif

            <div class="form-group" class="margin-top:20px">
                <label for="position" class="control-label">Vị trí</label>
                <div class="form-group">
                    <select class="form-control" name="position" id="position" >
                        <option value="-1">Chọn vị trí Ảnh </option>
                        <option value="1">Vị trí Ảnh bìa 1</option>
                        <option value="2">Vị trí Ảnh bìa 2</option>
                        <option value="3">Vị trí Ảnh bìa 3</option>
                        <option value="4">Vị trí Ảnh bìa 4</option>
                        <option value="5">Vị trí Ảnh bìa 5</option>
                        <option value="6">Vị trí Ảnh bìa sản phẩm mới</option>
                    </select>
                </div>
            </div>
            @if($errors->has('position'))
                <div class="error"> {{ $errors->first('position') }} </div>
            @endif


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
    <script src="/vendor/laravel-filemanager/js/stand-alone-button.js"></script>
    <script>
        var route_prefix = "/admin/laravel-filemanager?type=Files";
           
        $('#file_1').filemanager('image', {prefix: route_prefix}); 
    </script>



       
    <!-- Plugins Init js -->
    <script src="{{ asset('admin/assets/pages/form-advanced.js') }}"></script>
@endsection@extends('admin.layouts.main')
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
                <h4 class="page-title">Quản lý ảnh</h4>
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="javascript:void(0);">Dashboard</a></li>
                    <li class="breadcrumb-item"><a href="javascript:void(0);">Quản lý ảnh</a></li>
                    <li class="breadcrumb-item active"><a href="javascript:void(0);">Tạo mới</a></li>
                </ol>
            </div>
        </div>
    </div>

    <x-cardbody title="Edit Thumbnail">
        <form class="form" action="{{ route('admin.thumbnail.store') }}" method="POST" enctype="multipart/form-data">
            @csrf

            <x-imagebutton title="Thêm Ảnh" id="1" src="{{ $thumbnail -> file_path }}" :preview="null" :product="null"></x-imagebutton>
            @if($errors->has('file_1'))
                <div class="error"> {{ $errors->first('file_1') }} </div>
            @endif

            <div class="form-group" class="margin-top:20px">
                <label for="status" class="control-label">Trạng thái </label>
                <div class="form-group">
                    <select class="form-control"  name="status" id="status" value="1">
                        <option value="1" style="color:green">Hiển thị </option>
                        <option value="0" style="color:red">Ẩn </option>
                    </select>
                </div>
            </div>
            @if($errors->has('status'))
                <div class="error"> {{ $errors->first('status') }} </div>
            @endif

            <div class="form-group" class="margin-top:20px">
                <label for="position" class="control-label">Vị trí</label>
                <div class="form-group">
                    <select class="form-control" name="position" id="position" value="{{ $thumbnail -> position }}">
                        <option value="-1">Chọn vị trí Ảnh </option>
                        <option value="1">Vị trí Ảnh bìa 1</option>
                        <option value="2">Vị trí Ảnh bìa 2</option>
                        <option value="3">Vị trí Ảnh bìa 3</option>
                        <option value="4">Vị trí Ảnh bìa 4</option>
                        <option value="5">Vị trí Ảnh bìa 5</option>
                        <option value="6">Vị trí Ảnh bìa sản phẩm mới</option>
                    </select>
                </div>
            </div>
            @if($errors->has('position'))
                <div class="error"> {{ $errors->first('position') }} </div>
            @endif


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
    <script src="/vendor/laravel-filemanager/js/stand-alone-button.js"></script>
    <script>
        var route_prefix = "/admin/laravel-filemanager?type=Files";
        $('#file_1').filemanager('image', {prefix: route_prefix}); 
    </script>

    <!-- Plugins Init js -->
    <script src="{{ asset('admin/assets/pages/form-advanced.js') }}"></script>
@endsection