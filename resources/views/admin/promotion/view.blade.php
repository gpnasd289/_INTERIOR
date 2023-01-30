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
                <h4 class="page-title">Manage Promotion</h4>
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="javascript:void(0);">Dashboard</a></li>
                    <li class="breadcrumb-item active"><a href="javascript:void(0);">Promotion</a></li>
                </ol>
            </div>
        </div>
    </div>
    <x-cardbody title="Danh sách mã giảm giá">
            <table id="datatable" class="table table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Description</th>
                    <th>Quantity</th>
                    <th>Status</th>
                    <th>Create At</th>
                    <th>Update At</th>
                    <th>Function</th>
                </tr>
                </thead>
                <tbody>
                    @foreach($list as $line)
                        <tr id="r-{{ $line -> ID}}">
                            <td>{{ $line-> ID }}</td>
                            <td>{{ $line-> title }}</td>
                            <td>{{ $line-> description }}</td>
                            <td>{{ $line-> quantity }}</td>
                            <td> @include('admin.components.badge',['status' => $line -> status]) </td>
                            <td>{{ $line-> created_at() }}</td>
                            <td>{{ $line-> updated_at() }}</td>
                            <td>
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
