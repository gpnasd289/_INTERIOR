<!DOCTYPE html>
<html lang="en">
  <head>
     @include('client.layouts.main_head') 
     @yield('header')
  </head>

<body>
    @yield('main_content')
<!--wrapper start-->
<div class="wrapper">

  <!--== Start Preloader Content ==-->
  <div class="preloader-wrap">
    <div class="preloader">
      <span class="dot"></span>
      <div class="dots">
        <span></span>
        <span></span>
        <span></span>
      </div>
    </div>
  </div>
  <!--== End Preloader Content ==-->

  
  <!--== Start Header Wrapper ==-->
  @include('client.layouts.header_nav_bar')
  
  <main class="main-content">
    @yield('main-content')
  
  </main>
  
  <!--== Start Footer Area Wrapper ==-->
  <footer class="footer-area bg-color-222">
    <div class="footer-top-area">
      <div class="container">
        <div class="footer-widget-wrap row">
          <div class="col">
            <!--== Start widget Item ==-->
            <div class="widget-item">
              <div class="footer-logo-area">
                <a href="{{ route('home') }}">
                  <img class="logo-main" src="{{ asset('assets/img/logo-light.png') }}" alt="Logo" />
                </a>
              </div>
              <p>Ta vun đắp lên tổ ấm và tổ ấm sẽ định hình chúng ta</p>
              <p>Số 3 Cầu Giấy, quận cầu giấy, thành phố Hà Nội</p>
              <p>+84 033 919 9191  / +84 033 199 1119</p>
              <p>diana@gmail.com</p>
            </div>
            <!--== End widget Item ==-->
          </div>

          <div class="col">
            <!--== Start widget Item ==-->
            <div class="widget-item">
              <h4 class="widget-title">Liên kết nhanh</h4>
              <div class="widget-menu-wrap">
                <ul class="nav-menu">
                  <li><a href="page-search.html">Tìm kiếm</a></li>
                  <li><a href="about.html">Về chúng tôi</a></li>
                  <li><a href="contact.html">Liên hệ</a></li>
                  <li><a href="shipping-policy.html">Chính sách giao hàng</a></li>
                  <li><a href="wishlist.html">Danh sách yêu thích</a></li>
                  <li><a href="{{ route('client.shop.view') }}">Tất cả sản phẩm</a></li>
                </ul>
              </div>
            </div>
            <!--== End widget Item ==-->
          </div>

          <div class="col">
            <!--== Start widget Item ==-->
            <div class="widget-item">
              <h4 class="widget-title">Thông tin</h4>
              <div class="widget-menu-wrap">
                <ul class="nav-menu">
                  <li><a href="{{ route('client.customer.login') }}">Đăng nhập</a></li>
                  <li><a href="#/">Tài khoản của tôi</a></li>
                  <li><a href="#/">Điều khoản và dịch vụ</a></li>
                  <li><a href="shop-shipping-policy.html">Chính sách giao hàng</a></li>
                  <li><a href="shop-checkout.html">Hệ thống thanh toán</a></li>
                  <li><a href="#/">Mã giảm giá</a></li>
                </ul>
              </div>
            </div>
            <!--== End widget Item ==-->
          </div>

          <div class="col">
            <!--== Start widget Item ==-->
            <div class="widget-item">
              <h4 class="widget-title">Theo dõi chúng tôi</h4>
              <div class="widget-menu-wrap">
                <ul class="nav-menu">
                  <li><a href="#/">Facebook</a></li>
                  <li><a href="#/">Twitter</a></li>
                  <li><a href="#/">Instagram</a></li>
                  <li><a href="#/">LinkedIn</a></li>
                  <li><a href="#/">Google Plus</a></li>
                  <li><a href="#/">YouTube</a></li>
                </ul>
              </div>
            </div>
            <!--== End widget Item ==-->
          </div>
        </div>
      </div>
    </div>
    <!--== Start Footer Bottom ==-->
    <div class="footer-bottom">
      <div class="container">
        <div class="row">
          <div class="col-lg-8">
            <p class="copyright">Bản quyền © <a target="_blank" href="https:/hasthemes.com/">Diana <span style="color:red"> ❤ </span>made by passion </a> All Right Reserved.</p>
          </div>
          <div class="col-lg-4">
            <div class="payment-method">
              <img src="{{ asset('assets/img/icons/payment.webp') }}" alt="Image-HasTech">
            </div>
          </div>
        </div>
      </div>
    </div>
    <!--== End Footer Bottom ==-->
  </footer>
  <!--== End Footer Area Wrapper ==-->

  <!--== Scroll Top Button ==-->
  <div id="scroll-to-top" class="scroll-to-top"><span class="fa fa-angle-up"></span></div>

  <!--== Start Quick View Menu ==-->
  <aside class="product-quick-view-modal">
    <div class="product-quick-view-inner">
      <!-- inlcude quick content -->
    </div>
    <div class="canvas-overlay"></div>
  </aside>
  <!--== End Quick View Menu ==-->

  <!--== Start Side Menu ==-->
  <aside class="off-canvas-wrapper">
    <div class="off-canvas-inner">
      <div class="off-canvas-overlay"></div>
      <!-- Start Off Canvas Content Wrapper -->
      <div class="off-canvas-content">
        <!-- Off Canvas Header -->
        <div class="off-canvas-header">
          <div class="close-action">
            <button class="btn-menu-close">menu <i class="fa fa-chevron-left"></i></button>
          </div>
        </div>

        <div class="off-canvas-item">
          <!-- Start Mobile Menu Wrapper -->
          <div class="res-mobile-menu menu-active-one">
            <!-- Note Content Auto Generate By Jquery From Main Menu -->
          </div>
          <!-- End Mobile Menu Wrapper -->
        </div>
      </div>
      <!-- End Off Canvas Content Wrapper -->
    </div>
  </aside>
  
