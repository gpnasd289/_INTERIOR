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
                <h4 class="page-title">Quản lý bài viết</h4>
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="javascript:void(0);">Dashboard</a></li>
                    <li class="breadcrumb-item active"><a href="javascript:void(0);">Bài viết</a></li>
                </ol>
            </div>
        </div>
    </div>
    <x-cardbody title="List Blog">
            <table id="datatable" class="table table-bordered dt-responsive" style="border-collapse: collapse; border-spacing: 0; width: 100%;">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Tiêu đề</th>
                    <th>Mô tả</th>
                    <th>Tác giả</th>
                    <th>Sửa đổi bởi</th>
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
                            <td style="max-width: 200px;">{{ $line-> description }}</td>
                            <td>{{ $line-> authorPost -> profile -> name }}</td>
                            <td>{{ $line-> edited_by }}</td>
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

    <script>

        $('.func-delete').click(function() {
            swal({
                title: 'Are you sure?',
                text: "You won't be able to revert this!",
                type: 'warning',
                showCancelButton: true,
                confirmButtonClass: 'btn btn-success',
                cancelButtonClass: 'btn btn-danger m-l-10',
                confirmButtonText: 'Yes, delete it!'
            }).then((result) => {
                if (result) {
                    deleteRow($(this).data('id'),$(this).data('url'))
                }
            })
        });

        function deleteRow(id , url) {
            console.log(id,url);
            $.ajax({
                url: url,
                method: "post",
                headers: {'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')},
                data: { "id": id ,
                        "_token": "{{ csrf_token() }}",
                },
                success: function(e) {
                    $('#r-' + id).remove();
                    swal(
                        'Deleted!',
                        'User has been deleted.',
                        'Success'
                    )
                }
            });
        }
    </script>


@endsection 
