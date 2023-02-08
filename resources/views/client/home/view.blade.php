@extends('client.layouts.main')
@section('main-content')
    @include('client.home.slider')
    @include('client.home.product_list')
    @include('client.home.single_banner')
    @include('client.home.new-arrival-area')
    @include('client.home.get-discount-area')
    @include('client.home.blog-area')
    @include('client.layouts.feature-area')
    @include('client.home.modal_sale')
</div>
@endsection

@section('script')
    <script> 
        // $(window).load(function(){
        //     setTimeout(function(){
        //         $('#exampleModal').modal('show');
        //     }, 2000);
        // });
    </script>
@endsection
