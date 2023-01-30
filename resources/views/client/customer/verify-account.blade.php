@extends('client.layouts.main')

@section('main-content')
    <!--== Start Page Header Area Wrapper ==-->
    <div class="page-header-area">
        <div class="container">
            <div class="row"> 
                <div class="col-12 text-center">
                    <div class="page-header-content">
                        <h4 class="title" data-aos="fade-down" data-aos-duration="1200">Xác minh tài khoản</h4>
                        <nav class="breadcrumb-area" data-aos="fade-down" data-aos-duration="1000">
                        <ul class="breadcrumb">
                            <li><a href="{{ route('home') }}">Home</a></li>
                            <li class="breadcrumb-sep">-</li>
                            <li><a href="javascript:void(0);">Xác minh tài khoản</a></li>
                        </ul>
                        </nav>
                    </div>
                </div>
            </div>
        </div>
    </div>
<!--== End Page Header Area Wrapper ==-->
    <section class="verify-account-field">
        <div class="container">
            <div class="box-1">
                 <div class="d-flex justify-content-center">
                     <h2 class="title" style="color: white; margin-bottom: 20px;">Tài khoản cần được xác minh </h3>
                 </div>
                    <p>Chúng tôi đã gửi cho bạn một email đến địa chỉ <span style="color:yellow; text-decoration:underline">{{ $customer -> profile -> email}} </span> để xác minh tài khoản</p>    
                    <p>Nếu trong 5 phút không nhận được email từ chúng tôi xin hãy thử lại <a id="verify-account" href="javascript:void(0);" data-url="{{ route('client.customer.resend_verify',['id' => $customer -> ID]) }}">Tại đây</a></p>
            </div>
        </div>
    </section>
        <!--== End Blog Details Area Wrapper ==-->
@endsection
