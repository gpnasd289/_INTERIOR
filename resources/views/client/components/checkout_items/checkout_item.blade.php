<div class="shipping-cart-item">
<div class="thumb">
    <img src="{{ $product -> image_no_background_path()}}" alt="{{ $product -> name }}" style="height:63.99px">
    <span class="quantity">{{ $quantity }}</span>
</div>
<div class="content">
    <h4 class="title">{{ $product -> name}}</h4>
    <span class="info">chiếc</span>
    <span class="price">{{ $product -> getPrice() }} VND</span>
</div>
</div>