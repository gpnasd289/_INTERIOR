$('.form-control').click(function() {
    $('.error').remove();
});

$('.func-delete').click(function() {
    swal({
        title: 'Bạn chắc chứ',
        text: "Bạn sẽ không thể hoàn tác lại thao tác",
        type: 'warning',
        showCancelButton: true,
        confirmButtonClass: 'btn btn-success',
        cancelButtonClass: 'btn btn-danger m-l-10',
        confirmButtonText: 'Vâng tôi hiểu xóa nó đi!'
    }).then((result) => {
        if (result) {
            deleteRow($(this).data('id'),$(this).data('url'))
        }
    })
});

function deleteRow(id , url) {
    console.log(id,url);
    $.ajax({
        url: url,
        method: "post",
        headers: {'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')},
        data: { "id": id ,
                "_token": $('meta[name="csrf-token"]').attr('content'),
        },
        success: function(e) {
            $('#r-' + id).remove();
            swal(
                'Đã xóa',
                'Xóa item thành công',
                'Success'
            )
        }
    });
}

$(function () {
    $('select').selectpicker();
});
