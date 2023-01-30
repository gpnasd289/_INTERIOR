<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lịch sử hóa đơn</title>
    <link href="{{ asset('admin/assets/css/bootstrap.min.css') }}" rel="stylesheet" type="text/css">
    <link href="{{ asset('admin/assets/css/bill-report.css') }}" rel="stylesheet" type="text/css"> 
    <link href="{{ asset('assets/css/font-awesome.min.css') }}" rel="stylesheet" />
</head>
<body>
<div class="fixed-top navigation">
    <div class="d-flex flex-row-reverse align-items-center btn-wrap">
        <button class="btn btn-print"><i class="fa fa-print"></i></button>
    </div>

</div>
<div class="main-page">
        <div class="sub-page">
        <div class="">
            <div class="bill-report-header">
                <div class="row">
                    <div class="col-md-4">
                        <img class="bill-report-logo" src="{{ asset('assets/img/logo.png')}}" alt="logo"/>
                    </div>
                    <div class="col-md-7 offset-1 d-flex flex-row-reverse">
                        <div class="bill-report-shop-info">
                            <h5>Cửa hàng nội thất Diana</h5>
                            <div>Địa chỉ: Số 3 Cầu Giấy, Quận Cầu Giấy, Thành phố Hà Nội</div>
                            <div>Liên hệ: +84 0331 91 654</div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="bill-report-body">
                <div class="report-body-title">
                    <h2>ĐƠN HÀNG #{{ $bill -> ID}}</h2>
                </div>
                <div class="report-body-information">
              
                    <div class="row">
                        <div class="col-md-6">
                            <span class="report-title report-id">MÃ HÓA ĐƠN: </span> #{{ $bill -> ID}}
                        </div>
                        <div class="col-md-6">
                            <span class="report-title report-buyer">NGƯỜI MUA: </span>  {{ $bill -> customer_name() }}
                        </div>
                        <div class="col-md-10">
                            <span class="report-title report-time-buy">THỜI GIAN MUA: </span> {{ $bill -> created_at() }}
                        </div>
                    </div>
              
                    <div class="row">
                        <div class="col-md-12">
                            <span class="report-title">ĐỊA CHỈ : </span> {{ $bill -> address }}
                        </div>
                        <div class="col-md-12">
                            <span class="report-title">ĐỊA CHỈ NHẬN HÀNG 1: </span> {{ $bill -> receive_place_detail_1 }}
                        </div>
                        <div class="col-md-12">
                            <span class="report-title">ĐỊA CHỈ NHẬN HÀNG 2: </span> {{ $bill -> receive_place_detail_2 }}
                        </div>
                    </div>

                    <div class="report-payment">
                    <table style="width:100%;">
                    <tbody >
                        <tr>
                            <td style="width:230px">
                                <div class="report-title payment">MÃ GIẢM GIÁ :</div>
                            </td>
                            <td>
                                <div class="payment col-md-12">{{ $bill -> promotion() }}</div>
                            </td>
                        </tr>
                        <tr>
                            <td style="width:230px">
                                <div class="report-title payment ">PHƯƠNG THỨC THANH TOÁN: </div>
                            </td>
                            <td>
                            <div class="payment col-md-12">{{ $bill -> payment() }}</div>
                            </td>
                        </tr>
                        <tr>
                            <td style="width:230px">
                                <div class="report-title payment ">PHÍ SHIP :</div>
                            </td>
                            <td>
                            <div class="payment col-md-12">#FREE</div>
                            </td>
                        </tr>
                        <tr>
                            <td style="width:230px">
                            <div class="report-title payment ">THUẾ VAT :</div>
                            </td>
                            <td>
                            <div class="payment col-md-12"> 10% </div>
                            </td>
                        </tr>
                        <tr>
                            <td style="width:230px">
                            <div class="report-title payment ">TỔNG TIỀN :</div>
                            </td>
                            <td>
                            <div class="payment col-md-12"> <strong>{{ $bill -> total() }} VND </strong></div>
                            </td>
                        </tr>
                    </tbody>
                        
                    </div>

                    <div class="report-list-product">
                        <table class="table" style="margin-top:40px">
                            <thead class="thead-light">
                                <tr>
                                    <th scope="col" class="tb-header">MÃ SẢN PHẨM </th>
                                    <th scope="col" class="tb-header">TÊN SẢN PHẨM</th>
                                    <th scope="col" class="tb-header">SỐ LƯỢNG</th>
                                    <th scope="col" class="tb-header">ĐƠN GIÁ (VND)</th>
                                    @if ($bill -> getPromotion() != null) 
                                    <th scope="col" class="tb-header">GIẢM GIÁ ({{ $bill -> getPromotion() -> discount_type_string() }})</th>
                                    @else 
                                    <th scope="col" class="tb-header">GIẢM GIÁ </th>
                                    @endif
                                   
                                    <th scope="col" class="tb-header">TỔNG TIỀN (VND)</th>
                                </tr>
                            </thead>
                            <tbody>
                                @foreach($bill-> bill_detail_raw() as $bill_detail)
                                <tr>
                                    <th scope="row">{{ $bill_detail -> product_id }}</th>
                                    <td class="product-name">{{ $bill_detail -> product -> name }}</td>
                                    <td class="tb-row">{{ $bill_detail -> quantity }}</td>
                                    <td class="tb-row">{{ $bill_detail -> price() }}</td>
                                    <td class="tb-row">{{ $bill_detail -> getDiscountProductPrice() }}</td>
                                    <td class="tb-row">{{ $bill_detail -> total() }}</td>
                                </tr>
                                @endforeach
                            </tbody>
                        </table>
                    </div>
                </div>  
            <div class="goodbye">
                <div class="report-time">
                        Hà Nội, Ngày {{ $today -> day }} tháng {{ $today -> month }} năm {{ $today -> year }}
                 </div>
   
                <div class="bill-report-footer">
                    <div class="report-thank-you">
                            <p>CẢM ƠN QUÝ KHÁCH HÀNG ĐÃ MUA HÀNG TẠI <span style="color:red">DIANA</span> !! <br>
                            XIN CHÚC QUÝ KHÁCH HÀNG MỘT NGÀY TỐT LÀNH </p>
                    </div>
        
                </div>
           </div>
    
        </div>

    </div>   
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
   <script src="{{ asset('admin/assets/js/bill-report.js') }}"></script>

</body>
</html>
  
   