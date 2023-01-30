@extends('admin.layouts.main')
@section('head')
    <!-- DataTables -->
    <link href="{{ asset('admin/assets/plugins/datatables/dataTables.bootstrap4.min.css')}}" rel="stylesheet" type="text/css" />
    <link href="{{ asset('admin/assets/plugins/datatables/buttons.bootstrap4.min.css') }}" rel="stylesheet" type="text/css" />
        <!-- Responsive datatable examples -->
    <link href="{{ asset('admin/assets/plugins/datatables/responsive.bootstrap4.min.css') }}" rel="stylesheet" type="text/css" />


    <style>
        td {
            white-space: normal !important; 
            word-wrap: break-word;
        }
    </style>
@endsection

@section('main-content')
    <div class="row">
        <div class="col-sm-12">
            <div class="page-title-box">
                <h4 class="page-title">Quản lý loại sản phẩm</h4>
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="javascript:void(0);">Dashboard</a></li>
                    <li class="breadcrumb-item active"><a href="javascript:void(0);">Loại sản phẩm</a></li>
                </ol>
            </div>
        </div>
    </div>
    <x-cardbody title="List Category">
            <table id="datatable" class="table table-bordered dt-responsive" style="border-collapse: collapse; border-spacing: 0; width: 100%;">
                <thead> 
                <tr>
                    <th>ID</th>
                    <th>Tên loại sản phẩm</th>
                    <th >Mô tả</th>
                    <th>Loại sản phẩm cha</th>
                    <th>Trạng thái</th>
                    <th></th>
                </tr>
                </thead>
                <tbody>
                    @foreach($list as $line)
                        <tr id="r-{{ $line -> ID}}">
                            <td style="width:100px; max-width:100px;">{{ $line-> ID }}</td>
                            <td style="width:200px; max-width:200px;">{{ $line-> name }}</td>
                            <td style="width: 300px; max-width:300px;">{{ $line-> description }}</td>
                            <td>{{ $line-> parent->name ?? 'NONE'}}</td>
                            <td> @include('admin.components.badge',['status' => $line -> status])</td>
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
