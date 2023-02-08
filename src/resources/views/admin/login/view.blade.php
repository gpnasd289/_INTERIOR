<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimal-ui">
        <title>Login</title>
        <meta content="Admin Dashboard" name="description" />
        <meta content="Themesbrand" name="author" />
        <link rel="shortcut icon" href="{{ asset('admin/assets/images/favicon.ico') }}">

        <link href="{{ asset('admin/assets/css/bootstrap.min.css') }}" rel="stylesheet" type="text/css">
        <link href="{{ asset('admin/assets/css/metismenu.min.css') }}" rel="stylesheet" type="text/css">
        <link href="{{ asset('admin/assets/css/icons.css') }}" rel="stylesheet" type="text/css">
        <link href="{{ asset('admin/assets/css/style.css') }}" rel="stylesheet" type="text/css">
    </head>

    <body>

        <!-- Background -->
        <div class="account-pages"></div>
        <!-- Begin page -->
        <div class="wrapper-page">

            <div class="card">
                <div class="card-body">

                    <h3 class="text-center m-0">
                        <a href="{{ route('admin.dashboard')}}" class="logo logo-admin"><img src="{{ asset('admin/assets/images/logo.png')}}" height="30" alt="logo"></a>
                    </h3>

                    <div class="p-3">
                        <h4 class="text-muted font-18 m-b-5 text-center">Chào mừng quay trở lại !</h4>
                        <p class="text-muted text-center">Xin mời đăng nhập để tiếp tục vào Trang Quản trị.</p>

                        <form class="form-horizontal m-t-30" action="{{ route('admin.sys.login') }}" method="POST">
                            @csrf

                            @if(session('error')) 
                            <div class="error"> {{ session('error') }} </div>
                            @endif

                            <div class="form-group">
                                <label for="username">Tên Đăng Nhập</label>
                                <input type="text" class="form-control" id="username" placeholder="Enter username" name="username" value="{{ old('username','luan08') }}">
                            </div>

                            @if($errors->has('username'))
                                <div class="error"> {{ $errors->first('username') }} </div>
                            @endif
                
                            <div class="form-group">
                                <label for="userpassword">Mật khẩu</label>
                                <input type="password" class="form-control" id="userpassword" placeholder="Enter password" name="password" value="{{ old('password','12345678') }}">
                            </div>

                            @if($errors->has('password'))
                                <div class="error"> {{ $errors->first('password') }} </div>
                            @endif

                            <div class="form-group row m-t-20">
                                <div class="col-6">
                                    <div class="custom-control custom-checkbox">
                                        <input type="checkbox" class="custom-control-input" id="customControlInline" name="rememberme" >
                                        <label class="custom-control-label" for="customControlInline">Ghi nhớ tôi</label>
                                    </div>
                                </div>
                                <div class="col-6 text-right">
                                    <button class="btn btn-primary w-md waves-effect waves-light" type="submit">Đăng nhập</button>
                                </div>
                            </div>

                            <div class="form-group m-t-10 mb-0 row">
                                <div class="col-12 m-t-20">
                                    <a href="#" class="text-muted"><i class="mdi mdi-lock"></i> Quên mật khẩu?</a>
                                </div>
                            </div>
                        </form>
                    </div>

                </div>
            </div>

            <div class="m-t-40 text-center">
                <p class="text-muted">© 2022 Agroxa. Created with <i class="mdi mdi-heart text-primary"></i> by 19.Mimm </p>
            </div>

        </div>

        <!-- END wrapper -->
            

        <!-- jQuery  -->
        <script src="{{ asset('admin/assets/js/jquery.min.js') }}"></script>
        <script src="{{ asset('admin/assets/js/bootstrap.bundle.min.js') }}"></script>
        <script src="{{ asset('admin/assets/js/metisMenu.min.js') }}"></script>
        <script src="{{ asset('admin/assets/js/jquery.slimscroll.js') }}"></script>
        <script src="{{ asset('admin/assets/js/waves.min.js') }}"></script>

        <script src="{{ asset('admin/assets/plugins/jquery-sparkline/jquery.sparkline.min.js') }}"></script>

        <!-- App js -->
        <script src="{{ asset('admin/assets/js/app.js') }}"></script>

    </body>

</html>

<script>

</script>