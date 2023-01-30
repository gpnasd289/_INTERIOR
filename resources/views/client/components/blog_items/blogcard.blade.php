
<div class="swiper-slide">
    <!--== Start Blog Item ==-->
    <div class="post-item">
    <div class="inner-content">
        <div class="thumb">
        <a href="{{ route('client.blog.view',['slug' => $blog -> slug]) }}">
            <img class="w-100 blog-thumb"  src="{{ $blog -> thumbnail }}" alt="Ảnh bìa">
        </a>
        </div>
        <div class="content">
        <h4 class="title">
            <a href="{{ route('client.blog.view',['slug' => $blog -> slug]) }}">{{ $blog -> title }}</a>
        </h4>
        <p>{{ $blog -> description }}</p>
        <a class="btn-link" href="{{ route('client.blog.view',['slug' => $blog -> slug]) }}">Đọc thêm</a>
        <ul class="meta-info">
            <li><span>Viết bởi - </span><a class="author" href="{{ route('client.blog.view',['slug' => $blog -> slug]) }}">{{ $blog -> authorPost -> profile -> name  }}</a></li>
            <li><span>{{ $blog -> getCreateDate() }}</span></li>
        </ul>
        </div>
    </div>
    </div>
<!--== End Blog Item ==-->
</div>