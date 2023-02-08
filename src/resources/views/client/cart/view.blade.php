@extends('client.layouts.main')
@section('header')
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,400i,600,700,800" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Oswald:300,400,400i,600,700" rel="stylesheet">
@endsection

@section('main-content')
    <!--== Start Page Header Area Wrapper ==-->
    <div class="page-header-area page-shopping-cart-area">
      <div class="container">
        <div class="row">
          <div class="col-12 text-center">
            <div class="page-header-content">
              <h4 class="title" data-aos="fade-down" data-aos-duration="1200">Giỏ hàng</h4>
              <nav class="breadcrumb-area" data-aos="fade-down" data-aos-duration="1000">
                <ul class="breadcrumb">
                    <li><a href="{{ route('home') }}">Trang chủ</a></li>
                    <li class="breadcrumb-sep">-</li>
                    <li><a href="javascript:void(0);">Giỏ hàng</a></li>
                </ul>
                </nav>
            </div>
          </div>
        </div>
      </div>
    </div>
    <!--== End Page Header Area Wrapper ==-->

        <!--== Start Product Area Wrapper ==-->
      <section class="product-area shopping-cart-area">
      <div class="container">
        <div class="row">
          <div class="col-12">
            @if(count(Cart::instance('shopping')->content()) > 0)
              <div class="shopping-cart-wrap">
                <div class="cart-table table-responsive">
                  <table class="table">
                    <thead>
                      <tr>
                        <th class="pro-thumbnail">Ảnh sản phẩm</th>
                        <th class="pro-title">Tên sản phẩm</th>
                        <th class="pro-price">Giá</th>
                        <th class="pro-quantity">Số lượng</th>
                        <th class="pro-subtotal">Thành tiền</th>
                        <th class="pro-remove">Xóa bỏ</th>
                      </tr>
                    </thead>
                    <tbody>
                      @foreach(Cart::instance('shopping')->content() as $item)
                        <x-cart_item_row :item="$item"></x-cart_item_row>
                      @endforeach
                    
                    </tbody>
                  </table>
                </div>
                <div class="row">
                  <div class="col-12">
                    <div class="cart-buttons">
                      <a class="theme-default-button" href="javascript:void(0);" id="update-cart" data-url="{{ route('client.cart.update') }}">Cập nhật giỏ hàng</a>
                      <a class="theme-default-button" href="{{ route('client.shop.view') }}">Tiếp tục mua sắm</a>
                      <a class="theme-default-button" id="clear-cart" href="javascript:void(0);" data-url="{{ route('client.cart.clear') }}">Làm trống giỏ hàng</a>
                    </div>
                  </div>
                </div>
                <div class="row">
                  <div class="col-12">
                    <div class="cart-payment">
                      <div class="row">
                      <div class="col-lg-6">
                      </div>
                        <div class="col-lg-6">
                          <div class="cart-total">
                            <h4 class="title">Thông tin giỏ hàng</h4>
                            <table>
                              <tbody>
                                <tr class="cart-subtotal">
                                  <th>Tạm tính</th>
                                  <td><span class="amount"><span>{{ Cart::instance('shopping')->subtotal() }} VND</span></span></td>
                                </tr>
                                <tr class="order-total">
                                  <th>Tổng tiền</th>
                                  <td>
                                    <span class="amount"><span>{{ Cart::instance('shopping')->subtotal() }} VND</span></span>
                                  </td>
                                </tr>                     
                              </tbody>
                            </table>
                            <div class="proceed-to-checkout">
                              <a class="shop-checkout-button" href="{{ route('client.checkout.view') }}">Thanh toán</a>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            @else 
              <div class="blank-shopping-cart"></div>
            @endif
          </div>
        </div>
      </div>
    </section>
@endsection

@section('script')
  <script src="{{ asset('assets/js/cart.js') }}"> </script>
@endsection