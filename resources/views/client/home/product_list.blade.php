<section class="product-area product-list-area">
      <div class="container">
        <div class="row">
          <div class="col-lg-10 m-auto">
            <div class="section-title text-center">
              <h2 class="title">Danh sách sản phẩm</h2>
              <div class="desc">
                <p>Khách hàng khi đến mua hàng tại Diana nói rằng họ tin tưởng chúng tôi do đó họ sẽ chọn nội thất của chúng tôi mà không lưỡng lự bởi vì họ tin tưởng chúng tôi và luôn vui vẻ khi sử dụng sản phẩm.</p>
              </div>
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-12">
            <div class="product-category-tab-wrap">
              <ul data-aos="fade-down" class="nav nav-tabs product-category-nav justify-content-center" id="myTab" role="tablist">
                <li class="nav-item" role="presentation">
                  <button class="nav-link active" id="featured-tab" data-bs-toggle="tab" data-bs-target="#featured" type="button" role="tab" aria-controls="featured" aria-selected="true">Sản phẩm bán chạy</button>
                </li>
                <li class="nav-item" role="presentation">
                  <button class="nav-link" id="chair-tab" data-bs-toggle="tab" data-bs-target="#chair" type="button" role="tab" aria-controls="chair" aria-selected="false">Sản phẩm mới</button>
                </li>
                <li class="nav-item" role="presentation">
                  <button class="nav-link" id="sofa-tab" data-bs-toggle="tab" data-bs-target="#sofa" type="button" role="tab" aria-controls="sofa" aria-selected="false">Sản phẩm sắp ra mắt</button>
                </li>
                <li class="nav-item" role="presentation">
                  <button class="nav-link" id="collection-tab" data-bs-toggle="tab" data-bs-target="#collection" type="button" role="tab" aria-controls="collection" aria-selected="false">Bộ sưu tập</button>
                </li>
              </ul>
              <div class="tab-content product-category-content" id="myTabContent">
                <div class="tab-pane fade show active" id="featured" role="tabpanel" aria-labelledby="featured-tab">
                  <div class="row">
                    <div class="col-12">
                      <div class="swiper-container swiper-nav swiper-slide-gap product-swiper-pagination product-slider-container">
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

                        <!--== Add Swiper Pagination Buttons ==-->
                        <div class="swiper-pagination"></div>
                      </div>
                    </div>
                  </div>
                </div>
                <div class="tab-pane fade" id="chair" role="tabpanel" aria-labelledby="chair-tab">
                  <div class="row">
                    @for($i = 0 ; $i < count($new_feature) ; $i++)
                      <div class="col-sm-6 col-lg-4 col-xl-3">
                        <x-productnewsale :product="$new_feature[$i]"></x-productnewsale>
                      </div>
                    @endfor
                  </div>
                </div>
                <div class="tab-pane fade" id="collection" role="tabpanel" aria-labelledby="collection-tab">
                  <div class="row">
                    @for($i = 0 ; $i < count($chair) ; $i++)
                      <div class="col-sm-6 col-lg-4 col-xl-3">
                        <x-productnewsale :product="$chair[$i]"></x-productnewsale>
                      </div>
                    @endfor
                    @for($i = 0 ; $i < count($ward) ; $i++)
                      <div class="col-sm-6 col-lg-4 col-xl-3">
                        <x-productnewsale :product="$ward[$i]"></x-productnewsale>
                      </div>
                    @endfor
                    @for($i = 0 ; $i < count($lamp) ; $i++)
                      <div class="col-sm-6 col-lg-4 col-xl-3">
                        <x-productnewsale :product="$lamp[$i]"></x-productnewsale>
                      </div>
                    @endfor
                  </div>
                </div>


                <div class="tab-pane fade" id="sofa" role="tabpanel" aria-labelledby="sofa-tab">
                  <div class="row">
                    @for($i = 0 ; $i < count($comming_soon_prd) ; $i++)
                        <div class="col-sm-6 col-lg-4 col-xl-3">
                          <x-productnewsale :product="$comming_soon_prd[$i]"></x-productnewsale>
                        </div>
                    @endfor
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
    <!--== End Product Area Wrapper ==-->
