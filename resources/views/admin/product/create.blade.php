@extends('admin.layouts.main')
@section('head')
    <!-- Dropzone css -->

    <link href="{{ asset('admin/assets/plugins/bootstrap-colorpicker/css/bootstrap-colorpicker.min.css') }}" rel="stylesheet">
    <link href="{{ asset('admin/assets/plugins/bootstrap-md-datetimepicker/css/bootstrap-material-datetimepicker.css') }}" rel="stylesheet">
    <link href="{{ asset('admin/assets/plugins/select2/css/select2.min.css')}}" rel="stylesheet" type="text/css">
    <link href="{{ asset('admin/assets/plugins/bootstrap-touchspin/css/jquery.bootstrap-touchspin.min.css')}}" rel="stylesheet">
    <link href="{{ asset('admin/assets/plugins/dropzone/dist/dropzone.css') }}" rel="stylesheet" type="text/css">
@endsection
@section('main-content')
    <div class="row">
        <div class="col-sm-12">
            <div class="page-title-box">
                <h4 class="page-title">Quản lý sản phẩm</h4>
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="javascript:void(0);">Dashboard</a></li>
                    <li class="breadcrumb-item"><a href="javascript:void(0);">Danh sách sản phẩm</a></li>
                    <li class="breadcrumb-item active"><a href="javascript:void(0);">Tạo mới</a></li>
                </ol>
            </div>
        </div>
    </div>

    <x-cardbody title="Tạo mới sản phẩm">
    @if ($errors->any())
        <div class="alert alert-danger">
            <ul>
                @foreach ($errors->all() as $error)
                    <li>{{ $error }}</li>
                @endforeach
            </ul>
        </div>
    @endif
        <form class="form" action="{{ route('admin.product.store') }}" method="POST" enctype="multipart/form-data">
            @csrf
            <x-inputtext title="Tên sản phẩm" name="name" value="{{ old('name', '')}}" placeholder="Enter Product name ..." id="name"></x-inputtext>
            @if($errors->has('name'))
                <div class="error"> {{ $errors->first('name') }} </div>
            @endif
            <x-inputoption :options="$product_parent" name="product_parent" title="Sản phẩm cha" :selected="-1"></x-inputoption>
            <x-inputareaedit title="Mô tả" rows="6" name="description" value="{{ old('description', '')}}" placeholder="Enter description  ..." id="description"></x-inputareaedit>
            @if($errors->has('description'))
                <div class="error"> {{ $errors->first('description') }} </div>
            @endif
            <div class="row" >
                <div class="col-sm">
                    <x-inputtext title="Giá nhập" name="price_entry" value="{{ old('price_entry', '0')}}" placeholder="Enter Price Entry  ..." id="price_entry" type="number" ></x-inputareaedit>
                    @if($errors->has('price_entry'))
                        <div class="error"> {{ $errors->first('price_entry') }} </div>
                    @endif
                </div>
                <div class="col-sm">
                    <x-inputtext title="Giá bán" name="price_sell" value="{{ old('price_sell', '0')}}" placeholder="Enter Price Sell  ..." id="price_sell" type="number" ></x-inputareaedit>
                    @if($errors->has('price_sell'))
                        <div class="error"> {{ $errors->first('price_sell') }} </div>
                    @endif
                </div>

                <div class="col-sm">
                    <x-inputtext title="Giá khuyến mãi" name="price_sale" value="{{ old('price_sale', '0')}}" placeholder="Enter Price Sale  ..." id="price_sell" type="number" ></x-inputareaedit>
                    @if($errors->has('price_sale'))
                        <div class="error"> {{ $errors->first('price_sell') }} </div>
                    @endif
                </div>
                
                <div class="col-sm">
                    <x-inputtext title="Số lượng" name="quantity" value="{{ old('quantity', '0')}}" placeholder="Enter Quantity ..." id="quantity" type="number" ></x-inputareaedit>
                    @if($errors->has('quantity'))
                        <div class="error"> {{ $errors->first('quantity') }} </div>
                    @endif
                </div>
            </div>
            <div class="form-group" class="margin-top:20px">
                <label for="position" class="control-label" required>Trạng thái hiển thị sản phẩm</label>
                <div class="form-group">
                    <label>
                        <input type="radio" name="display_state" id="" value="2"> Sản phẩm mới
                    </label>
                    <br>
                    <label>
                        <input type="radio" name="display_state" id="" value="3"> Sản phẩm bán chạy
                    </label>
                    <br>
                    <label>
                        <input type="radio" name="display_state" id="" value="4"> Sản phẩm đã hết hàng
                    </label>
                    <br>

                    <label>
                        <input type="radio" name="display_state" id="" value="5"> Sản phẩm sắp ra mắt
                    </label>
                </div>
                @if($errors->has('display_state'))
                <div class="error"> {{ $errors->first('display_state') }} </div>
                @endif
            </div>

            <div class="form-group">
                    <x-inputoption :options="$option" name="product_category" title="Category" :selected="-1"></x-inputoption>
                @if($errors->has('category'))
                    <div class="error"> {{ $errors->first('category') }} </div>
                @endif
            </div>

            <div class="form-group">
                    <x-inputoption :options="$material" name="material" title="Chất Liệu" :selected="-1"></x-inputoption>
                @if($errors->has('material'))
                    <div class="error"> {{ $errors->first('material') }} </div>
                @endif
            </div>

            <x-inputcolor label="Choose Color" name="color"></x-inputcolor>
            @if($errors->has('color'))
                <div class="error"> {{ $errors->first('color') }} </div>
            @endif

            <div class="form-group">
                <label for="review_content" class="control-label" required>Review Product</label>
                <textarea id="my-editor" name="review_content" class="form-control" >{!! old('review_content', '') !!}</textarea>
            <div>

            <div class="row" style="margin-top: 20px; max-height: 400px;">
                @foreach($specification_image as $image) 
                    @if($image -> name == 'image_1')
                    <div class="col-sm">
                            <x-imagebutton title="{{ $image -> description }}" id="1" :preview="$preview" :product="$preview"></x-imagebutton>
                            @if($errors->has('file_1'))
                                <div class="error"> {{ $errors->first('file_1') }} </div>
                            @endif
                        </div>
                    @endif

                    @if($image -> name == 'image_2')
                        <div class="col-sm">
                            <x-imagebutton title="{{ $image -> description }}" id="2" :preview="$preview" :product="$preview"></x-imagebutton>
                            @if($errors->has('file_2'))
                                <div class="error"> {{ $errors->first('file_2') }} </div>
                            @endif
                        </div>
                    @endif           

                    @if($image -> name == 'image_3')
              
                        <div class="col-sm">
                            <x-imagebutton title="{{ $image -> description }}" id="3" :preview="$preview" :product="$preview"></x-imagebutton>
                            @if($errors->has('file_3'))
                                <div class="error"> {{ $errors->first('file_3') }} </div>
                            @endif
                        </div>
                    @endif
           
                @endforeach
            </div>
            <div class="row" style="margin-top: 25px;">
                @foreach($specification_image as $image) 
                    @if($image -> name == 'image_with_background')
                        <div class="col-sm">
                            <x-imagebutton title=" {{ $image -> description }}" id="4" :preview="$preview" :product="$preview"></x-imagebutton>
                            @if($errors->has('file_4'))
                                <div class="error"> {{ $errors->first('file_4') }} </div>
                            @endif
                        </div>
                    @endif
                
                    @if($image -> name == 'image_no_background')
                        <div class="col-sm">
                            <x-imagebutton title="{{ $image -> description }}" id="5" :preview="$preview" :product="$preview"></x-imagebutton>
                            @if($errors->has('file_5'))
                                <div class="error"> {{ $errors->first('file_5') }} </div>
                            @endif
                        </div>
                    @endif
                @endforeach
            </div>
            @include('admin.components.form-status')
            <button class="btn btn-danger" id="btn_create">Tạo mới</button>
        </form>
        </div>
    </x-cardbody>
@endsection

@section('script')
    <script src="https://cdn.ckeditor.com/4.17.1/full-all/ckeditor.js"></script>
    $( document ).ready(function() {
        $(#btn_create).click(function({
            var data = CKEDITOR.instances.editor1.getData();
            $('#review').val(data);
        }));
    });
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
        $('#file_2').filemanager('image', {prefix: route_prefix});
        $('#file_3').filemanager('image', {prefix: route_prefix});
        $('#file_4').filemanager('image', {prefix: route_prefix});
        $('#file_5').filemanager('image', {prefix: route_prefix});
    </script>
    <!-- Plugins Init js -->
    <script src="{{ asset('admin/assets/pages/form-advanced.js') }}"></script>
@endsection