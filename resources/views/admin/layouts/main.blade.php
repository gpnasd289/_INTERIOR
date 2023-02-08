<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimal-ui">
        <title>Admin Dashboard</title>
        <meta content="Admin Dashboard" name="description" />
        <meta name="csrf-token" content="{{ csrf_token() }}">
        <link rel="shortcut icon" href="{{ asset('admin/assets/images/favicon.ico')}}">
        @yield('head')
        <!-- <link rel="stylesheet" href="{{ asset('admin/assets/plugins/morris/morris.css')}}"> -->
        <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/morris.js/0.5.1/morris.css">
        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.0/jquery.min.js"></script>
        <script src="//cdnjs.cloudflare.com/ajax/libs/raphael/2.1.0/raphael-min.js"></script>
        <script src="//cdnjs.cloudflare.com/ajax/libs/morris.js/0.5.1/morris.min.js"></script>
  
        <!-- Sweet Alert -->
        <link href="{{ asset('admin/assets/css/mycss.css') }}" rel="stylesheet" type="text/css">
        <link href="{{ asset('admin/assets/plugins/sweet-alert2/sweetalert2.min.css') }}" rel="stylesheet" type="text/css">
        <link href="{{ asset('admin/assets/css/bootstrap.min.css') }}" rel="stylesheet" type="text/css">
        <link href="{{ asset('admin/assets/css/metismenu.min.css') }}" rel="stylesheet" type="text/css">
        <link href="{{ asset('admin/assets/css/icons.css') }}" rel="stylesheet" type="text/css">
        <link href="{{ asset('admin/assets/css/style.css') }}" rel="stylesheet" type="text/css">
        <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/morris.js/0.5.1/morris.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-select@1.13.14/dist/css/bootstrap-select.min.css">
    </head> 

    <body>
        <div id="wrapper">
            @include('admin.layouts.topbar')
            @include('admin.layouts.left_side_bar')
            <div class="content-page">
                <!-- Start content -->
                <div class="content">
                    <div class="container-fluid flex-container">
                        @yield('main-content')
                    </div> <!-- container-fluid -->

                </div> <!-- content -->

                <footer class="footer">
                    © 2022 Agroxa <span class="d-none d-sm-inline-block">- Crafted with <i class="mdi mdi-heart text-danger"></i> by 19.mimm.</span>
                </footer>

            </div>
        </div>
        <!-- jQuery  -->
        <script src="{{ asset('admin/assets/js/jquery.min.js') }} "></script>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap-select@1.13.14/dist/js/bootstrap-select.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap-select@1.13.14/dist/js/i18n/defaults-*.min.js"></script>
        <script src="{{ asset('admin/assets/js/bootstrap.bundle.min.js') }} "></script>
        <script src="{{ asset('admin/assets/js/metisMenu.min.js') }}"></script>
        <script src="{{ asset('admin/assets/js/jquery.slimscroll.js') }}"></script>
        <script src="{{ asset('admin/assets/js/waves.min.js') }}"></script>
        <script src="{{ asset('admin/assets/js/myjs.js') }}"></script>
        <script src="{{ asset('admin/assets/plugins/jquery-sparkline/jquery.sparkline.min.js') }}"></script><!-- Sweet-Alert  -->
        <script src="{{ asset('admin/assets/plugins/sweet-alert2/sweetalert2.min.js')}}"></script>
        <script src="{{ asset('admin/assets/pages/sweet-alert.init.js') }}"></script>
        <!-- Peity JS -->
        <script src="{{ asset('admin/assets/plugins/peity/jquery.peity.min.js') }} "></script>

        <!-- <script src="{{ asset('admin/assets/plugins/morris/morris.min.js') }} "></script> -->
        <script src="{{ asset('admin/assets/plugins/raphael/raphael-min.js') }} "></script>

        <!-- <script src="{{ asset('admin/assets/pages/dashboard.js') }} "></script>  -->
        <!-- App js -->
        <script src="{{ asset('admin/assets/js/app.js') }} "></script>

        @yield('script')
    </body>

</html>