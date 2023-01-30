@extends('client.layouts.main')
@section('main-content')
        <!--== Start Page Header Area Wrapper ==-->
    <div class="page-header-area">
        <div class="container">
        <div class="row">
            <div class="col-12 text-center">
            <div class="page-header-content">
                <h4 class="title" data-aos="fade-down" data-aos-duration="1200">Thông tin khách hàng</h4>
                <nav class="breadcrumb-area" data-aos="fade-down" data-aos-duration="1000">
                <ul class="breadcrumb">
                    <li><a href="{{ route('home') }}">Trang chủ</a></li>
                    <li class="breadcrumb-sep">-</li>
                    <li>Thông tin khách hàng</li>
                </ul>
                </nav>
            </div>
            </div>
        </div>
        </div>
    </div>
    <!--== End Page Header Area Wrapper ==-->

    <section >
        <div class="container">
            <div class="row">
                <div class="col-md-4">
                    <div class="_profile_card">
                        <div class="_profile_common_info">
                            <div class="_profile_common_info_avatar">
                                <img class="_user_avatar" alt="" src="{{ asset('assets/images/avatar_blank.png') }}">
                            </div>
                            <div class="_profile_common_info_name">
                                <div class="_profile_common_info_display_name"><h4>{{ $customer -> profile -> name}}</h4></div>
                                <div class="_profile_common_info_user_role" tooltip="Giảm giá 10%"> {!! $customer -> rank_icon() !!} {{ $customer -> rank }}</div>
                            </div>
                        </div>
                        <hr>
                        <div class="_profile_common_info_feature active" data-id="info" data-url="{{ route('client.profile.profile-info',[ 'id' => $customer -> ID]) }}">
                            <a href="javascript:void();" alt class="feature_link" >
                                <div class="_profile_common_info_feature_box">
                                    <i class="fa fa-user-edit"></i> Tổng quan    
                                </div>
                            </a>
                        </div>
                        <div class="_profile_common_info_feature" data-id="notification" data-url="">
                            <a href="javascript:void();" alt class="feature_link" >
                                <div class="_profile_common_info_feature_box">
                                    <i class="fa fa-bell"></i> Thông báo   
                                </div>
                            </a>
                        </div>
                        <div class="_profile_common_info_feature" data-id="orders" data-url="{{ route('client.profile.orders', ['id' => $customer -> ID ]) }}">
                            <a href="javascript:void();" alt class="feature_link" >
                                <div class="_profile_common_info_feature_box">
                                    <i class="fa fa-box"></i> Đơn hàng    
                                </div>
                            </a>
                        </div>
                        <hr>
                        <div class="_profile_common_info_loggout">
                            <div class="_profile_common_info_feature">
                                <a href="{{ route('client.customer.logout') }}" alt="Đăng xuất" class="feature_link">
                                    <div class="_profile_common_info_feature_box">
                                        <i class="fa fa-power-off"></i> Đăng xuất    
                                    </div>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-8" class="_profile_card_body">
                    <div class="_profile_card" id="profile_card_body">
            
                    </div>
                </div>
            </div>
        </div>
    </section>
@endsection

@section('script')
<script>
    $(function () {
        $(document).on('click', '._profile_card .customer-orders .customer-orders-header ._list_order .table tbody tr td #cancelbill', function () { 
            var id = $(this).data('id');
            var url = $(this).data('url');
          
            swal({
                title: 'Bạn chắc muốn huỷ đơn chứ ?',
                text: "Bạn sẽ không thể hoàn tác lại thao tác",
                type: 'warning',
                showCancelButton: true,
                confirmButtonClass: 'btn btn-success',
                cancelButtonClass: 'btn btn-danger m-l-10',
                confirmButtonText: 'OK'
            }).then((result) => {
                if (result) {
                    $.ajax({
                        url: url,
                        method: "POST",
                        data: {
                            "id": id,
                            "_token": $('meta[name="csrf-token"]').attr('content'),
                        }, success: function(e) {
                           console.log(e.success);
                        }
                    })
                }
            })
       
        });
    
    })
</script>

@endsection