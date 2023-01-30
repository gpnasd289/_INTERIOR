<!-- == Start Page Header Area Wrapper ==-->
<div class="page-header-area">
    <div class="container">
    <div class="row">
        <div class="col-12 text-center">
        <div class="page-header-content">
            <h4 class="title" data-aos="fade-down" data-aos-duration="1200">{{ $product -> name}}</h4>
            <nav class="breadcrumb-area" data-aos="fade-down" data-aos-duration="1000">
            <ul class="breadcrumb">
                <li><a href="{{ route('home') }}">Home</a></li>
                <li class="breadcrumb-sep">-</li>
                <li>{{ $product -> name }}</li>
            </ul>
            </nav>
        </div>
        </div>
    </div>
    </div>
</div>
<!--== End Page Header Area Wrapper == -->