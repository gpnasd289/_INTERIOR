<h4 class="cart-title">Giỏ hàng của bạn</h4>
<div class="cart-item-wrap">
@foreach(Cart::instance('shopping')->content() as $data)
    <div class="cart-item" id="{{ $data->rowId }}"  >
        <div class="thumb">
        <a href="{{ route('client.product.detail',['id' => $data->model->ID ])}}">
            <img class="w-100" src="{{ $data->model->image_no_background_path() }}" height="60px" width="60px" alt="{{ $data -> model -> name . ' ' . $data -> model -> description}}"></a>
        <a class="remove" href="javascript:void(0);" data-id="{{ $data->rowId }}" data-url="{{ route('client.cart.delete') }}"><i class="fa fa-trash-o"></i></a>
        </div>
        <div class="content">
        <h5 class="title"><a href="{{ route('client.product.detail',['id' => $data->model->ID ])}}" class="text-1-line">{{ $data -> model->name}}</a></h5>
        <span> {{ $data->qty }} x {{ $data->model-> getPrice()  }} VND</span>
        </div>
    </div>
@endforeach
</div>
<div class="mini-cart-footer">
<h4>Tổng tiền: <span class="total">{{ Cart::instance('shopping')->subtotal('0',',',',') }}  VND</span></h4>
<div class="cart-btn">
    <a class="mr-2" href="{{ route('client.cart.index') }}">Giỏ hàng</a>
    <a href="{{ route('client.checkout.view') }}">Thanh toán</a> 
</div>
</div>