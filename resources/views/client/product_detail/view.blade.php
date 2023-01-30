@extends('client.layouts.main')
@section('header')
    <!--== Google Fonts ==-->
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,400i,600,700,800" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Oswald:300,400,400i,600,700" rel="stylesheet">
@endsection

@section('main-content')
  @include('client.product_detail.page_header',['product' => $product])
  <div id="fb-root"></div>
<script async defer crossorigin="anonymous" src="https://connect.facebook.net/vi_VN/sdk.js#xfbml=1&version=v13.0" nonce="TUIf3qnR"></script>
  <!--== Start Product Area Wrapper ==-->
  <section class="product-area product-single-area">
      <div class="container">
        <div class="row flex-row-reverse">
          <div class="col-lg-9">
            <div class="product-single-item">
              <div class="row">
                <div class="col-lg-6">
                  <div class="product-single-slider">
                    <!--== Start Product Thumbnail Area ==-->
                    <div class="product-thumb">
                      <div class="swiper-container single-product-thumb-slider">
                        <div class="swiper-wrapper">
                          <div class="swiper-slide">
                            <div class="zoom zoom-hover">
                              <a class="lightbox-image" data-fancybox="gallery" href="{{ $product -> image_with_background_path() }}">
                                <img src="{{ $product -> image_with_background_path() }}" alt="{{ $product->name . 'with background'}}">
                              </a>
                            </div>
                          </div>
                          <div class="swiper-slide">
                            <div class="zoom zoom-hover">
                              <a class="lightbox-image" data-fancybox="gallery" href="{{  $product -> image_no_background_path() }}">
                                <img src="{{ $product -> image_no_background_path() }}" alt="{{ $product->name . 'no background'}}">
                              </a>
                            </div>
                          </div>
                          <div class="swiper-slide">
                            <div class="zoom zoom-hover">
                              <a class="lightbox-image" data-fancybox="gallery" href="{{  $product -> image_1_path() }}">
                                <img src="{{ $product -> image_1_path()  }}" alt="{{ $product->name . 'image 1'}}">
                              </a>
                            </div>
                          </div>
                          <div class="swiper-slide">
                            <div class="zoom zoom-hover">
                              <a class="lightbox-image" data-fancybox="gallery" href="{{ $product -> image_2_path()  }}">
                                <img src="{{ $product -> image_2_path()  }}" alt="{{ $product->name . 'image 2'}}">
                              </a>
                            </div>
                          </div>
                          <div class="swiper-slide">
                            <div class="zoom zoom-hover">
                              <a class="lightbox-image" data-fancybox="gallery" href="{{ $product -> image_3_path()  }}">
                                <img src="{{ $product -> image_3_path()  }}" alt="{{ $product->name . 'image 3'}}">
                              </a>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                    <!--== End Product Thumbnail Area ==-->

                    <!--== Start Product Nav Area ==-->
                    <div class="swiper-container single-product-nav-slider product-nav">
                      <div class="swiper-wrapper">
                        <div class="swiper-slide">
                          <img src="{{ $product -> image_with_background_path()  }}" alt="{{ $product->name . 'with background'}}">
                        </div>
                        <div class="swiper-slide">
                          <img src="{{ $product -> image_no_background_path()  }}" alt="{{ $product->name . 'no background'}}">
                        </div>
                        <div class="swiper-slide">
                          <img src="{{ $product -> image_1_path()  }}" alt="{{ $product->name . 'image 1'}}">
                        </div>
                        <div class="swiper-slide">
                          <img src="{{ $product -> image_2_path()  }}" alt="{{ $product->name . 'image 2'}}">
                        </div>
                        <div class="swiper-slide">
                          <img src="{{ $product -> image_3_path()  }}" alt="{{ $product->name . 'image 3'}}">
                        </div>
                      </div>

                      <!--== Add Swiper navigation Buttons ==-->
                      <div class="swiper-button-prev"><i class="fa fa-angle-left"></i></div>
                      <div class="swiper-button-next"><i class="fa fa-angle-right"></i></div>
                    </div>
                    <!--== End Product Nav Area ==-->
                  </div>
                </div>
                <div class="col-lg-6">
                  <!--== Start Product Info Area ==-->
                  <div class="product-single-info">
                    <h4 class="title">{{ $product -> name }}</h4>
                    <div class="prices">
                      <span class="price-old">{{ $product -> getPrice()  }} VND</span><br>
                      <span class="price">{{ $product -> getPriceSale()  }} VND</span>
                    
                    </div>
                    <div class="star-content">
                      <i class="fa fa-star-o"></i>
                      <i class="fa fa-star-o"></i>
                      <i class="fa fa-star-o"></i>
                      <i class="fa fa-star-o"></i>
                      <i class="fa fa-star-o"></i>
                    </div>
                    <p>{{ $product -> description }}</p>
                    <div class="product-select-action">
                      <div class="select-item">
                        <div class="select-material-wrap">
                          <span>Chất liệu :</span>
                          <span> {{ $product -> material() }}</span>
                        </div>
                      </div>
                      <div class="select-item">
                        <div class="select-color-wrap">
                          <span>Màu sắc :</span>
                          <ul>
                            @foreach($silbingColor as $sibling)
                            @if($sibling -> ID == $product -> ID)
                              <li style="{{ $sibling -> selectedColorStyle(); }}" class="stroke"></li>
                            @else 
                              <a href="{{ route('client.product.detail',['id' => $sibling -> ID]) }}"> <li style="{{ $sibling -> colorStyle(); }}"> </li></a>
                            @endif
                             
                            @endforeach
                          </ul>
                        </div>
                      </div>
                      <div class="select-item">
                        <div class="select-material-wrap">
                          <span>Số lượng còn lại:</span>
                          <span> {{ $product -> quantity }}</span>
                        </div>
                      </div>
                    </div>
                    <div class="product-action-simple">
                      <div class="product-quick-action">
                        <div class="product-quick-qty">
                          <span>Số lượng:</span>
                          <div class="pro-qty">
                            <input type="text" id="quantity" title="Quantity" value="1">
                          </div>
                        </div>
                      </div>
                      <div class="cart-wishlist-button">
                        <a href="javascript:void(0);" class="btn-cart" data-id="{{ $product -> ID }}" data-url="{{ route('client.cart.add') }}">Thêm vào giỏ hàng</a>
                        <div class="product-wishlist">
                          <a class="add-wishlist" href="javascript:void(0);">
                            <span class="icon">
                              <i class="bardy bardy-wishlist"></i>
                              <i class="hover-icon bardy bardy-wishlist"></i>
                            </span>
                          </a>
                        </div>
                      </div>
                      <div class="buy-now-btn">
                        @if($product -> quantity > 0)
                          <button class="btn btn-Buy">Mua ngay</button>
                        @else
                          <button class="btn btn-block">Hết hàng</button>
                        @endif
                      </div>
                    </div>
                    <div class="product-action-bottom">
                      <div class="social-sharing">
                        <span>Share:</span>
                        <div class="social-icons">
                          <a href="#/"><i class="shopify-social-icon-facebook-rounded color"></i></a>
                          <a href="#/"><i class="shopify-social-icon-twitter-rounded color"></i></a>
                          <a href="#/"><i class="shopify-social-icon-googleplus-rounded color"></i></a>
                          <a href="#/"><i class="shopify-social-icon-pinterest-rounded color"></i></a>
                        </div>
                      </div>
                    </div>
                  </div>
                  <!--== End Product Info Area ==-->
                </div>
              </div>
              <div class="row">
                <div class="col-12">
                  <div class="product-review-tabs-content">
                    <div class="nav nav-tabs product-tab-nav" id="ReviewTab" role="tablist">
                      <button class="nav-link active" id="description-tab" data-bs-toggle="tab" data-bs-target="#description" type="button" aria-controls="description" aria-selected="true">Mô tả</button>
                      <button class="nav-link" id="reviews-tab" data-bs-toggle="tab" data-bs-target="#reviews" type="button" aria-controls="reviews" aria-selected="false">Đánh giá</button>
                      <button class="nav-link" id="comments-tab" data-bs-toggle="tab" data-bs-target="#comments" type="button" aria-controls="comments" aria-selected="false">Bình luận</button>
                      <button class="nav-link" id="shipping-policy-tab" data-bs-toggle="tab" data-bs-target="#shipping-policy" type="button" aria-controls="shipping-policy" aria-selected="false">Chính sách giao hàng</button>
                      <!-- <button class="nav-link" id="size-chart-tab" data-bs-toggle="tab" data-bs-target="#size-chart" type="button" aria-controls="size-chart" aria-selected="false">Biểu đồ kích cỡ</button> -->
                    </div>
                    <div class="tab-content product-tab-content" id="ReviewTabContent">
                      @include('client.product_detail.description_tab',["product" => $product])
                      @include('client.product_detail.review_tab',["product" => $product])
                      @include('client.product_detail.comment_tab',["product" => $product])
                      @include('client.product_detail.shipping_policy_tab',["product" => $product])
                      @include('client.product_detail.size_chart_tab',["product" => $product])
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        @include('client.product_detail.left_side_bar')
        </div>
        <div class="row">
          <div class="col-lg-10 m-auto mt-20">
            <div class="section-title text-center">
              <h2 class="title">Sản phẩm liên quan</h2>
            </div>
          </div>
        </div>
        <div class="col-lg-12">
        <div class="swiper-container swiper-nav swiper-slide-gap product-swiper-pagination product-slider-container">
            <div class="swiper-wrapper">
              @for($i = 0 ; $i < count($relevent_product) ; $i++)
                  <div class="swiper-slide">
                    @switch($relevent_product[$i] -> display_state)
                        @case(1)
                          <x-productnewsale :product="$relevent_product[$i]"></x-productnewsale>
                        @break
                        @case(2)
                          <x-productnewsale :product="$relevent_product[$i]"></x-productnewsale>
                        @break
                    @endswitch
                  </div>
              @endfor
            </div>

            <!--== Add Swiper navigation Buttons ==-->
            <div class="swiper-button swiper-button-prev"><i class="fa fa-angle-left"></i></div>
            <div class="swiper-button swiper-button-next"><i class="fa fa-angle-right"></i></div>

            <!--== Add Swiper Pagination Buttons ==-->
            <div class="swiper-pagination"></div>
          </div>
        </div>
      </div>
    </section>
    <!--== End Product Area Wrapper ==-->
    @endsection
@section('script')
    <script>
        $('.zoom-hover').zoom();
    </script>
@endsection