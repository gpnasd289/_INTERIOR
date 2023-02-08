@extends('client.layouts.main')

@section('main-content')
    <!--== Start Page Header Area Wrapper ==-->
    <div class="page-header-area">
      <div class="container">
        <div class="row">
          <div class="col-12 text-center">
            <div class="page-header-content">
              <h4 class="title" data-aos="fade-down" data-aos-duration="1200">Sản phẩm</h4>
              <nav class="breadcrumb-area" data-aos="fade-down" data-aos-duration="1000">
                <ul class="breadcrumb">
                  <li><a href="{{ route('home') }}">Trang chủ</a></li>
                  <li class="breadcrumb-sep">-</li>
                  <li>Sản phẩm</li>
                </ul>
              </nav>
            </div>
          </div>
        </div>
      </div>
    </div>
    <!--== End Page Header Area Wrapper ==-->

     <!--== Start Product Area Wrapper ==-->
     <section class="product-area product-grid-list-area">
      <div class="container">
        <div class="row">
          <div class="col-12">
            <div class="product-header-wrap">
              <div class="grid-list-option">
                <nav>
                  <div class="nav nav-tabs" id="nav-tab" role="tablist">
                    <button class="nav-link active" id="nav-grid-tab" data-bs-toggle="tab" data-bs-target="#nav-grid" type="button" role="tab" aria-controls="nav-grid" aria-selected="true"><span data-bg-img="assets/img/icons/1.webp"></span></button>
                    <button class="nav-link" id="nav-list-tab" data-bs-toggle="tab" data-bs-target="#nav-list" type="button" role="tab" aria-controls="nav-list" aria-selected="false"><span data-bg-img="assets/img/icons/1.webp"></span></button>
                  </div>
                </nav>
              </div>
              <div class="show-product-area">
                <!-- <p class="show-product">Showing 1 - 15 of 33 result</p> -->
              </div>
              <div class="nav-short-area">
                <div class="toolbar-shorter">
                  <label for="SortBy">Sắp xếp</label>
                  <select id="sortBy" class="form-select" aria-label="Sort by">
                    <option value="manual">Xu hướng</option>
                    <option value="best-selling">Bán chạy nhất</option>
                    <option value="title-ascending" selected> Từ A-Z</option>
                    <option value="title-descending">Từ Z-A</option>
                    <option value="price-ascending">Giá, thấp tới cao</option>
                    <option value="price-descending">Giá, cao tới thấp</option>
                    <option value="created-descending">Mới đến cũ</option>
                    <option value="created-ascending">Cú đến mới</option>
                  </select>
                </div>
              </div>
            </div>
              <div class="product-body-wrap">
                <div class="tab-content" id="nav-tabContent">
                    @include('client.shop.list_product',['products' => $products])
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
    <!--== End Product Area Wrapper ==-->
    @include('client.layouts.feature-area')
@endsection