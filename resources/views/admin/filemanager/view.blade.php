@extends('admin.layouts.main')
@section('head')
<script src="//cdn.ckeditor.com/4.6.2/standard/ckeditor.js"></script>
@endsection

@section('main-content')
    
     <iframe src="laravel-filemanager"  class="flex-item" style="width: 100%; overflow: hidden; border: none;"></iframe>
@endsection

@section('script')

<script>
    var options = {
        filebrowserImageBrowseUrl: '/laravel-filemanager?type=Images',
        filebrowserImageUploadUrl: '/laravel-filemanager/upload?type=Images&_token={{ csrf_token() }',
        filebrowserBrowseUrl: '/laravel-filemanager?type=Files',
        filebrowserUploadUrl: '/laravel-filemanager/upload?type=Files&_token={{ csrf_token() }'
    };
</script>
        

@endsection 
