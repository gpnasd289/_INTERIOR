<!--== Start Hero Area Wrapper ==-->
<section class="home-slider-area">
    <div class="swiper-container swiper-slide-gap home-slider-container default-slider-container">
    <div class="swiper-wrapper home-slider-wrapper slider-default">
        <div class="swiper-slide" >
        <div class="slider-content-area" data-bg-img=" {{ $carosel_image -> file_path ?? '' }}">
            <div class="container">
            <div class="row align-items-center" >
                <div class="col-12" >
                    <div class="slider-content text-center">
                        <h5 class="sub-title">Bộ sưu tập 2023</h5>
                        <h2 class="title">Chủ đề mới <br>Ghế gỗ trong nhà</h2>
                        <a class="btn-slider" href="{{  route('client.shop.view') }}">Mua ngay</a>
                    </div>
                </div>
            </div>
            </div>
        </div>
        </div>
        @foreach($other_image as $image )
            <div class="swiper-slide">
            <div class="slider-content-area" data-bg-img="{{ $image -> file_path  ?? ''}}">
                <div class="container">
                <div class="row align-items-center">
                    <div class="col-12">
                    <div class="slider-content text-end">
                        <h5 class="sub-title">NEW COLLECTION 2023</h5>
                        <h2 class="title">The Brighten Up <br>Interior Collection</h2>
                        <a class="btn-slider" href="{{  route('client.shop.view') }}">Mua ngay</a>
                    </div>
                    </div>
                </div>
                </div>
            </div>
            </div>
        @endforeach
    </div>

    <!--== Add Swiper Arrows ==-->
    <div class="swiper-button-next"><i class="fa fa-angle-right"></i></div>
    <div class="swiper-button-prev"><i class="fa fa-angle-left"></i></div>
    </div>
</section>
    <!--== End Hero Area Wrapper ==-->