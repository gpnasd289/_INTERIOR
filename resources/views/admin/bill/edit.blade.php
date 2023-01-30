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
                <h4 class="page-title">Manage Category</h4>
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="javascript:void(0);">Dashboard</a></li>
                    <li class="breadcrumb-item"><a href="javascript:void(0);">Đơn hàng</a></li>
                    <li class="breadcrumb-item active"><a href="javascript:void(0);">Chỉnh sửa</a></li>
                </ol>
            </div>
        </div>
    </div>
    <x-cardbody title="Chỉnh sửa đơn hàng">
        <form class="form" action="{{ route('admin.bill.update') }}" method="POST" enctype="multipart/form-data">
            @csrf
            <input name="id" value="{{ $data->ID }} " type="hidden">
            <label for="status">Trạng thái đơn hàng</label>
            <div class="form-group">
                <select name="status" class="form-control">
                    @if($data -> status == 1) 
                        <option value="1" selected>Đơn hàng mới</option>
                    @else
                        <option value="1">Đơn hàng mới</option>
                    @endif
                    @if($data -> status == 2) 
                        <option value="2" selected>Đã xác nhận</option>
                    @else
                        <option value="2">Đã xác nhận</option>
                    @endif
                    @if($data -> status == 3) 
                        <option value="3" selected>Đang đóng gói</option>
                    @else
                        <option value="3">Đang đóng gói</option>
                    @endif
                    @if($data -> status == 4) 
                        <option value="4" selected>Đang giao hàng</option>
                    @else
                        <option value="4">Đang giao hàng</option>
                    @endif
                    @if($data -> status == 5) 
                        <option value="5" selected>Đã giao hàng</option>
                    @else
                        <option value="5">Đã giao hàng</option>
                    @endif
                    @if($data -> status == 6) 
                        <option value="6" selected>Hoàn thành</option>
                    @else
                        <option value="6">Hoàn thành</option>
                    @endif
                    @if($data -> status == 7) 
                        <option value="7" selected>Đã hủy</option>
                    @else
                        <option value="7">Đã hủy</option>
                    @endif
                </select>
            </div>
            <button class="btn btn-danger" type="submit">Chỉnh sửa</button>
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