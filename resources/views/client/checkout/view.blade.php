<!DOCTYPE html>
<html lang="en">

<head>
  @include('client.layouts.main_head')
  @yield('header')
</head>

<body>

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


    <main class="main-content">
      <div class="page-header-area">
        <div class="container">
          <div class="row">
            <div class="col-12 text-center">
              <div class="page-header-content">
                <h4 class="title" data-aos="fade-down" data-aos-duration="1200">Thanh toán</h4>
                <nav class="breadcrumb-area" data-aos="fade-down" data-aos-duration="1000">
                  <ul class="breadcrumb">
                    <li><a href="{{ route('home') }}">Trang chủ</a></li>
                    <li class="breadcrumb-sep">-</li>
                    <li><a href="javascript:void(0);">Thanh toán</a></li>
                  </ul>
                </nav>
              </div>
            </div>
          </div>
        </div>
      </div>
      <section class="product-area product-information-area">
        <div class="container">
          <div class="product-information">
            <div class="row">
              <div class="col-lg-7">
                <div class="edit-checkout-head">
                  <div class="header-logo-area">
                    <a href="{{route('home')}}">
                      <img class="logo-main" src="assets/img/logo.png" alt="Logo">
                    </a>
                  </div>
                  <div class="breadcrumb-area">
                    <ul>
                      <li><a class="active" href="{{route('client.cart.index') }}">Cart</a><i
                          class="fa fa-angle-right"></i></li>
                      <li class="active">Thông tin<i class="fa fa-angle-right"></i></li>

                      <li>Thanh toán</li>
                    </ul>
                  </div>
                </div>
                <div class="edit-checkout-information">
                  <h4 class="title">Thông tin liên hệ</h4>
                  <div class="logged-in-information">
                    <div class="thumb" data-bg-img="{{ asset('asset/image/avatar_blank.png') }}"></div>
                    <p>
                      <span class="name">{{ Auth::guard('client')->user() -> profile -> name }}</span>
                      <span>({{ Auth::guard('client')->user() -> profile -> email}})</span>
                      <a href="{{ route('client.customer.logout') }}">Đăng xuất</a>
                    </p>
                  </div>
                  <div class="form-check form-check-inline">
                    <input class="form-check-input" type="checkbox" id="inlineCheckbox1" value="option1">
                    <label class="form-check-label" for="inlineCheckbox1">Gửi tôi những thông báo mới nhất của cửa
                      hàng</label>
                  </div>
                  <div class="edit-checkout-form">
                    <form id="form-payment" data-url="{{ route('client.bill.checkout') }}">
                      @csrf

                      <h4 class="title">Địa chỉ nhận hàng</h4>
                      <div class="row row-gutter-12">
                        <div class="col-lg-6">
                          <div class="form-floating">
                            <label for="floatingInputGrid">Tên (Tùy chọn)</label>
                            <input type="text" class="form-control" id="first_name" placeholder="Nguyễn"
                              value="{{ old('firstname', Auth::guard('client')->user() -> profile -> getName() ) }}"
                              name="first_name" required>

                          </div>
                        </div>
                        <div class="col-lg-6">
                          <div class="form-floating">
                            <label for="floatingInput2Grid">Họ</label>
                            <input type="text" class="form-control" id="last_name" placeholder="Tiên"
                              value="{{ old('lastname', Auth::guard('client')->user() -> profile -> name ) }}"
                              name="last_name" required>

                          </div>
                        </div>
                        <div class="col-lg-12">
                          <div class="form-floating">
                            <label for="floatingInput5Grid">Số điện thoại</label>
                            <input type="tel" class="form-control" id="phone_number" placeholder="0123.456.789"
                              value="{{ old('phone_number', Auth::guard('client')->user() -> profile -> phone_number ) }}"
                              name="phone_number" required>

                          </div>
                        </div>
                        <div class="col-lg-12">
                          <div class="form-floating">
                            <label for="floatingInput3Grid">Địa chỉ</label>
                            <input type="text" class="form-control" id="address" placeholder="Địa chỉ giao hàng"
                              value="{{ old('address', Auth::guard('client')->user() -> profile -> address ) }}"
                              name="address" required>
                          </div>
                        </div>

                        <div class="col-lg-12">
                          <div class="form-floating">
                            <label for="floatingInput4Grid">Căn hộ, số nhà, tên đường 1 (Tùy chọn)</label>
                            <input type="text" class="form-control" id="address_detail_1"
                              placeholder="Nguyễn Đình Chiểu, quận Phú Nhuận, TP.Hồ Chí Minh"
                              value="{{ old('address', Auth::guard('client')->user() -> profile -> address ) }}"
                              name="address_detail_1" required>

                          </div>
                        </div>
                        <div class="col-lg-12">
                          <div class="form-floating">
                            <label for="floatingInput5Grid">Căn hộ, số nhà, tên đường 2 (Tùy chọn)</label>
                            <input type="text" class="form-control" id="address_detail_2"
                              placeholder="89 Nguyễn Đình Chiểu, quận Phú Nhuận, TP.Hồ Chí Minh"
                              value="{{ old('address', Auth::guard('client')->user() -> profile -> address ) }}"
                              name="address_detail_2">

                          </div>
                        </div>

                        <div class="col-lg-12 mt-4">
                          <h2 class="title">Chọn phương thức thanh toán</h2>
                          <input type="radio" id="payment-method-cod" name="payment_method" value="1" checked>
                          <label for="payment-method-cod" class="text-lg">Thanh toán khi nhận hàng</label><br>
                          <input type="radio" id="payment-method-paypal" name="payment_method" value="2" disabled>
                          <label for="payment-method-paypal">Thanh toán qua Paypal</label><br>
                        </div>

                        <input type="hidden" value="" name="coupon" id="coupon">
                        <div class="col-12">
                          <div class="btn-box">
                            <!-- <button type="submit"> haha</button> -->
                            <button class="btn-shipping" href="javascript:void(0);" type="submit" >Tiếp tục thanh toán</button>
                            <a class="btn-return" href="{{ route('client.cart.index') }}">Trở lại giỏ hàng</a>
                          </div>
                        </div>
                      </div>
                    </form>
                  </div>
                </div>
              </div>
              <div class="col-lg-5">
                <div class="shipping-cart-subtotal-wrapper">
                  <div class="shipping-cart-subtotal">
                    @foreach(Cart::instance('shopping') -> content() as $item)
                    @include('client.components.checkout_items.checkout_item',['product' => $item -> model,
                    'quantity' => $item -> qty])
                    @endforeach

                    <div class="shipping-subtotal">
                      <p><span>Tạm tính</span><span><strong id="checkout-total">{{ Cart::instance('shopping') ->
                            subtotal() }} VND</strong></span></p>
                      <p><span>Phí ship</span><span>Free</span></p>
                    </div>
                    <div class="cart-discount">
                      <p>Áp dụng mã giảm giá</p>
                      <div class="row">
                        <div class="col-md-8"> <input type="text" class="form-control" value="" name="voucher"
                            placeholder="MAGIAMGIA" id="discount-voucher"></div>
                        <div class="col-md-4"> <button type="button" class="btn-custom" id="btn_apply_coupon"
                            data-url="{{ route('client.promotion.apply') }}">Áp dụng</button></div>
                      </div>
                    </div>
                    <div class="shipping-total">
                      <p class="total">Tổng tiền</p>
                      <p class="price" id="checkout-total-final">{{ Cart::instance('shopping')->subtotal() }} <span
                          class="usd">VND</span></p>
                    </div>

                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>

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
                <p>+84 033 919 9191 / +84 033 199 1119</p>
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
              <p class="copyright">Bản quyền © <a target="_blank" href="https://hasthemes.com/">Diana <span
                    style="color:red"> ❤ </span>made by passion </a> All Right Reserved.</p>
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
    <!--== End Side Menu ==-->
  </div>
  <!--=======================Javascript============================-->
  <!--=== jQuery Modernizr Min Js ===-->
  <script src="{{ asset('assets/js/modernizr.js') }}"></script>
  <!--=== jQuery Min Js ===-->
  <script src="{{ asset('assets/js/jquery-main.js') }} "></script>
  <!--=== jQuery Migration Min Js ===-->
  <script src="{{ asset('assets/js/jquery-migrate.js') }}"></script>
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
  <script src="{{ asset('admin/assets/plugins/sweet-alert2/sweetalert2.min.js')}}"></script>
  <script src="{{ asset('admin/assets/pages/sweet-alert.init.js') }}"></script>
  <!--=== jQuery Custom Js ===-->
  <script src="{{ asset('assets/js/custom.js') }}">
  </script>
  <script src="{{ asset('assets/js/cart.js') }}"></script>
  </script>
  <script src="{{ asset('assets/js/myjs.js') }}"></script>
  <script src="/assets/js/checkout.js"></script>
  @yield('script')
</body>

</html>