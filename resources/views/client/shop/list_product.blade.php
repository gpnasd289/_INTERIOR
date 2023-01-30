    <div class="tab-pane fade show active" id="nav-grid" role="tabpanel" aria-labelledby="nav-grid-tab">
        <div class="row">
            @foreach($products as $product)
            <div class="col-md-6 col-lg-4 col-xl-3">
                @switch($product -> display_state)
                @case(1)
                <x-productnewsale :product="$product"></x-productnewsale>
                @break
                @case(2)
                <x-productnewsale :product="$product"></x-productnewsale>
                @break
                @endswitch

            </div>
            @endforeach
        </div>
        <!--== Start Pagination Wrap ==-->

        {!! $products->links('client.paginator.view') !!}

        <!--== End Pagination Wrap ==-->
    </div>
    <div class="tab-pane fade" id="nav-list" role="tabpanel" aria-labelledby="nav-list-tab">
        <div class="row">
            @foreach($products as $product)
            <div class="col-12">
                @switch($product -> display_state)
                @case(1)
                <x-product_sale_horizontal :product="$product"></x-product_sale_horizontal>
                @break
                @case(2)
                <x-product_sale_horizontal :product="$product"></x-product_sale_horizontal>
                @break
                @endswitch

            </div>
            @endforeach


        </div>
        {!! $products->links('client.paginator.view') !!}
        <!--== End Pagination Wrap ==-->