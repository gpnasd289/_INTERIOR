<div class="col-lg-3">
            <!--== Start Product Sidebar Wrapper ==-->
            <div class="product-sidebar-wrapper product-sidebar-left">
              <!--== Start Product Sidebar Item ==-->
              <div class="product-sidebar-item">
                <h4 class="product-sidebar-title">Tìm kiếm</h4>
                <div class="product-sidebar-body">
                  <div class="product-sidebar-search-form">
                    <form action="{{ route('client.product.search') }}">
                      <div class="form-group">
                        <input class="form-control" type="search" name="keyword" placeholder="Nhập vào từ khóa">
                        <button type="submit" class="btn-src">Tìm kiếm</button>
                      </div>
                    </form>
                  </div>
                </div>
              </div>
              <!--== End Product Sidebar Item ==-->

              <!--== Start Sidebar Item ==-->
              <div class="product-sidebar-item">
                <h4 class="product-sidebar-title">Loại sản phẩm</h4>
                <div class="product-sidebar-body">
                  <div class="product-sidebar-nav-menu">
                    @foreach($category as $cate) 
                    <a href="#/"> <span> {{ $cate-> name }} </span></a>
                    @endforeach
                  </div>
                </div>
              </div>
              <!--== End Sidebar Item ==-->

              <!--== Start Sidebar Item ==-->
              <div class="product-sidebar-item">
                <h4 class="product-sidebar-title">Chương trình khuyến mãi</h4>
                <div class="product-sidebar-body">
                  <!--== Start Product Item ==-->
                  <div class="product-sidebar-item">
                    <div class="thumb">
                      <a href="single-product-simple.html">
                        <img class="w-100" src="{{ asset('assets/images/sale_banner.jpg') }}" alt="Image-HasTech">
                      </a>
                    </div>
                  </div>
                  <!--== End Product Item ==-->
                </div>
              </div>
              <!--== End Sidebar Item ==-->
            </div>
            </div>