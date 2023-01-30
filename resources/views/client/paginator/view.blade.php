
@if($paginator->lastPage() > 1)
<div class="row">
    <div class="col-12">
        <div class="pagination-content-wrap">
        <nav class="pagination-nav">
            <ul class="pagination justify-content-center">
            <li><a class="{{ ($paginator->currentPage() == 1) ? 'disabled' : '' }} active prev " href="{{ $paginator->url(1) }}"><i class="fa fa-angle-left"></i>Back</a></li>
            @for ($i = 1; $i <= $paginator->lastPage(); $i++)
                <li class="{{ ($paginator->currentPage() == $i) ? 'disabled' : '' }}">
                    <a href="{{ $paginator->url($i) }}"> {{ $i }}</a>
                </li>
            @endfor
            <li class="{{ ($paginator->currentPage() == $paginator->lastPage()) ? 'disabled' : '' }}">
                <li><a class="next" href="{{ $paginator->url($paginator->currentPage() + 1) }}">Next <i class="fa fa-angle-right"></i></a></li>
            </li>
           
            </ul>
        </nav>
        </div>
    </div>
</div>
@endif