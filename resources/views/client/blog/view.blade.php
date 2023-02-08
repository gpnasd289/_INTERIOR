@extends('client.layouts.main')
@section('main-content')
    <!--== Start Page Header Area Wrapper ==-->
    <div class="page-header-area">
        <div class="container">
            <div class="row"> 
                <div class="col-12 text-center">
                    <div class="page-header-content">
                        <h4 class="title" data-aos="fade-down" data-aos-duration="1200">{{ $blog -> title }}</h4>
                        <nav class="breadcrumb-area" data-aos="fade-down" data-aos-duration="1000">
                        <ul class="breadcrumb">
                            <li><a href="{{ route('home') }}">Home</a></li>
                            <li class="breadcrumb-sep">-</li>
                            <li><a href="{{ route('client.blog.view',['slug' => $blog -> slug]) }}">{{ $blog -> title }}</a></li>
                        </ul>
                        </nav>
                    </div>
                </div>
            </div>
        </div>
    </div>
<!--== End Page Header Area Wrapper ==-->
    <section class="blog-details-area">
        <div class="container">
            <div class="row flex-row-reverse">
            <div class="col-lg-8">
                <div class="blog-details-content-wrap">
                <div class="thumb">
                    <img src="{{ $blog -> thumbnail }}" alt="Ảnh bìa blog">
                </div>
                <div class="content">
                    <h3 class="title">{{ $blog -> title }}</h3>
                    <ul class="meta">
                    <li> By - <a href="#">{{ $blog -> authorPost -> profile -> getName()  }}</a></li>
                    <li class="post-separator"> | </li>
                    <li>{{ $blog -> getCreateDate() }}</li>
                    </ul>
                    <article>
                        {!! $blog -> content !!}
                    </article>
                   
                </div>
                <div class="blog-details-footer">
                    <div class="social-sharing">
                    <ul class="social-icon">
                        <span>Chia sẻ:</span>
                        <li><a href="#/">Facebook,</a></li>
                        <li><a href="#/">Twitter,</a></li>
                        <li><a href="#/">Pinterest,</a></li>
                        <li><a href="#/">Google+</a></li>
                    </ul>
                    </div>
                    <div class="article-next-previous">
                        @if($previousPost)
                            <a class="previous" href="{{ route('client.blog.view',['slug' => $previousPost -> slug]) }}"><i class="fa fa-long-arrow-left"></i>Bài viết trước</a>
                        @else 
                            <a class="previous" href=""><i class="fa fa-long-arrow-left"></i>Bài viết trước</a>
                        @endif
                        
                        @if($nextPost)
                            <a class="next" href="{{ route('client.blog.view',['slug' => $nextPost -> slug]) }}"><i class="fa fa-long-arrow-right"></i></a>
                        @else 
                            <a class="next" href="">Bài viết tiếp theo<i class="fa fa-long-arrow-right"></i></a>
                        @endif
                    </div>
                </div>
                </div>
            </div>
            <div class="col-lg-4">
                <!--== Start Sidebar Wrapper ==-->
                <div class="sidebar-wrapper">
                <!--== Start Sidebar Item ==-->
                <div class="sidebar-item sidebar-recent-post-item">
                    <h4 class="sidebar-title">Bài viết gần đây</h4>
                    <div class="sidebar-body">
                    <div class="sidebar-post-item">
                        @foreach($recentPost as $post) 
                            <div class="post-item">
                            <div class="thumb">
                                <a href="{{ route('client.blog.view',['slug' => $post -> slug]) }}"><img src="{{ $post -> thumbnail }}" alt="Image-HasTech"></a>
                            </div>
                            <div class="content">
                                <h4 class="title"><a href="{{ route('client.blog.view',['slug' => $post -> slug]) }}">{{ $post -> title }}</a></h4>
                                <p>{{ $post -> description }}</p>
                            </div>
                            </div>
                        @endforeach
                        @if(!isset($recentPost)) 
                            <p>Hiện chưa có bài viết nào</p>
                        @endif
                    </div>
                    </div>
                </div>
                <!--== End Sidebar Item ==-->

                <!--== Start Sidebar Item ==-->
                <div class="sidebar-item">
                    <h4 class="sidebar-title">Archive</h4>
                    <div class="sidebar-body">
                    <div class="category-sub-menu pt-1">
                        <span class="title">February 2019</span>
                        <ul>
                            <li><a href="#/">Standard dummy text ever since</a></li>
                            <li><a href="#/">Make a type specimen book</a></li>
                            <li><a href="#/">Lorem Ipsum is simply dummy</a></li>
                            <li><a href="#/">It is a long established</a></li>
                            <li><a href="#/">Sed quia non numquam</a></li>
                            <li><a href="#/">Ratione voluptatem sequi nesciunt</a></li>
                            <li><a href="#/">Sit aspernatur aut odit</a></li>
                        </ul>
                        <span class="title">January 2019</span>
                        <ul>
                        <li><a href="#/">Guis nostrum Nemo enim ipsam</a></li>
                        <li><a href="#/">Neque porro quisquam est</a></li>
                        <li><a href="#/">Qui dolorem ipsum quia</a></li>
                        </ul>
                    </div>
                    </div>
                </div>
                <!--== End Sidebar Item ==-->

                <!--== Start Sidebar Item ==-->
               
                <!--== End Sidebar Item ==-->
                </div>
                <!--== End Sidebar Wrapper ==-->
            </div>
            </div>
        </div>
        </section>
        <!--== End Blog Details Area Wrapper ==-->
        @include('client.layouts.feature-area')
@endsection
