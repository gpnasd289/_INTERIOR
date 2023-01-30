@extends('admin.layouts.main')
@section('head')
<link href="{{ asset('admin/assets/plugins/datatables/dataTables.bootstrap4.min.css')}}" rel="stylesheet" type="text/css" />
<link href="{{ asset('admin/assets/plugins/bootstrap-colorpicker/css/bootstrap-colorpicker.min.css') }}" rel="stylesheet">
<link href="{{ asset('admin/assets/plugins/datatables/responsive.bootstrap4.min.css') }}" rel="stylesheet" type="text/css" />
<link href="{{ asset('admin/assets/plugins/bootstrap-md-datetimepicker/css/bootstrap-material-datetimepicker.css') }}" rel="stylesheet">
<link href="{{ asset('admin/assets/plugins/select2/css/select2.min.css')}}" rel="stylesheet" type="text/css">
<link href="{{ asset('admin/assets/plugins/bootstrap-touchspin/css/jquery.bootstrap-touchspin.min.css')}}" rel="stylesheet">
@endsection
@section('main-content')
    <div class="row">
        <div class="col-sm-12">
            <div class="page-title-box">
                <h4 class="page-title">Quản lý mã giảm giá</h4>
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="javascript:void(0);">Dashboard</a></li>
                    <li class="breadcrumb-item"><a href="javascript:void(0);">Danh sách mã giảm giá</a></li>
                    <li class="breadcrumb-item active"><a href="javascript:void(0);">Tạo mới</a></li>
                </ol>
            </div>
        </div>
    </div>

    <x-cardbody title="Tạo mới mã giảm giá">
        <form class="form" action="{{ route('admin.promotion.store') }}" method="POST" enctype="multipart/form-data">
            @csrf
             <x-inputtext title="Mã giảm giá" name="title" value="{{ old('title', 'AA')}}" placeholder="Nhập mã giảm giá ví dụ: CHAOMUNG2022MINN19" id="title"></x-inputtext>       
             @if($errors->has('title'))
                <div class="error"> {{ $errors->first('title') }} </div>
            @endif 
            <x-inputtext title="Mô tả" name="description" value="{{ old('description', 'a')}}" placeholder="Nhập mô tả mã giảm giá" id="description"></x-inputtext>
            @if($errors->has('description'))
                <div class="error"> {{ $errors->first('description') }} </div>
            @endif 
            <div class="row">
                <div class="col-md-6">
                        <div class="form-group">
                        <label class="control-label" for="promotion_apply" required>Áp dụng cho</label>
                        <br>
                        <label  class="w-100" for="promotion_apply">
                            <input type="radio" name="promotion_apply"  value="1"  checked/>  Cho toàn bộ sản phẩm
                        </label>
                        <br>
                        <label  class="w-100" for="promotion_apply">
                            <input type="radio" name="promotion_apply" value="2"  />  Theo danh mục sản phẩm
                            <div>
                                <input type="text" name="promotion_category_apply_value" id="promotion_category_apply_value" value="" class="form-control" readonly>
                            </div>
                        </label>
                        <br>
                        <label  class="w-100" for="promotion_apply">
                        <input type="radio" name="promotion_apply" value="3"  />  Theo sản phẩm cụ thể
                        <div>
                            <input type="text" name="promotion_product_apply_value" id="promotion_product_apply_value" value="" class="form-control" readonly>
                        </div>
                        </label>  
                        @if($errors->has('promotion_apply'))
                                <div class="error"> {{ $errors->first('promotion_apply') }} </div>
                            @endif 
                    </div>
                </div>
                <div class="col-md-6">
                        <div class="form-group">
                        <label class="control-label" for="promotion_condition"  required>Điều kiện áp dụng</label>
                        <br>

                        <label class="w-60">
                            <input type="radio" class="promotion_condition" name="promotion_condition" checked value="0"  />  Không cần điều kiện     
                        </label>
                        <br>

                    <label  class="w-60">
                            <input type="radio" class="promotion_condition" name="promotion_condition"  value="1"  />  Tổng giá trị đơn hàng thấp nhất
                            <div class="lowest-total-bill">
                                <input type="number" name="condition_value_lowest_bill" class="form-control" value="{{ old('condition_value_lowest_bill','') }}" placeholder="100000, 200000 VND">
                            </div>
                        </label>
                        <br>
                        <label  class="w-60">
                            <input type="radio" class="promotion_condition" name="promotion_condition"  value="2"  />  Giới hạn số tiền giảm giá
                            <div class="minimum-money-discount">
                                <input type="number" name="condition_value_minimum_money" class="form-control" value="{{ old('condition_value_minimum_money','') }}" placeholder="100000, 200000 VND">
                            </div>
                        </label>
                        <br>
                        <label>
                            <input type="radio" class="promotion_condition" name="promotion_condition"  value="3"  />  Giới hạn số lượng sản phẩm trong một đơn hàng
                            <div class="minimum-product">
                                <input type="number" name="condition_value_minimum_product" class="form-control" value="{{ old('condition_value_minimum_product','') }}" placeholder="100000, 200000 VND">
                            </div>
                        </label>
                        @if($errors->has('promotion_condition'))
                                <div class="error"> {{ $errors->first('promotion_condition') }} </div>
                            @endif
                    </div>
                        </div>
                </div>
           
            <div class="form-group">
            <label for="start_date" class="control-label" required>Ngày bắt đầu</label>
                <div>
                <div class="form-group w-60" style="width:300px;">
                        <input type="date" class="form-control" value="{{ old('start_date', '01/03/2021')}}" placeholder="dd/mm/yyyy" id="start_date" name="start_date">
                    </div>
                    @if($errors->has('start_date'))
                        <div class="error"> {{ $errors->first('start_date') }} </div>
                    @endif
                </div>
            </div>
            <div class="form-group">
                <label for="end_date" class="control-label" required>Ngày kết thúc</label>
                <div>
                    <div class="form-group w-60" style="width:300px;">
                        <input type="date" class="form-control" value="{{ old('end_date', '31/03/2022')}}" placeholder="dd/mm/yyyy" id="end_date" name="end_date">
                    </div>
                    @if($errors->has('end_date'))
                        <div class="error"> {{ $errors->first('end_date') }} </div>
                    @endif
                </div>
            </div>

            <x-inputtext title="Số lượng mã giảm giá" name="quantity" value="{{ old('quantity', '100')}}" type="number" placeholder="Nhập số lượng mã giảm giá"></x-inputtext>
            <div class="form-group">
                <label for="discount_type">Loại giảm giá</label>
                <div class="form-group">
                    <label  class="w-60">
                        <input type="radio"  name="discount_type"  value="1"  />  Giảm theo phần trăm (%) 
                    </label>
                    <br>
                    <label  class="w-60">
                        <input type="radio"  name="discount_type"  value="2"  />  Giảm giá tiền
                    </label>
                </div>
          
                <input type="number" name="discount_value" class="form-control" value="{{ old('discount_value','') }}" placeholder="mức giảm giá">
            </div>
            @include('admin.components.form-status')
            <button class="btn btn-danger" type="submit">Tạo mới </button>
        </form>

        <div class="modal fade" id="select-product-modal" tabindex="-1" role="dialog" aria-labelledby="select modal" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Chọn sản phẩm</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body" class="width:auto;">
                    <table id="modaltable" class="table table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;">
                        <thead>
                        <tr>
                            <th></th>
                            <th>ID</th>
                            <th>Tên sản phẩm</th>
                            <th>Số lượng</th>
                            <th>Giá bán</th>
                        </tr>
                        </thead>
                        <tbody>
                            @foreach($product as $line)
                                <tr id="r-{{ $line -> ID}}">
                                    <td> <input type="checkbox" name="{{ $line -> ID }}" data-id="{{ $line -> ID}}"></td>
                                    <td>{{ $line-> ID }}</td>
                                    <td>{{ $line-> name }}</td>
                                    <th>{{ $line-> quantity }}</th>
                                    <th>{{ $line-> getPrice() }}</th>
                                </tr>
                            @endforeach               
                        </tbody>
                    </table>
                    <div class="d-flex justify-content-center">
                        {!! $product->links() !!}
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-success" data-dismiss="modal" id="modal-product-apply-btn">Áp dụng</button>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Đóng</button>
                </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="select-category-modal" tabindex="-1" role="dialog" aria-labelledby="select modal" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Chọn loại sản phẩm phẩm</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body" class="width:auto;">
                    <table id="modaltablecategory" class="table table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;">
                        <thead>
                        <tr>
                            <th></th>
                            <th>ID</th>
                            <th>Tên loại sản phẩm</th>
                            <th>Mô tả</th>
                            
                        </tr>
                        </thead>
                        <tbody>
                            @foreach($category as $line)
                                <tr id="r-{{ $line -> ID}}">
                                    <td> <input type="checkbox" name="{{ $line -> ID }}" data-id="{{ $line -> ID}}"></td>
                                    <td>{{ $line-> ID }}</td>
                                    <td>{{ $line-> name }}</td>
                                    <th>{{ $line-> description }}</th>
                                </tr>
                            @endforeach               
                        </tbody>
                    </table>
                    <div class="d-flex justify-content-center">
                        {!! $category->links() !!}
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-success" data-dismiss="modal" id="modal-category-apply-btn">Áp dụng</button>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Đóng</button>
                </div>
                </div>
            </div>
        </div>
    </x-cardbody>
