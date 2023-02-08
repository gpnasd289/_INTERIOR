@extends('admin.layouts.main')
@section('head')
    <!-- DataTables -->
    <link href="{{ asset('admin/assets/plugins/datatables/dataTables.bootstrap4.min.css')}}" rel="stylesheet" type="text/css" />
    <link href="{{ asset('admin/assets/plugins/datatables/buttons.bootstrap4.min.css') }}" rel="stylesheet" type="text/css" />
        <!-- Responsive datatable examples -->
    <link href="{{ asset('admin/assets/plugins/datatables/responsive.bootstrap4.min.css') }}" rel="stylesheet" type="text/css" />
@endsection

@section('main-content')
    <div class="row">
        <div class="col-sm-12">
            <div class="page-title-box">
                <h4 class="page-title">Quản lý khách hàng</h4>
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="javascript:void(0);">Dashboard</a></li>
                    <li class="breadcrumb-item active"><a href="javascript:void(0);">Khách hàng</a></li>
                </ol>
            </div>
        </div>
    </div>
    <x-cardbody title="Danh sách khách hàng">
            <table id="datatable" class="table table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Tài khoản</th>
                    <th>Google ID</th>
                    <th>Facebook ID</th>
                    <th>Tổng tiền (VND)</th>
                    <th>Tên</th>
                    <th>Ngày tạo</th>
                    <th>Ngày cập nhật</th>
                    <th>Chức năng</th>
                </tr>
                </thead>
                <tbody>
                    @foreach($list as $line)
                        <tr id="r-{{ $line -> ID}}">
                            <td>{{ $line-> ID }}</td>
                            <td>{{ $line-> username }}</td>
                            <td>{{ $line-> google_id }}</td>
                            <td>{{ $line-> facebook_id }}</td>
                            <td>{{ $line-> totalpay() }}</td>
                            <td>{{ $line-> profile -> name }}</td>
                            <td>{{ $line-> created_at() }}</td>
                            <td>{{ $line-> updated_at() }}</td>
                            <td >
                                <x-row-function :item="$line" :prefix="$route_prefix"> </x-row-function>
                            </td>
                        </tr>
                    @endforeach               
                </tbody>
            </table>
        </x-cardbody>
    
        <div class="d-flex justify-content-center">
            {!! $list->links() !!}
        </div>
      
    </div>
    <!-- end page content-->
<!-- end row -->
@endsection
@section('script')

        <!-- Required datatable js -->
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

        <!-- Datatable init js -->
        <script src="{{ asset('admin/assets/pages/datatables.init.js') }}"></script>
@endsection 
