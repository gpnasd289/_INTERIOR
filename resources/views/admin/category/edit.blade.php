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
                <h4 class="page-title">Quản lý loại sản phẩm</h4>
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="javascript:void(0);">Dashboard</a></li>
                    <li class="breadcrumb-item"><a href="javascript:void(0);">Danh sách loại sản phẩm</a></li>
                    <li class="breadcrumb-item active"><a href="javascript:void(0);">Chỉnh sửa</a></li>
                </ol>
            </div>
        </div>
    </div>

    <x-cardbody title="Chỉnh sửa loại sản phẩm">
        <form class="form" action="{{ route('admin.category.update') }}" method="POST" enctype="multipart/form-data">
            <input name="id" value="{{ $data->ID }} " type="hidden">
            @csrf
            <x-inputtext title="Name" name="name" value="{{ old('name', $data->name)}}" placeholder="Enter category name ..." id="name"></x-inputtext>
            @if($errors->has('name'))
                <div class="error"> {{ $errors->first('name') }} </div>
            @endif

            <x-inputareaedit title="Description" rows="6" name="description" value="{{ old('description', $data-> description)}}" placeholder="Enter description  ..." id="description"></x-inputareaedit>
            @if($errors->has('description'))
                <div class="error"> {{ $errors->first('description') }} </div>
            @endif  
           
            <x-inputoption :options="$option" name="parent_id" title="Category Parent" :selected="$selected"></x-inputoption>
            @include('admin.components.form-status')
            <button class="btn btn-danger" type="submit">Update</button>
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