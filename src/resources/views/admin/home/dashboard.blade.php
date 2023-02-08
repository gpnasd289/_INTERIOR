@extends('admin.layouts.main')
@section('main-content')
    <div class="row">
            <div class="col-sm-12">
                <div class="page-title-box">
                    <h4 class="page-title">Dashboard</h4>
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item active">Chào mừng đến với trang quản trị</li>
                    </ol>
                </div>
            </div>
        </div>  
    <div class="page-content-wrapper">
        <div class="row">
            <x-admin_dashboard_stat title="Tổng Đơn hàng" :data=" $order->count()" icon="mdi-cube-outline" :type="1" id="bill-count"></x-admin_dashboard_stat>
            <x-admin_dashboard_stat title="Doanh thu" :data="$sum -> total_yearly" icon="mdi-cube-outline" :type="2" id="total_money"></x-admin_dashboard_stat>
            <x-admin_dashboard_stat title="Tổng khách hàng " :data="$customer -> count()" icon="mdi-cube-outline" :type="3" id="customer-count"></x-admin_dashboard_stat>
            <x-admin_dashboard_stat title="Đơn hàng mới" :data="$bill_new -> count()" icon="mdi-cube-outline" :type="4" id="bill-new"></x-admin_dashboard_stat>
        </div>

        <div class="row">
            <div class="col-xl-12">
                <div class="card">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-xl-8 border-right">
                                <h4 class="mt-0 header-title mb-4">Doanh thu hàng tháng</h4>
                                <div id="monthly-analyst" class="dashboard-charts morris-charts"></div>
                            </div>
                            <div class="col-xl-4">
                                <h4 class="header-title mb-4">Trạng thái đơn hàng</h4>
                                <div id="bill-status" class="dashboard-charts morris-charts"></div>
                            </div>
                        </div>
                        <!-- end row -->
                    </div>
                </div>
            </div>
            <!-- end col -->
        </div>
    </div>
@endsection
@section('script')
<script>

    var speed = 10;

    /* Call this function with a string containing the ID name to
    * the element containing the number you want to do a count animation on.*/
    function incEltNbr(id) {
        elt = document.getElementById(id);
        endNbr = Number(document.getElementById(id).innerHTML);
        incNbrRec(0, endNbr, elt, id);
    }

    /*A recursive function to increase the number.*/
    function incNbrRec(i, endNbr, elt,id) {
        if (i <= endNbr) {
            if (id == "total_money") {
                display = i.toLocaleString('it-IT', {style : 'currency', currency : 'VND'});
                console.log(id + display)
                elt.innerHTML = display;
            } else {
                elt.innerHTML = i;
            }
            if (endNbr > 1000000) {
                setTimeout(function() {//Delay a bit before calling the function again.
                    incNbrRec(i + 1000000, endNbr, elt, id);
                }, speed);
            } else if (endNbr > 10000000) {
                setTimeout(function() {//Delay a bit before calling the function again.
                    incNbrRec(i + 10000000, endNbr, elt, id);
                }, speed);
            } else if (endNbr > 100000000) {
                setTimeout(function() {//Delay a bit before calling the function again.
                    incNbrRec(i + 100000000, endNbr, elt, id);
                }, speed);
            }
            else {
                setTimeout(function() {//Delay a bit before calling the function again.
                incNbrRec(i + 1, endNbr, elt, id);
                }, speed);
            }
        }
    }

    /*Function called on button click*/
    function incNbr(){
        incEltNbr("dashboard-value");
    }

    incEltNbr("total_money"); /*Call this funtion with the ID-name for that element to increase the number within*/
    incEltNbr("bill-count");
    incEltNbr("customer-count");
    incEltNbr("bill-new");
</script>

    <script>
        $(function() {
            $.ajax({
                url: window.location.origin + "/api/statistic/bill-sum-by-month",
                method: "GET",
                data: {},
                success: function(e) {
                    let data = [
                        { "Tháng": '1', "Doanh Thu": e.statistic.Jan},
                        { "Tháng": '2', "Doanh Thu": e.statistic.Feb},
                        { "Tháng": '3', "Doanh Thu": e.statistic.Mar},
                        { "Tháng": '4', "Doanh Thu": e.statistic.Apr},
                        { "Tháng": '5', "Doanh Thu": e.statistic.May},
                        { "Tháng": '6', "Doanh Thu": e.statistic.Jun},
                        { "Tháng": '7', "Doanh Thu": e.statistic.Jul},
                        { "Tháng": '8', "Doanh Thu": e.statistic.Aug},
                        { "Tháng": '9', "Doanh Thu": e.statistic.Sep},
                        { "Tháng": '10', "Doanh Thu": e.statistic.Oct},
                        { "Tháng": '11', "Doanh Thu": e.statistic.Nov},
                        { "Tháng": '11', "Doanh Thu": e.statistic.Dec},
                    ]
                    new Morris.Bar({
                        element: 'monthly-analyst',
                        data: data,
                        xkey: 'Tháng',
                        ykeys: ["Doanh Thu"],
                        labels: ["Doanh Thu"]
                    });
                }
            })

            $.ajax({
                url: window.location.origin + "/api/statistic/get-bill-status",
                method: "GET",
                data: {},
                success: function(e) {
                    let data = [
                        { label: 'Đơn hàng mới', value : e.statistic.bill_new},
                        { label: 'Đơn hàng đã xác nhận', value : e.statistic.bill_confirm},
                        { label: 'Đơn hàng đang được đóng gói', value : e.statistic.bill_packing},
                        { label: 'Đơn hàng đang giao', value : e.statistic.bill_shipping},
                        { label: 'Đơn hàng đã giao', value : e.statistic.bill_shipped},
                        { label: 'Đơn hàng hoàn thành', value : e.statistic.bill_complete},
                        { label: 'Đơn hàng hủy', value : e.statistic.bill_cancel},
                        { label: 'Tổng số đơn hàng', value : e.statistic.bill_total},
                    ]
                    new Morris.Donut({
                        element: 'bill-status',
                        data: data,
                        resize: true,
                        colors: [
                            '#E0F7FA',
                            '#B2EBF2',
                            '#80DEEA',
                            '#4DD0E1',
                            '#26C6DA',
                            '#00BCD4',
                            '#00ACC1',
                            '#0097A7',
                        ]
                    });
                }
            })
        })
        </script>
@endsection