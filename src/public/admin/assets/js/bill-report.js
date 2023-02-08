$('.btn-print').on('click', function () {
    $('.navigation').hide();
    window.onafterprint = function(){
        $('.navigation').show();
    }
    window.print();
   
});