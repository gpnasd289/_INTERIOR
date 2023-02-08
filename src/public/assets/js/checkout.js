$('.col-md-4 #btn_apply_coupon').click(function () {
    var voucherTitle = $('#discount-voucher').val()
    console.log(voucherTitle);
    var url = $(this).data('url')
    $.ajax({
        url: url,
        method: "POST",
        data: {
            '_token': $('meta[name="csrf-token"]').attr('content'),
            'voucher': voucherTitle
        }, success: function (e) {
            if (e.code == 200) {
                $('#coupon').val(voucherTitle);
                var total = e.data.checkout_total.toLocaleString('it-IT', {style : 'currency', currency : 'VND'});
                $('#checkout-total-final').html(total.slice(0,-3) + '<span class="usd">VND</span>')
                $('#checkout-total').html(total)
                swal({
                    title:"Thông báo",
                    text:'Thêm mã giảm giá thành công',
                    type:'success',
                    showCancelButton: false,
                    confirmButtonClass: 'btn btn-success',
                    confirmButtonText: 'OK',
                })
            } else if(e.code == 201) {
                console.log(e);
                $('#discount-voucher').after("<div class='error'> *" + e.message + "</div>")
            } else {
                console.log(e);
            }
        }
    })  
});


$('#btn-payment').on('click',function () {
    processPayment()
});
$('#form-payment').on('submit', function (e) {
    e.preventDefault();
    processPayment()
})

function processPayment() {

    const url = $('#form-payment').data('url')
    var coupon              = $('#coupon').val();
    var first_name          = $('#first_name').val();
    var last_name           = $('#last_name').val();
    var address             = $('#address').val();
    var phone_number        = $('#phone_number').val();
    var address_detail_1    = $('#address_detail_1').val();
    var payment_type        = 1;
    if ($('#payment-method-paypal').is(":checked")) {
        payment_type = 2;
    }
    var address_detail_2    = $('#address_detail_2').val()
    $('.btn-return .loader-20').remove()
    $('.btn-return').after("<span class='loader-20'> </span>")
    $.ajax({
        url: url,
        method:"POST",
        data: {
            '_token': $('meta[name="csrf-token"]').attr('content'),
            'recipient_firstname'        : first_name,
            'recipient_lastname'         : last_name,
            'address'                    : address,
            'receipent_phone_number'     : phone_number,
            'receive_place_detail_1'     : address_detail_1,
            'receive_place_detail_2'     : address_detail_2,
            'promotion_title'            : coupon,
            'payment_method'             : payment_type
        },
        success: function (e) {
            $('.btn-box .loader-20').remove();
            if (e.code == 200 ) {
                if (e.type == "paypal") {
                    window.location.href = e.route;
                    return;
                }
                swal({
                    title:"Thông báo",
                    text:'Mua hàn thành công !!',
                    type:'success',
                    showCancelButton: false,
                    confirmButtonClass: 'btn btn-success',
                    confirmButtonText: 'OK',
                }).then((result) => {
                    if (result.isConfirmed) {
                        window.location.href = "/"
                        console.log('confirrm')
                    } 
                })
            }
        },error: function(e) {
            console.log("Error ", + e.responseText)
        }
    })
}