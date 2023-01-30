<div class="product-quick-view-content">
    <button type="button" class="btn-close">
        <span class="close-icon"><i class="fa fa-close"></i></span>
    </button>
    <div class="row">
        <div class="col-lg-6 col-md-6 col-12">
        <div class="thumb">
            <!-- <img src="{{ $product -> image_with_background_path() }}" alt="{{  $product -> name .' with background ' }}"> -->
        </div>
        </div>
        <div class="col-lg-6 col-md-6 col-12">
        <div class="content">
            <!-- <h4 class="title">{{ $product -> name }}</h4> -->
            <div class="prices">
            <del class="price-old">$85.00</del>
            <span class="price">$70.00</span>
            </div>
            <!-- <p> {{ $product -> description }}</p> -->
            <div class="quick-view-select">
            <div class="quick-view-select-item">
                <label for="forSize" class="form-label">Size:</label>
                <select class="form-select" id="forSize" required>
                <option selected value="">s</option>
                <option>m</option>
                <option>l</option>
                <option>xl</option>
                </select>
            </div>
            <div class="quick-view-select-item">
                <label for="forColor" class="form-label">Color:</label>
                <select class="form-select" id="forColor" required>
                <option selected value="">red</option>
                <option>green</option>
                <option>blue</option>
                <option>yellow</option>
                <option>white</option>
                </select>
            </div>
            </div>
            <div class="action-top">
            <div class="pro-qty">
                <input type="text" id="quantity2" title="Quantity" value="1" />
            </div>
            <button class="btn btn-black">Thêm vào giỏ hàng</button>
            </div>
        </div>
        </div>
    </div>
</div>