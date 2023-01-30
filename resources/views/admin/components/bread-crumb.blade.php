<div class="row">
    <div class="col-sm-12">
        <div class="page-title-box">
            <h4 class="page-title">{{ $attributes['title'] }}</h4>
            <ol class="breadcrumb">
                @for($i = 0 ; $i < 1 ; $i ++ )
                    @if($i == 2 - 1) 
                        <li class="breadcrumb-item active"><a href="javascript:void(0);"> {{ $listtitle[$i] }}</a></li>
                    @else 
                    <li class="breadcrumb-item"><a href="javascript:void(0);">{{ $listtitle[$i] }}</a></li>
                    @endif
                @endfor
            </ol>
        </div>
    </div>
</div>