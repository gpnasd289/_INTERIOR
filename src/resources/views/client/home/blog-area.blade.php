    <!--== Start Blog Area Wrapper ==-->
    <section class="blog-area">
      <div class="container">
        <div class="row">
          <div class="col-md-8 col-lg-6 m-auto">
            <div class="section-title text-center">
              <h2 class="title">Bài viết gần nhất</h2>
              <div class="desc">
                <p>Nơi học hỏi thêm nhiều kiến thức bổ ích, thú vị</p>
              </div>
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-12">
            <div class="swiper-container swiper-nav swiper-slide-gap post-slider-container">
              <div class="swiper-wrapper">
                @foreach($blogs as $blog)
                  <div class="swiper-slide">
                      <x-blogcard :blog="$blog"></x-blogcard>
                  </div>
                @endforeach
              </div>
              <div class="swiper-button swiper-button-prev"><i class="fa fa-angle-left"></i></div>
              <div class="swiper-button swiper-button-next"><i class="fa fa-angle-right"></i></div>
            </div>
          </div>
        </div>
      </div>
    </section>