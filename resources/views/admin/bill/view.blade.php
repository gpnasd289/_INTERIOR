@extends('admin.layouts.main')
@section('head')
    <!-- DataTables -->
    <link href="{{ asset('admin/assets/plugins/datatables/dataTables.bootstrap4.min.css')}}" rel="stylesheet" type="text/css" />
    <link href="{{ asset('admin/assets/plugins/datatables/buttons.bootstrap4.min.css') }}" rel="stylesheet" type="text/css" />
        <!-- Responsive datatable examples -->
    <link href="{{ asset('admin/assets/plugins/datatables/responsive.bootstrap4.min.css') }}" rel="stylesheet" type="text/css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.10.1/html2pdf.bundle.min.js" integrity="sha512-GsLlZN/3F2ErC5ifS5QtgpiJtWd43JWSuIgh7mbzZ8zBps+dvLusV+eNQATqgA/HdeKFVgA5v3S/cIrLF7QnIg==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
@endsection

@section('main-content')
    <div class="row">
        <div class="col-sm-12">
            <div class="page-title-box">
                <h4 class="page-title">Manage Bill</h4>
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="javascript:void(0);">Dashboard</a></li>
                    <li class="breadcrumb-item active"><a href="javascript:void(0);">Bill</a></li>
                </ol>
            </div>
        </div>
    </div>
    <x-cardbody title="List Blog">
        <a href="{{ route('admin.bill.pdf', ['id' => '48']) }}">test</a>
            <table id="datatable" class="table table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Người mua</th>
                    <th>Tổng tiền (VND)</th>
                    <td>Trạng thái</td>
                    <th>Ngày tạo</th>
                    <th>Ngày sửa đổi</th>
                    <th>Chức năng</th>
                </tr>
                </thead>
                <tbody>
                    @foreach($list as $line)
                        <tr id="r-{{ $line -> ID}}">
                            <td class="bill-link" data-url="{{ route('admin.bill.detail',['id' => $line -> ID ])}}"> {{ $line-> ID }} </td>
                            <td>{{ $line-> customer_name() }}</td>
                            <td>{{ $line-> total() }}</td>
                            <td><span class="{{ $line -> badgeStatus() }}"><i class="mdi mdi-checkbox-blank-circle"></i> {{ $line-> status() }}</span></td>
                            <td>{{ $line-> created_at() }}</td>
                            <td>{{ $line-> updated_at() }}</td>
                            <td>
                                <x-row-function :item="$line" :prefix="$route_prefix" detail="bill-detail"> </x-row-function>
                            </td>
                        </tr>
                    @endforeach               
                </tbody>
            </table>
        </x-cardbody>
        @include('admin.bill.modal_bill_detail')
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

        <script src="{{ asset('admin/assets/js/bill.js') }}"></script>
@endsection 
