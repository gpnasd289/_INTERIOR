<div class="product-action">
<div class="addto-wrap">
    <a class="add-cart" href="javascript:void(0);" data-id="{{ $product->ID }}" data-url="{{ route('client.cart.add') }}">
    <span class="icon">
        <i class="bardy bardy-shopping-cart"></i>
        <i class="hover-icon bardy bardy-shopping-cart"></i>
    </span>
    </a>
    <a class="add-wishlist" href="javascript:void(0);" data-id="{{ $product->ID }}">
    <span class="icon">
        <i class="bardy bardy-wishlist"></i>
        <i class="hover-icon bardy bardy-wishlist"></i>
    </span>
    </a>
    <a class="add-quick-view" href="javascript:void(0);" data-id="{{ $product->ID }}">
    <span class="icon">
        <i class="bardy bardy-quick-view"></i>
        <i class="hover-icon bardy bardy-quick-view"></i>
    </span>
    </a>
</div>