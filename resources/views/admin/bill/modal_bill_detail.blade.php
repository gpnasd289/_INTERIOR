<div class="modal fade" id="select-product-modal" tabindex="-1" role="dialog" aria-labelledby="select modal" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
        <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLabel">Danh sách sản phẩm</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
            </button>
        </div>
        <div class="d-flex flex-row-reverse align-items-center btn-wrap " >
            <a id="print" href="" class="btn btn btn-primary text-white" style="margin-right:20px; margin-top:8px"><i class="fa fa-print"></i></a>
        </div>
        <div class="modal-body" class="width:auto;">
            <table id="modaltable" class="table table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Tên sản phẩm</th>
                    <th>Số lượng</th>
                    <th>Giá bán</th>
                </tr>
                </thead>
                <tbody id="bill-detail">
                           
                </tbody>
            </table>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-dismiss="modal">Đóng</button>
        </div>
        </div>
    </div>
</div>
