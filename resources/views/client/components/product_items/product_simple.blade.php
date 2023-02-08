   <!--== Start Shop Item ==-->
   <div class="product-item">
      <div class="inner-content">
        <div class="product-thumb">
          <a href="shop-single.html">
            <img class="w-100 product-image-preview" src="{{ $product -> image_with_background_path()}}" alt="Image-HasTech">
          </a>
          @include('client.components.product_items.product_action',['product' => $product])
        </div>
        <div class="product-desc">
          <div class="product-info">
            <h4 class="title"><a href="shop-single.html"> {{ $product->name }}</a></h4>
            <div class="star-content">
              <i class="fa fa-star-o"></i>
              <i class="fa fa-star-o"></i>
              <i class="fa fa-star-o"></i>
              <i class="fa fa-star-o"></i>
              <i class="fa fa-star-o"></i>
            </div>
            <div class="prices">
              <span class="price"> {{ $product -> price_sell }} VND</span>
            </div>
          </div>
        </div>
      </div>
    </div>
    <!--== End Shop Item ==-->
