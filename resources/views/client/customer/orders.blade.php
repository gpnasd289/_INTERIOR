<div class="customer-orders">
    <div class="customer-orders-header">
        <h3>Đơn hàng</h3>
        <br>
        <div class="_list_order">
            <table class="table table-hover">
                <thead class="thead-dark">
                    <tr>
                        <th class="text-center">Mã đơn hàng</th>
                        <th class="text-center">Danh sách sản phẩm</th>
                        <th class="text-center">Thời gian đặt</th>
                        <th class="text-center">Tình trạng đơn</th>
                        <th class="text-center">Chức năng</th>
                    </tr>
                </thead>
                <tbody>
                    @foreach($orders as $order)
                        <tr>    
                            <td class="text-center"> <a href="{{ route('client.bill.pdf', ['id' => $order -> ID]) }}" target="blank" style="text-decoration:underline;"> #{{ $order -> ID }}</a></td>
                            <td class="text-center"> <ul>
                                @foreach($order -> products() -> get() as $product)
                                    <li>{{ $product -> name }}</li>
                                @endforeach
                            </ul></td>
                            <td class="text-center"> {{ $order -> created_at() }}</td>
                            <td class="text-center"> <span class="{{ $order -> badgeStatus() }} text-white"><i class="fas fa-circle text-white" style="margin-right:10px;"></i>{{ $order-> status() }}</span> </td>
                            <td class="text-center">
                                @if ($order -> status != 6 && $order -> status != 5)
                                    <a  id="cancelbill"href="javascript:void(0);" class="btn btn-danger" style="font-size: 12px; font-weight:700;" data-url="{{ route('client.bill.cancel')}}" data-id="{{ $order-> ID }}"> Hủy đơn</a>
                                @else 
                                    <a  href="#" class="btn btn-danger" style="font-size: 12px; font-weight:700; background-color:gray;"> Hủy đơn</a>
                                @endif
                               
                            </td>
                        </tr>
                    
                    @endforeach
                </tbody>
            </table>
        </div>
    </div>
</div>

