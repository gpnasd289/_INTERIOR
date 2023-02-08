<!--== Start Shop Item ==-->
<div class="product-item">
    <div class="inner-content">
    <div class="product-thumb">
        <a href="{{ route('client.product.detail',['id' => $product -> ID]) }}">
            <img class="w-100 product-image-preview" src="{{ $product -> image_with_background_path() }}" alt="{{ $product -> name }}">
        </a>
        @include('client.components.product_items.product_action',['product' => $product])
        </div>
    </div>
    <div class="product-desc">
        <div class="product-info">
        @include('client.components.product_items.product_general_info',['product' => $product])
            <div class="prices">
            <span class="price-old">{{ $product-> getPrice()  }} VND</span><br>
                <span class="price"> {{ $product-> getPriceSale()  }} VND</span>
            </div>
        </div>
    </div>
    </div>
</div>
<!--== End Shop Item ==-->