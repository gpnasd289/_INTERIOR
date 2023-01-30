<tr id="{{ $item->rowId }}" class="cart-item-row">
    <td class="pro-thumbnail">
        <a href="{{ route('client.product.detail',['id' => $item->model -> ID])}}"><img src=" {{ $item->model -> image_no_background_path() }}" alt="{{ $item->model->name . ' '. $item->model->description }}"></a>
    </td>
    <td class="pro-title">
    <h4 class="title"><a href="{{ route('client.product.detail',['id' => $item->model -> ID])}}">{{ $item->model->name }}</a></h4>
    </td>
    <td class="pro-price">
        <span class="amount">{{ $item->model->getPrice() }}</span>
    </td>
    <td class="pro-quantity">
    <div class="pro-qty">
        <input type="text" id="quantity-{{ $item->rowId }}" data-id="{{ $item->rowId }}" data-price="{{ $item->model->getPrice() }}" title="Quantity" value="{{ $item -> qty }}">
    </div>
    </td>
    <td class="pro-subtotal">
        <span class="subtotal-amount" id="subamount-{{ $item->rowId }}">{{ number_format($item->model->price_sell * $item-> qty,0,'','.') }}</span>
    </td>
    <td class="pro-remove">
    <a class="remove" href="javascript:void(0);" data-id="{{ $item->rowId }}" data-url="{{ route('client.cart.delete')}}"><i class="fa fa-trash-o"></i></a>
    </td>
</tr>s