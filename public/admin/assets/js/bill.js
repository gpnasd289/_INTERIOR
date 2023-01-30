$('.bill-link').on('click', function() {

    var url = $(this).data('url');
  
  
    var billdetail = $('#bill-detail')
    $.ajax({
        url: url,
        method: "GET",
        data: {
            "_token": $('meta[name="csrf-token"]').attr('content'),
        }, success: function (response) {
            console.log(response);
           
            if (response.code == 200) {
                billdetail.empty();
                html = ""
                const obj = JSON.parse(response.data.products);
                obj.forEach(element => {
                    var productrow = `<tr>
                    <td>` + element.product_id                  + `</td>
                    <td>` + element.product.name        + `</td>
                    <td>` + element.quantity                    + `</td>
                    <td>` + element.price.toLocaleString('it-IT', {style : 'currency', currency : 'VND'});   + `</td>
                </tr>`
                html += productrow
                
                console.log(productrow);
                })
                billdetail.html(html);
                console.log(printURL);
             
                $('#modaltable').DataTable();
                $('#select-product-modal').modal('show');
            }
        }
    })
    
})

$('.func-detail').on('click', function() {

    var url = $(this).data('url');
    var id  = $(this).data('id');
    var printURL = "http://127.0.0.1:8000/admin/pdf/" + id
    var billdetail = $('#bill-detail')
    $.ajax({
        url: url,
        method: "GET",
        data: {
            "_token": $('meta[name="csrf-token"]').attr('content'),
        }, success: function (response) {
            if (response.code == 200) {
                billdetail.empty();
                html = ""
                const obj = JSON.parse(response.data.products);
                obj.forEach(element => {
                    var productrow = `<tr>
                    <td>` + element.product_id                  + `</td>
                    <td>` + element.product.name        + `</td>
                    <td>` + element.quantity                    + `</td>
                    <td>` + element.price.toLocaleString('it-IT', {style : 'currency', currency : 'VND'});   + `</td>
                </tr>`
                html += productrow
                })
                billdetail.html(html);
                $('#print').attr('href', printURL)
                $('#modaltable').DataTable();
                $('#select-product-modal').modal('show');
            }
        }
    })
    
})