<div  class="d-flex justify-content-center">
    <div class="dropdown show">
    <a class="btn btn-success" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
        ...
    </a>

    <div class="dropdown-menu" aria-labelledby="dropdownMenuLink2">
        <a class="dropdown-item func-edit" href="{{ route( $route_prefix . '.edit',['id' => $item->ID]) }}" data-id="{{ $item -> ID}}">Chỉnh sửa</a>
        <a class="dropdown-item func-detail" href="javascript:void(0)" data-id="{{ $item -> ID}}" data-url="{{ route($route_prefix.'.detail',['id' => $item -> ID ])}}">Chi tiết</a>
        <a class="dropdown-item func-delete" href="javascript:void(0)" data-id="{{ $item -> ID}}" data-url="{{ route( $route_prefix . '.delete',['id' => $item -> ID])}}">Xóa</a>
        </div>
    </div>
</div>
