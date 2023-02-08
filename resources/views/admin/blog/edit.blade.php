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
                <h4 class="page-title">Create Blog</h4>
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="javascript:void(0);">Dashboard</a></li>
                    <li class="breadcrumb-item"><a href="javascript:void(0);">List Blog</a></li>
                    <li class="breadcrumb-item active"><a href="javascript:void(0);">Create</a></li>
                </ol>
            </div>
        </div>
    </div>

    <x-cardbody title="Chỉnh sửa Blog">
        <form class="form" action="{{ route('admin.blog.update') }}" method="POST" enctype="multipart/form-data">
            @csrf
            <input type="hidden" name="author" value="{{ Auth::id() }}">

            @if(session('error'))
                <div class="error"> {{ session('error') }} </div>
            @endif
            <x-inputtext title="Tiêu đề" name="title" value="{{ old('title', $blog -> title )}}" placeholder="Nhập tiêu đề bài viết" id="title"></x-inputtext>
            @if($errors->has('title'))
                <div class="error"> {{ $errors->first('title') }} </div>
            @endif
            <x-inputtext title="Mô tả bài viết" name="description" value="{{ old('description', $blog -> description )}}" placeholder="Nhập mô tả bài viết" id="description"></x-inputtext>
            @if($errors->has('description'))
                <div class="error"> {{ $errors->first('description') }} </div>
            @endif

            <div class="form-group">
                <label for="content" class="control-label" required>Nội dung bài viết</label>
                <textarea id="my-editor" name="content" class="form-control" >{!! old('content', $blog -> content) !!}</textarea>
            <div>
            @if($errors->has('content'))
                <div class="error"> {{ $errors->first('content') }} </div>
            @endif

            <div class="form-group" style="margin-top:20px">
                <x-imagebutton title="Ảnh bìa" id="1" :preview="null" :product="null"></x-imagebutton>
            </div>

            @if($errors->has('file_1'))
                <div class="error"> {{ $errors->first('file_1') }} </div>
            @endif
            <button class="btn btn-danger" type="submit">Tạo mới</button>
        </form>
        
    </x-cardbody>
@endsection

@section('script')
    <script src="https://cdn.ckeditor.com/4.17.1/full-all/ckeditor.js"></script>

    <script>
        var options = {
            filebrowserImageBrowseUrl: '/admin/laravel-filemanager?type=Images',
            filebrowserImageUploadUrl: '/admin/laravel-filemanager/upload?type=Images&_token={{ csrf_token() }}',
            filebrowserBrowseUrl: '/admin/laravel-filemanager?type=Files',
            filebrowserUploadUrl: '/admin/laravel-filemanager/upload?type=Files&_token={{ csrf_token() }}',
            extraPlugins: 'image2,uploadimage',
            uploadUrl: '/admin/laravel-filemanager/upload?type=Files&_token={{ csrf_token() }}',
            removeDialogTabs: 'image:advanced;link:advanced',
            removeButtons: 'PasteFromWord'
        };
    </script>
    <script>
        CKEDITOR.addCss('figure[class*=easyimage-gradient]::before { content: ""; position: absolute; top: 0; bottom: 0; left: 0; right: 0; }' +
    'figure[class*=easyimage-gradient] figcaption { position: relative; z-index: 2; }' +
    '.easyimage-gradient-1::before { background-image: linear-gradient( 135deg, rgba( 115, 110, 254, 0 ) 0%, rgba( 66, 174, 234, .72 ) 100% ); }' +
    '.easyimage-gradient-2::before { background-image: linear-gradient( 135deg, rgba( 115, 110, 254, 0 ) 0%, rgba( 228, 66, 234, .72 ) 100% ); }');
        CKEDITOR.replace('my-editor', options);
    </script>
    <script src="{{ asset('admin/assets/plugins/jquery-sparkline/jquery.sparkline.min.js') }}"></script>
    <script src="{{ asset('admin/assets/plugins/bootstrap-md-datetimepicker/js/moment-with-locales.min.js') }}"></script>
    <script src="{{ asset('admin/assets/plugins/bootstrap-md-datetimepicker/js/bootstrap-material-datetimepicker.js') }}"></script>
    <script src="/vendor/laravel-filemanager/js/stand-alone-button.js"></script>
    <!-- Plugins js -->
    <script src="{{ asset('admin/assets/plugins/bootstrap-colorpicker/js/bootstrap-colorpicker.min.js') }}"></script>

    <script src="{{ asset('admin/assets/plugins/select2/js/select2.min.js') }}"></script>
    <script src="{{ asset('admin/assets/plugins/bootstrap-maxlength/bootstrap-maxlength.min.js') }}"></script>
    <script src="{{ asset('admin/assets/plugins/bootstrap-filestyle/js/bootstrap-filestyle.min.js') }}"></script>
    <script src="{{ asset('admin/assets/plugins/bootstrap-touchspin/js/jquery.bootstrap-touchspin.min.js') }}"></script>
    <script>
         var route_prefix = "/admin/laravel-filemanager?type=Files";
           
        $('#file_1').filemanager('image', {prefix: route_prefix}); 
    </script>
    <!-- Plugins Init js -->
    <script src="{{ asset('admin/assets/pages/form-advanced.js') }}"></script>
@endsection