@endsection

@section('script')
    <script src="{{ asset('admin/assets/plugins/jquery-sparkline/jquery.sparkline.min.js') }}"></script>
    <script src="{{ asset('admin/assets/plugins/bootstrap-md-datetimepicker/js/moment-with-locales.min.js') }}"></script>
    <script src="{{ asset('admin/assets/plugins/bootstrap-md-datetimepicker/js/bootstrap-material-datetimepicker.js') }}"></script>

    <!-- Plugins js -->
    <script src="{{ asset('admin/assets/plugins/bootstrap-colorpicker/js/bootstrap-colorpicker.min.js') }}"></script>
    <script src="{{ asset('admin/assets/plugins/datatables/dataTables.buttons.min.js') }}"></script>
    <script src="{{ asset('admin/assets/plugins/select2/js/select2.min.js') }}"></script>
    <script src="{{ asset('admin/assets/plugins/bootstrap-maxlength/bootstrap-maxlength.min.js') }}"></script>
    <script src="{{ asset('admin/assets/plugins/bootstrap-filestyle/js/bootstrap-filestyle.min.js') }}"></script>
    <script src="{{ asset('admin/assets/plugins/bootstrap-touchspin/js/jquery.bootstrap-touchspin.min.js') }}"></script>
    <script src="{{ asset('admin/assets/js/promotion.js') }}"></script>
    <!-- Plugins Init js -->
    <script src="{{ asset('admin/assets/pages/form-advanced.js') }}"></script>
    <script src="{{ asset('admin/assets/plugins/datatables/jquery.dataTables.min.js') }}"></script>
        <script src="{{ asset('admin/assets/plugins/datatables/dataTables.bootstrap4.min.js') }}"></script>
        <!-- Buttons examples -->
        <script src="{{ asset('admin/assets/plugins/datatables/dataTables.buttons.min.js') }}"></script>
        <script src="{{ asset('admin/assets/plugins/datatables/buttons.bootstrap4.min.js') }}"></script>
        <script src="{{ asset('admin/assets/plugins/datatables/jszip.min.js') }}"></script>
        <script src="{{ asset('admin/assets/plugins/datatables/pdfmake.min.js') }}"></script>
        <script src="{{ asset('admin/assets/plugins/datatables/vfs_fonts.js') }}"></script>
        <script src="{{ asset('admin/assets/plugins/datatables/buttons.html5.min.js') }}"></script>
        <script src="{{ asset('admin/assets/plugins/datatables/buttons.print.min.js') }}"></script>
        <script src="{{ asset('admin/assets/plugins/datatables/buttons.colVis.min.js') }}"></script>
        <!-- Responsive examples -->
        <script src="{{ asset('admin/assets/plugins/datatables/dataTables.responsive.min.js') }}"></script>
        <script src="{{ asset('admin/assets/plugins/datatables/responsive.bootstrap4.min.js') }}"></script>
@endsection