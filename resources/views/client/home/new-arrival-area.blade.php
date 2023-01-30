    <!--== Start Product Area Wrapper ==-->
    <section class="product-area">
      <div class="container">
        <div class="row">
          <div class="col-lg-6 m-auto">
            <div class="section-title text-center">
              <h2 class="title">Sản phẩm bán chạy</h2>
              <div class="desc">
                <p>Chất lượng sản phẩm luôn được chúng tôi đặt lên hàng đầu.</p>
              </div>
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-12">
            <div class="swiper-container swiper-nav swiper-slide-gap product-slider-container">
              <div class="swiper-wrapper">

                @for($i = 0 ; $i < count($most_sell_prod) ; $i++)
                      @if($i % 2 == 0)
                        <div class="swiper-slide">
                      @endif

                        @switch($most_sell_prod[$i] -> display_state)
                            @case(1)
                              <x-productnewsale :product="$most_sell_prod[$i]"></x-productnewsale>
                            @break
                            @case(2)
                              <x-productnewsale :product="$most_sell_prod[$i]"></x-productnewsale>
                            @break
                            @case(3)
                              <x-productnewsale :product="$most_sell_prod[$i]"></x-productnewsale>
                            @break
                            @case(4)
                              <x-productnewsale :product="$most_sell_prod[$i]"></x-productnewsale>
                            @break
                        @endswitch
                      

                      @if($i % 2 != 0)
                        </div>
                      @endif
                    @endfor
                
              </div>

              <!--== Add Swiper navigation Buttons ==-->
              <div class="swiper-button swiper-button-prev"><i class="fa fa-angle-left"></i></div>
              <div class="swiper-button swiper-button-next"><i class="fa fa-angle-right"></i></div>
            </div>
          </div>
        </div>
  </div>
    </section>
    <!--== End Product Area Wrapper ==-->