<!-- Messenger Plugin chat Code -->
<!-- <div id="fb-root"></div>
  <div class="hotline-phone-ring-wrap">
    <div class="hotline-phone-ring">
      <div class="hotline-phone-ring-circle"></div>
      <div class="hotline-phone-ring-circle-fill"></div>
      <div class="hotline-phone-ring-img-circle">
      <a href="tel:0987654321" class="pps-btn-img">
        <img src="https:/nguyenhung.net/wp-content/uploads/2019/05/icon-call-nh.png" alt="Gọi điện thoại" width="50">
      </a>
      </div>
    </div>
    <div class="hotline-bar">
      <a href="tel:0987654321">
        <span class="text-hotline">0987.654.321</span>
      </a>
    </div>
  </div> -->
  <!--== End Side Menu ==-->
</div>
<!--=======================Javascript============================-->
<!--=== jQuery Modernizr Min Js ===-->

<script src="{{ asset('assets/js/modernizr.js') }} "></script>

<script src="{{ asset('assets/js/jquery-main.js') }} "></script>
<!--=== jQuery Migration Min Js ===-->
<script src="{{ asset('assets/js/jquery-migrate.js') }} "></script>
<!--=== jQuery Popper Min Js ===-->
<script src="{{ asset('assets/js/popper.min.js') }}"></script>
<!--=== jQuery Bootstrap Min Js ===-->
<script src="{{ asset('assets/js/bootstrap.min.js') }}"></script>
<!--=== jQuery Appear Js ===-->
<script src="{{ asset('assets/js/jquery.appear.js') }}"></script>
<!--=== jQuery Headroom Min Js ===-->
<script src="{{ asset('assets/js/headroom.min.js') }}"></script>
<!--=== jQuery Swiper Min Js ===-->
<script src="{{ asset('assets/js/swiper.min.js') }}"></script>
<!--=== jQuery Fancybox Min Js ===-->
<script src="{{ asset('assets/js/fancybox.min.js') }}"></script>
<!--=== jQuery Slick Nav Js ===-->
<script src="{{ asset('assets/js/slicknav.js') }}"></script>
<!--=== jQuery Waypoint Js ===-->
<script src="{{ asset('assets/js/waypoint.js') }}"></script>
<!--=== jQuery Parallax Min Js ===-->
<script src="{{ asset('assets/js/parallax.min.js') }}"></script>
<!--=== jQuery Aos Min Js ===-->
<script src="{{ asset('assets/js/aos.min.js') }}"></script>
<!--=== jQuery Countdown Js ===-->
<script src="{{ asset('assets/js/countdown.js') }}"></script>
<script src="{{ asset('admin/assets/plugins/sweet-alert2/sweetalert2.min.js') }}"></script>
<script src="{{ asset('admin/assets/pages/sweet-alert.init.js') }}"></script>
<!--=== jQuery Custom Js ===-->
<script src="{{ asset('assets/js/custom.js') }}">
</script><script src="{{ asset('assets/js/cart.js') }}"></script>
</script><script src="{{ asset('assets/js/myjs.js') }}"></script>

@yield('script')
</body>

</html>

