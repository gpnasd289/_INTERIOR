$(".add-cart").on("click", function () {
    var id = $(this).data("id");
    var url = $(this).data("url");
    addToCart(id, 1, url);
});

$(".btn-cart").on("click", function () {
    var id = $(this).data("id");
    var url = $(this).data("url");
    var quantity = $("#quantity").val();
    addToCart(id, quantity, url);
});

function addToCart(id, qty, url) {
    var quantity = qty;
    if (qty == null || qty < 0) {
        quantity = 1;
    }

    $.ajax({
        url: url,
        method: "POST",
        data: {
            _token: $('meta[name="csrf-token"]').attr("content"),
            id: id,
            qty: quantity,
        },
        success: function (e) {
            if (e.code != 200) {
                swal({
                    title: "Thông báo",
                    text: e.data.message,
                    type: "warning",
                    showCancelButton: false,
                    confirmButtonClass: "btn btn-success",
                    confirmButtonText: "OK",
                });
            } else {
                swal({
                    title: "Thông báo",
                    text: "Thêm sản phẩm vào giỏ hàng thành công",
                    type: "success",
                    showCancelButton: false,
                    confirmButtonClass: "btn btn-success",
                    confirmButtonText: "OK",
                });
                update(e);
            }
        },
        error: function (e) {
            console.log(e);
        },
    });
}

function removeFromCart(rowId, url) {
    $.ajax({
        url: url,
        method: "POST",
        data: {
            _token: $('meta[name="csrf-token"]').attr("content"),
            id: rowId,
        },
        success: function (e) {
            if (e.data.message == "delete_successs") {
                var id = "#" + rowId;
                $(id).remove();
                $(id).remove();
            } else {
                $(".cart-item-row").remove();
            }
            showDeleteMessage();
            update(e);
        },
        error: function (e) {
            console.log(e);
        },
    });
}

function update(cart) {
    $("h4 .total").empty();
    $("h4 .total").html(cart.data.total);

    $("#mini-cart-count").empty();
    $("#mini-cart-count").html(cart.data.count);

    $("#mini-cart-dropdown").empty();
    $("#mini-cart-dropdown").html(cart.data.minicart_view);
}

function showDeleteMessage() {
    swal({
        title: "Thông báo",
        text: "Xóa thành công",
        type: "success",
        showCancelButton: false,
        confirmButtonClass: "btn btn-success",
        confirmButtonText: "OK",
    });
}

$("#clear-cart").on("click", function () {
    swal({
        title: "Xóa toàn bộ sản phẩm khỏi giỏ hàng",
        text: "Bạn sẽ không hoàn tác lại thao tác này",
        type: "warning",
        showCancelButton: true,
        confirmButtonClass: "btn btn-success",
        cancelButtonClass: "btn btn-danger m-l-10",
        confirmButtonText: "Tôi hiểu hãy xóa nó đi",
        cancelButtonText: "Hủy",
    }).then((result) => {
        if (result) {
            var id = $(this).data("id");
            var url = $(this).data("url");
            removeFromCart(id, url);
        }
    });
});

$(".remove").on("click", function () {
    swal({
        title: "Xóa sản phẩm này khỏi giỏ hàng",
        text: "Bạn sẽ không hoàn tác lại thao tác này",
        type: "warning",
        showCancelButton: true,
        confirmButtonClass: "btn btn-success",
        cancelButtonClass: "btn btn-danger m-l-10",
        confirmButtonText: "Tôi hiểu hãy xóa nó đi",
        cancelButtonText: "Hủy",
    }).then((result) => {
        if (result) {
            var id = $(this).data("id");
            var url = $(this).data("url");
            removeFromCart(id, url);
        }
    });
});

$("#update-cart").on("click", function () {
    var url = $(this).data("url");
    $(".pro-qty input").each(function () {
        var rowId = $(this).data("id");
        var qty = $(this).val();
        var price = $(this).data("price");
        $.ajax({
            url: url,
            method: "POST",
            data: {
                rowId: rowId,
                _token: $('meta[name="csrf-token"]').attr("content"),
                qty: qty,
                price: price,
            },
            success: function (e) {
                $("#subamount-" + rowId).html(e.data.price);
            },
            error: function (e) {
                console.log(e);
            },
        });
    });
});
