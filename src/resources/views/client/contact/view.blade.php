@extends('client.layouts.main')
@section('header')

@endsection

@section('main-content')
    <div class="page-header-area">
        <div class="container">
            <div class="row">
            <div class="col-12 text-center">
                <div class="page-header-content">
                <h4 class="title" data-aos="fade-down" data-aos-duration="1200">Liên hệ</h4>
                <nav class="breadcrumb-area" data-aos="fade-down" data-aos-duration="1000">
                    <ul class="breadcrumb">
                    <li><a href="{{ route('home') }}">Trang chủ</a></li>
                    <li class="breadcrumb-sep">-</li>
                    <li>Liên hệ</li>
                    </ul>
                </nav>
                </div>
            </div>
            </div>
        </div>
        </div>
        <!--== End Page Header Area Wrapper ==--> <!--== Start Contact Area Wrapper ==-->
    <section class="contact-area">
      <div class="container">
        <div class="row">
          <div class="col-lg-5">
            <div class="contact-info">
              <div class="info-item">
                <div class="info">
                  <h4 class="title">Địa chỉ</h4>
                  <p>Số 3 Cầu Giấy, quận Cầu Giấy, thành phố Hà Nội</p>
                </div>
              </div>
              <div class="info-item">
                <div class="info">
                  <h4 class="title">Số điện thoại</h4>
                  <a href="tel:+8801234 567 890">+84 01234 567 890</a>
                  <a href="tel:+8801234 567 890">+84 01234 567 890</a>
                </div>
              </div>
              <div class="info-item">
                <div class="info">
                  <h4 class="title">Web</h4> 
                  <a href="mailto:info@example.com">diana@gmail.com</a>
                  <a href="mailto:www.example.com">www.diana.com</a>
                </div>
              </div>
            </div>
          </div>
          <div class="col-lg-7">
            <!--== Start Contact Form ==-->
            <div class="contact-form">
              <h4 class="contact-form-title">Liên hệ</h4>
              <p class="desc">Biểu mẫu liên hệ</p>
              <form id="contact-form" action="http://whizthemes.com/mail-php/raju/arden/mail.php" method="post">
                <div class="row row-gutter-20">
                  <div class="col-md-6">
                    <div class="form-group">
                      <input class="form-control" type="text" name="con_name" placeholder="Name" required>
                    </div>
                  </div>
                  <div class="col-md-6">
                    <div class="form-group">
                      <input class="form-control" type="email" name="con_email" placeholder="Email" required>
                    </div>
                  </div>
                  <div class="col-md-6">
                    <div class="form-group">
                      <input class="form-control" type="text" name="con_phone" placeholder="Number">
                    </div>
                  </div>
                  <div class="col-md-6">
                    <div class="form-group">
                      <input class="form-control" type="text" name="con_name" placeholder="Subject">
                    </div>
                  </div>
                  <div class="col-md-12">
                    <div class="form-group">
                      <textarea class="form-control" name="con_message" placeholder="Message"></textarea>
                    </div>
                  </div>
                  <div class="col-md-12">
                    <div class="form-group">
                      <button class="btn btn-theme" type="submit">Xác nhận</button>
                    </div>
                  </div>
                </div>
              </form>
            </div>
            <!--== End Contact Form ==-->

            <!--== Message Notification ==-->
            <div class="form-message"></div>
          </div>
        </div>
      </div>
    </section>
    @include('client.layouts.feature-area')
@endsection

@section('script')
  
@endsection