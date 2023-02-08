$(function () {    
    $('#title').css("text-transform","uppercase");
    // $("input#title").on({
    //     keydown: function(e) {
    //       if (e.which === 32)
    //         return false;
    //     },
    //     change: function() {
    //       this.value = this.value.replace(/\s/g, "");
    //     }
    // });


    $('.lowest-total-bill').hide();
    $('.minimum-money-discount').hide();
    $('.minimum-product').hide();
    $('#promotion_product_apply_value').hide();
    $('#promotion_category_apply_value').hide();

    $('.promotion_condition').click(function () {
        var val = $(this).val();
        if (val == 1) {
            $('.lowest-total-bill').show(500);
            $('.minimum-money-discount').hide(500);
            $('.minimum-money-discount').val('');
            $('.minimum-product').hide(500);
            $('.minimum-product').val('');
        } else if (val == 2) {
            $('.lowest-total-bill').hide(500);
            $('.lowest-total-bill').val('');
            $('.minimum-money-discount').show(500);
            $('.minimum-product').hide(500);
            $('.minimum-product').val('');
        }else if (val == 3) {
            $('.lowest-total-bill').hide(500);
            $('.lowest-total-bill').val('');
            $('.minimum-money-discount').hide(500);
            $('.minimum-money-discount').val('');
            $('.minimum-product').show(500);
        } else {
            $('.lowest-total-bill').hide(500);
            $('.lowest-total-bill').val('');
            $('.minimum-money-discount').hide(500);
            $('.minimum-money-discount').val('');
            $('.minimum-product').hide(500);
            $('.minimum-product').val('');
        }

    });


    $('#modal-product-apply-btn').click(function () {
        var checkedVals = $('input:checkbox:checked').map(function() {
            $(this).prop('checked', !$(this).prop("checked"));
            return $(this).data('id');
        }).get();
        $('input[name="promotion_product_apply_value"]').val("");
        $('input[name="promotion_category_apply_value"]').val("");
        $('input[name="promotion_product_apply_value"]').val(checkedVals.join(","));

    });

    $('#modal-category-apply-btn').click(function () {
        var checkedVals = $('input:checkbox:checked').map(function() {
            $(this).prop('checked', !$(this).prop("checked"));
            return $(this).data('id');
        }).get();
        $('input[name="promotion_product_apply_value"]').val("");
        $('input[name="promotion_category_apply_value"]').val("");
        $('input[name="promotion_category_apply_value"]').val(checkedVals.join(","));   
    });

    $('input[name="promotion_apply"]').change(function() {
        if($(this).is(':checked') && $(this).val() == '3') {
            console.log('show data table');
            $('#modaltable').DataTable();
            $('#select-product-modal').modal('show');
            $('#promotion_product_apply_value').show(500);
            $('#promotion_category_apply_value').hide(500);
            $('input[name="promotion_category_apply_value"]').val("");
            $('input[name="promotion_product_apply_value"]').val("");
        } else if($(this).is(':checked') && $(this).val() == '2') {
            console.log('show data table');
            $('#modaltablecategory').DataTable();
            $('#select-category-modal').modal('show');
            $('#promotion_product_apply_value').hide(500);
            $('#promotion_category_apply_value').show(500);
            $('input[name="promotion_product_apply_value"]').val("");
            $('input[name="promotion_category_apply_value"]').val("");
        } else {
            $('#promotion_product_apply_value').hide(500);
            $('#promotion_category_apply_value').hide(500);
        }
    });
});
