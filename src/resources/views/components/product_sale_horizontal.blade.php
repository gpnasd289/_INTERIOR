<div class="product-item product-item-list">
<div class="inner-content">
    <div class="product-thumb">
    <a href="{{ route('client.product.detail',['id' => $product -> ID]) }}">
        <img class="w-100 product-image-preview" src="{{ $product -> image_with_background_path() }}" alt="{{ $product -> name }}">
    </a>
    </div>
    <div class="product-desc">
    <div class="product-info">
        @include('client.components.product_items.product_general_info',['product' => $product])
        <div class="prices">
            <span class="price-old">{{ $product-> getPriceSale()  }} VND</span><br>
            <span class="price"> {{ $product-> getPrice()  }} VND</span>
        </div>
        <p>{{ $product -> description }}</p>
        @include('client.components.product_items.product_action',['product' => $product])
    </div>
    </div>
</div>
</div>