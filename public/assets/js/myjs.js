
    $(function() {
    //     var registerSuccess = '@Session["success_register"]' != null;  
    //     if (registerSuccess) {
    //         '@Session["success_register"]' = null;
    //         swal({
    //             title:"Thông báo",
    //             text:'Đăng ký thành công',
    //             type:'success',
    //             showCancelButton: false,
    //             confirmButtonClass: 'btn btn-success',
    //             confirmButtonText: 'OK',
    //         })
    //    }
    });

$('#sortBy').on('change', function() {
    $.ajax({
        url:'',
        method:'GET',
        data:{
            '':'',
            '':''
        }, success: function(e) {

        }, error: function(e) {
            console.log(e)
        } 
    })
});

function checkPasswordStrength(password) {
	var number     = /([0-9])/;
	var upperCase  = /([A-Z])/;
	var lowerCase  = /([a-z])/;
	var specialCharacters = /([~,!,@,#,$,%,^,&,*,-,_,+,=,?,>,<])/;

	var characters     = (password.length >= 6 && password.length <= 15 );
	var capitalletters = password.match(upperCase) ? 1 : 0;
	var loweletters    = password.match(lowerCase) ? 1 : 0;
	var numbers        = password.match(number) ? 1 : 0;
	var special        = password.match(specialCharacters) ? 1 : 0;

	var total = characters + capitalletters + loweletters + numbers + special;
    password_total = total;
    return total
}

$('#verify-account').on('click', function(e) {
    e.preventDefault();
    var url = $(this).data('url');
    $.ajax({
        url: url,
        method:'GET',
        data:{
            '_token': $('meta[name="csrf-token"]').attr('content'),
        },
        success: function(e) {
            swal({
                title:"Thông báo",
                text:'Gửi lại EMAIL thành công',
                type:'success',
                showCancelButton: false,
                confirmButtonClass: 'btn btn-success',
                confirmButtonText: 'OK',
            })
        }
    })
});

let html_update_name_profile = ` <div class="_profile_update_form">
                                    <input type="text" value="" placeholder="Nhập họ và tên" id="input_name"required>
                                        <div class="_profile_setting_update_btn">
                                            <button class="_profile_update_btn" id="_btn_update_name" >Cập nhật</button>
                                            <button class="_profile_cancel_btn">Hủy</button>
                                        </div>
                                    </div>`;

let html_update_password_profile = `
                                    <div class="_profile_update_form">
                                    <input type="password" value="thao1234" name="old_password" placeholder="Nhập mật khẩu cũ" id="old_pasword">
                                    <input type="password" value="Thao1234@#" name="new_password" placeholder="Nhập mật khẩu mới" id="new_password">
                                    <input type="password" value="Thao1234@#" name="confirm_new_password" id="confirm_new_password" placeholder="Nhập lại mật khẩu mới" id="confirm_new_password">
                                        <div class="_profile_setting_forget_password">
                                            <button class="btn" id="btn-forget-password">Quên mật khẩu ?</button>
                                        </div>
                                    <div class="_profile_setting_update_btn">
                                        <button class="_profile_update_btn" id="_btn_update_password">Cập nhật</button>
                                        <button class="_profile_cancel_btn">Hủy</button>
                                    </div>
                                    </div>`;
var user_profile_name       = "";
var user_profile_password   = "";
var typeClose               = [];
var typeUpdate              = [];
var clientId                = "";
var urlUpdate               = "";
var oldNameValue            = "";
$(document).on('click', '._profile_setting_edit_option', function () { 
    var id = $(this).data('id')
    var url = $(this).data('url');
    var type = $(this).data('type');
    urlUpdate = url
    clientId = id
    showUpdateForm(type);    
});

$(document).on('click', '._profile_info ._profile_info_body ._profile_update_form ._profile_cancel_btn', function () { 
    if (typeClose.length > 0) {
        closeUpdateForm(typeClose.pop())
    }
});

$(document).on('click', '._profile_info ._profile_info_body ._profile_update_form #_btn_update_name', function () { 
    $('._profile_info ._profile_info_body ._profile_update_form .error').remove();
    var name = $('._profile_info ._profile_info_body ._profile_update_form #input_name').val()
    if (!checkName(name)) {
        return 
    }

    $.ajax({
        url: urlUpdate,
        method: "POST",
        data: {
            "_token": $('meta[name="csrf-token"]').attr('content'),
            'name': name,
            'id': clientId
        }, success: function (e) {
            if (e.code == 200) {
                swal({
                    title:"Thông báo",
                    text:'Cập nhật tên người dùng thành công',
                    type:'success',
                    showCancelButton: false,
                    confirmButtonClass: 'btn btn-success',
                    confirmButtonText: 'OK',
                })
                var profile_name = $('._profile_info #profile_name');
                    var profile_title = $('._profile_common_info_display_name h4');
                profile_name.empty();
                profile_name.html(e.data.view);
                profile_title.empty();
                profile_title.html(e.data.value);
                typeClose = typeClose.filter(item => item !== 1)
                
            }
        }
    })
});

$(document).on('click', '._profile_info ._profile_info_body ._profile_update_form #_btn_update_username', function () { 
    $('._profile_info ._profile_info_body ._profile_update_form .error').remove();
    var name = $('._profile_info ._profile_info_body ._profile_update_form #input_name').val()
    if (!checkName(name)) {
        return 
    }

    $.ajax({
        url: urlUpdate,
        method: "POST",
        data: {
            "_token": $('meta[name="csrf-token"]').attr('content'),
            'name': name,
            'id': clientId
        }, success: function (e) {
            if (e.code == 200) {
                swal({
                    title:"Thông báo",
                    text:'Cập nhật tên người dùng thành công',
                    type:'success',
                    showCancelButton: false,
                    confirmButtonClass: 'btn btn-success',
                    confirmButtonText: 'OK',
                })
                var profile_name = $('._profile_info #profile_name');
                    var profile_title = $('._profile_common_info_display_name h4');
                profile_name.empty();
                profile_name.html(e.data.view);
                profile_title.empty();
                profile_title.html(e.data.value);
                typeClose = typeClose.filter(item => item !== 1)
                
            }
        }
    })
});

$(document).on('click', '._profile_info ._profile_info_body ._profile_update_form #_btn_update_password', function () { 
    $('._profile_info ._profile_info_body ._profile_update_form .error').remove();
    var password = $('._profile_info ._profile_info_body ._profile_update_form #old_pasword').val()
    var new_password = $('._profile_info ._profile_info_body ._profile_update_form #new_password').val();
    var confirm_new_password = $('._profile_info ._profile_info_body ._profile_update_form #confirm_new_password').val();
    
    if (!checkPassword( new_password, confirm_new_password)) {
        return 
    }

    if (checkPasswordStrength(new_password) < 5) {
        $('._profile_info ._profile_info_body ._profile_update_form #confirm_new_password').after("<div class='error'>Mật khẩu cần ít nhất: <br>* 1 kí tự viết hoa <br>* 1 kí tự viết thường <br>* 1 kí tự đặc biệt !@#$%^&* <br>* 1 số 0987654321 </div>")
        return 
    }

    $.ajax({
        url: urlUpdate,
        method: "POST",
        data: {
            "_token": $('meta[name="csrf-token"]').attr('content'),
            'old_password': password,
            'new_password': new_password,
            'confirm_new_password': confirm_new_password,
            'id': clientId
        }, success: function (e) {
            console.log(e);
            if (e.code == 200) {
                swal({
                    title:"Thông báo",
                    text:'Cập nhật mật khẩu thành công',
                    type:'success',
                    showCancelButton: false,
                    confirmButtonClass: 'btn btn-success',
                    confirmButtonText: 'OK',
                })
                var profile_password = $('._profile_info #profile_password');
                profile_password.empty();
                profile_password.html(e.data.view);
            
                typeClose = typeClose.filter(item => item !== 3)
                
            } else if (e.code == 201) {
                $('._profile_info ._profile_info_body ._profile_update_form #confirm_new_password').after(e.data.view);
            }
        }
    })
});

function checkName(value) {
    if (value.length < 0) {
        $('._profile_info ._profile_info_body ._profile_update_form #input_name').after("<div class='error'>* Tên không được bỏ trống </div>")
        return false; 
    }
    else if (/\d/.test(value)) {
        $('._profile_info ._profile_info_body ._profile_update_form #input_name').after("<div class='error'>* Tên không được chứa số </div>")
        return false; 
    }
    else if(value.length > 50) {
        $('._profile_info ._profile_info_body ._profile_update_form #input_name').after("<div class='error'>* Tên quá dài yêu cầu < 50 kí tự </div>")
        return false; 
    }
    else if(value.length < 5) {
        $('._profile_info ._profile_info_body ._profile_update_form #input_name').after("<div class='error'>* Tên quá ngắn phải có ít nhất 5 kí tự </div>")
        return false; 
    }
    else if(value == oldNameValue) {
        $('._profile_info ._profile_info_body ._profile_update_form #input_name').after("<div class='error'>* Tên thay đổi phải khác tên cũ </div>")
        return false;
    }
    return true
}   

function checkPassword(new_pasword, confirm_password ) {
    if (new_pasword.length < 8 || new_pasword.length > 50) {
        $('._profile_info ._profile_info_body ._profile_update_form #confirm_new_password').after("<div class='error'>* Mật khẩu mới phải có ít nhất 8 kí tự </div>")
        return false; 
    }
    else if (new_pasword != confirm_password) {
        $('._profile_info ._profile_info_body ._profile_update_form #confirm_new_password').after("<div class='error'>* Mật khẩu mới không khớp vui lòng xác nhận lại mật khẩu mới </div>")
        return false; 
    }
    return true;
}

function showUpdateForm(type) {
    console.log('show');
    if (typeClose.includes(type)) {
        return
    }
    typeClose.push(type);
    switch (type) {
        case 1:
            var profile_name = $('._profile_info #profile_name');
            select_val = '._profile_info #profile_name #name-' + clientId;
            var value = $(select_val).text();
            oldNameValue = value;
            user_profile_name = profile_name.children()
            profile_name.empty();
            profile_name.html(html_update_name_profile);
            $('._profile_info ._profile_info_body ._profile_update_form #input_name').val(value);
            break
        case 3:
            var profile_password = $('._profile_info #profile_password')
            user_profile_password = profile_password.children();
            profile_password.empty();
            profile_password.html(html_update_password_profile);
            break
    }
}

function closeUpdateForm(type) {
    switch (type) {
        case 1:
            var profile_name = $('._profile_info #profile_name');
            profile_name.empty();
            profile_name.html(user_profile_name);
            user_profile_name = "";
            break;
        case 3:
            var profile_password = $('._profile_info #profile_password');
            profile_password.empty();
            profile_password.html(user_profile_password);
            user_profile_password = "";
            break;
    }
}

$('._profile_common_info_feature').on('click', function (e) {
    e.preventDefault()
    $('._profile_common_info_feature').removeClass('active');
    $(this).addClass('active')

    var id = $(this).data('id');
    var url = $(this).data('url');
  
    if (id == 'notification') {
        console.log('return')
        return;
    }

    $.ajax({
        url: url,
        data: {
            "_token": $('meta[name="csrf-token"]').attr('content'),
        }, success: function(data) {
            let view = data.profileView
            var body = $('#profile_card_body').html(view);
            console.log(body)
        }
    });

})

$(function() {
   $('._profile_common_info_feature').first().trigger('click');
});