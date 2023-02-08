var password_total;
var removeError = function() { element.classList.remove('error-shake'); };
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

	this.update_info('length', password.length >= 6 && password.length <= 15);
    this.update_info('capital', capitalletters);
    this.update_info('small', loweletters);
    this.update_info('number', numbers);
    this.update_info('special', special);

	var total = characters + capitalletters + loweletters + numbers + special;
	this.password_meter(total);
    password_total = total;
    console.log(total);
    return total
}

function update_info(criterion, isValid) {
    var $passwordCriteria = $('#passwordCriterion').find('li[data-criterion="' + criterion + '"]');
    if (isValid) {
        $passwordCriteria.removeClass('invalid').addClass('valid');
    } else {
        $passwordCriteria.removeClass('valid').addClass('invalid');
    }
}

function password_meter(total) {
    var meter = $('#password-strength-status');
    meter.removeClass();
    if (total === 0) {
        meter.html('');
    } else if (total === 1) {
        meter.addClass('veryweak-password').html('Rất yếu');
    } else if (total === 2) {
        meter.addClass('weak-password').html('Yếu');
    } else if (total === 3) {
        meter.addClass('medium-password').html('Trung bình');
    } else if (total === 4) {
        meter.addClass('average-password').html('Tạm ổn');
    } else {
        meter.addClass('strong-password').html('OK');
    }
}



// ========================================== PASSWORD ===============================================
$('#password').keyup(function () {
    var passwordString = $(this).val();
    checkPasswordStrength(passwordString);
});

$('input').click(function () {
    $(this).removeClass('error-shake');
});

const togglePassword = document.querySelector("#togglePassword");
const password = document.querySelector("#password");

const togglePassword_confirm = document.querySelector("#toggleConfirmPassword");
const confirm_password = document.querySelector("#confirm_password");

togglePassword_confirm.addEventListener("click", function () {
    // toggle the type attribute
    const type = confirm_password.getAttribute("type") === "password" ? "text" : "password";
    confirm_password.setAttribute("type", type);
    
    // toggle the icon
    this.classList.toggle("fa-eye");

    this.classList.toggle("fa-eye-slash");
});

togglePassword.addEventListener("click", function () {
    // toggle the type attribute
    const type = password.getAttribute("type") === "password" ? "text" : "password";
    password.setAttribute("type", type);
    
    // toggle the icon
    this.classList.toggle("fa-eye");

    this.classList.toggle("fa-eye-slash");
});

// prevent form submit
const form = document.querySelector("form");
form.addEventListener('submit', function (e) {
    e.preventDefault();
});


// ========================================== END PASSWORD ===============================================

function validate() {
    console.log(password_total);
    if ($('#username').val() == '') {
        $('#username').addClass('error-shake');
    }

    if( $('#email').val() == '') {
        $('#email').addClass('error-shake');
    }
    
    if (password_total < 5) {
        $('#password').addClass('error-shake');
        return false;
    }

    if ($('#password').val() != $('#confirm_password').val()) {
        $('#confirm_password').addClass('error-shake');
    }


    return true;
}

