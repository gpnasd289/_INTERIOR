<!-- ========== Left Sidebar Start ========== -->
<?php
    $menu = config('menu');
?>


<div class="left side-menu">
                <div class="slimscroll-menu" id="remove-scroll">
                    <!--- Sidemenu -->
                    <div id="sidebar-menu">
                        <!-- Left Menu Start -->
                        <ul class="metismenu" id="side-menu">
                            <li class="menu-title">Main</li>
                            @foreach($menu as $item)
                            @if($item['items'])
                            <li>
                                <a href="javascript:void(0);" class="waves-effect"><i class="{{ $item['icon'] }}"></i><span> {{ $item['label'] }} <span class="float-right menu-arrow"><i class="mdi mdi-plus"></i></span> </span></a>
                                <ul class="submenu">
                                    @foreach($item['items'] as $child)
                                        <li><a href="{{ route( $child['route']) }}">{{ $child['label'] }}</a></li>
                                    @endforeach
                                </ul>
                            </li>
                            @else
                                <li>
                                    <a href="{{ route($item['route'] ) }}" class="waves-effect"><i class="{{ $item['icon'] }}"></i><span>  {{ $item['label']}} </span> </a>
                                </li>
                            @endif
                            @endforeach 
                        </ul>
                    </div>
                    <!-- Sidebar -->
                    <div class="clearfix"></div>
                </div>
                <!-- Sidebar -left -->
            </div>
            <!-- Left Sidebar End -->