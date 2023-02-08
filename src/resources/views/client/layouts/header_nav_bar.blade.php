<header class="header-area header-default sticky-header">
    <div class="container">
      <div class="row align-items-center justify-content-between position-relative">
        <div class="col">
          <div class="header-logo-area">
            <a href="{{ route('home') }}">
              <img class="logo-main" src="{{ asset('assets/img/logo.png') }}" alt="Logo" />
              <img class="logo d-none" src="{{ asset('assets/img/logo-light.png') }}" alt="Logo" />
            </a>
          </div>
        </div>
        <div class="col">
          <div class="header-navigation-area">
            <ul class="main-menu nav">
              <li class="has-submenu"><a href="{{ route('home') }}"><span>Trang chủ</span></a>
              </li>
              
              <li class="has-submenu"><a href="{{ route('client.shop.view') }}"><span>Sản phẩm</span></a>
                <ul class="submenu-nav">
                  <li><a href="{{ route('client.shop.product.view', ['id' => 2 ])}}">Sản phẩm mới</a></li>
                  <li><a href="{{ route('client.shop.product.view', ['id' => 3 ])}}">Sản phẩm bán chạy</a></li>
                  <li><a href="{{ route('client.shop.product.view', ['id' => 4 ])}}">Sản phẩm mua nhiều</a></li>
                  <li><a href="{{ route('client.shop.product.view', ['id' => 5 ])}}">Sản phẩm đang giảm giá</a></li>
                </ul>
              </li>
              <li class="has-submenu"><a href="#/"><span>Danh mục</span></a>
                <ul class="submenu-nav">
                    @foreach($category as $cate) 
                      <li><a href="{{ route('client.shop.cate.view', ['id' => $cate->ID ]) }}"> {{ $cate -> name }} </a></li>
                    @endforeach
                </ul>
              </li>
              <li class="has-submenu"><a href="#/"><span>Bài viết</span></a>
                <ul class="submenu-nav">
                  <li><a href="blog.html">Tip hữu ích</a></li>
                  <li><a href="blog-right-sidebar.html">Cẩm nang dọn dẹp</a></li>
                </ul>
              </li>
              <li><a href="{{ route('client.contact.view') }}"><span>Liên hệ</span></a></li>
            </ul>
          </div>
        </div>
        <div class="col">
          <div class="header-action-area">
            <ul class="header-action">
              <li class="user-menu">
                @if(Auth::guard('client')->user())
                <a class="title" href="javascript:;"><span class="user-profile"> Hello, {{ Auth::guard('client')->user() -> profile -> getName()}} </span> <i class="fa fa-user-circle"></i></a>
      
                @else
                <a class="title" href="javascript:;"><i class="fa fa-user-o"></i></a>
                @endif
                <ul class="user-dropdown">
                  <li class="user h-100">
                    @if(Auth::guard('client')->user())
                    <ul>
                      <li><a href="{{ route('client.customer.profile', ['id' => Auth::guard('client')->id() ]) }}">Thông tin tài khoản</a></li>
                      <li><a href="{{ route('client.customer.logout') }}">Đăng xuất</a></li>
                    </ul>
                    @else 
                    <ul>
                      <li><a href="{{ route('client.customer.login') }}">Đăng nhập</a></li>
                      <li><a href="{{ route('client.customer.register') }}">Đăng ký</a></li>
                    </ul>
                    @endif
                  </li>
                </ul>
              </li>
            </ul>
            <div class="header-action">
              <div class="header-search">
                <button class="search-toggle">
                  <i class="search-icon bardy bardy-search"></i>
                  <i class="close-icon bardy bardy-cancel"></i>
                </button>
                <div class="header-search-form">
                  <form action="{{ route('client.product.search') }}" method="GET">
                    @csrf
                    <input type="search" placeholder="Tìm kiếm trên cửa hàng" name="keyword">
                    <button type="submit"><i class="bardy bardy-search"></i></button>
                  </form>
                </div>
              </div>
            </div>
            <div class="header-action">
              <div class="header-mini-cart">
                <button class="mini-cart-toggle">
                  <i class="icon bardy bardy-shopping-cart"></i>
                  <span class="number" id="mini-cart-count">{{ Cart::instance('shopping') -> content() ->count() }}</span>
                </button>
                <div class="mini-cart-dropdown" id="mini-cart-dropdown">
                  @include('client.layouts.minicart')
                </div>
              
              </div>
            </div>
            <div class="header-action d-block d-lg-none text-end">
              <button class="btn-menu" type="button"><i class="zmdi zmdi-menu"></i></button>
            </div>
          </div>
        </div>
      </div>
    </div>
  </header>
  <!--== End Header Wrapper ==-->