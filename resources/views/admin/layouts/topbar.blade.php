 <!-- Top Bar Start -->
 <div class="topbar">

<!-- LOGO -->
<div class="topbar-left">
    <a href="{{ route('admin.dashboard') }}" class="logo">
        <span>
            <img src=" {{ asset('admin/assets/images/logo.png') }}" alt="" height="24">
        </span>
        <i>
            <img src="{{ asset('admin/assets/images/logo-sm.png') }}" alt="" height="22">
        </i>
    </a>
</div>

<nav class="navbar-custom">

    <ul class="navbar-right d-flex list-inline float-right mb-0">
        <li class="dropdown notification-list">
            <a class="nav-link dropdown-toggle arrow-none waves-effect waves-light" data-toggle="dropdown" href="#" role="button" aria-haspopup="false" aria-expanded="false">
                <i class="mdi mdi-bell noti-icon"></i>
                <span class="badge badge-pill badge-info noti-icon-badge">3</span>
            </a>
            <div class="dropdown-menu dropdown-menu-right dropdown-menu-lg">
                <!-- item-->
                <h6 class="dropdown-item-text">
                    Notifications (37)
                </h6>
                <div class="slimscroll notification-item-list">
                    <!-- item-->
                    <a href="javascript:void(0);" class="dropdown-item notify-item active">
                        <div class="notify-icon bg-success"><i class="mdi mdi-cart-outline"></i></div>
                        <p class="notify-details">Your order is placed<span class="text-muted">Dummy text of the printing and typesetting industry.</span></p>
                    </a>
                    <!-- item-->
                    <a href="javascript:void(0);" class="dropdown-item notify-item">
                        <div class="notify-icon bg-warning"><i class="mdi mdi-message"></i></div>
                        <p class="notify-details">New Message received<span class="text-muted">You have 87 unread messages</span></p>
                    </a>
                    <!-- item-->
                    <a href="javascript:void(0);" class="dropdown-item notify-item">
                        <div class="notify-icon bg-info"><i class="mdi mdi-flag"></i></div>
                        <p class="notify-details">Your item is shipped<span class="text-muted">It is a long established fact that a reader will</span></p>
                    </a>
                    <!-- item-->
                    <a href="javascript:void(0);" class="dropdown-item notify-item">
                        <div class="notify-icon bg-primary"><i class="mdi mdi-cart-outline"></i></div>
                        <p class="notify-details">Your order is placed<span class="text-muted">Dummy text of the printing and typesetting industry.</span></p>
                    </a>
                    <!-- item-->
                    <a href="javascript:void(0);" class="dropdown-item notify-item">
                        <div class="notify-icon bg-danger"><i class="mdi mdi-message"></i></div>
                        <p class="notify-details">New Message received<span class="text-muted">You have 87 unread messages</span></p>
                    </a>
                </div>
                <!-- All-->
                <a href="javascript:void(0);" class="dropdown-item text-center text-primary">
                    View all <i class="fi-arrow-right"></i>
                </a>
            </div>        
        </li>
        <li class="dropdown notification-list">
            <div class="dropdown notification-list nav-pro-img">
                <a class="dropdown-toggle nav-link arrow-none waves-effect nav-user waves-light" data-toggle="dropdown" href="#" role="button" aria-haspopup="false" aria-expanded="false">
                    <img src="{{ asset('admin/assets/images/users/user-4.jpg') }}" alt="user" class="rounded-circle">
                </a>
                <div class="dropdown-menu dropdown-menu-right profile-dropdown ">
                    <!-- item-->
                    <a class="dropdown-item" href="#"><i class="mdi mdi-account-circle m-r-5"></i> Profile</a>
                    <a class="dropdown-item d-block" href="#"><i class="mdi mdi-settings m-r-5"></i> C??i ?????t</a>
                    <div class="dropdown-divider"></div>
                    <a class="dropdown-item text-danger" href="{{ route('admin.logout') }}"><i class="mdi mdi-power text-danger"></i> Logout</a>
                </div>                                                                    
            </div>
        </li>

    </ul>

    <ul class="list-inline menu-left mb-0">
        <li class="float-left">
            <button class="button-menu-mobile open-left waves-effect waves-light">
                <i class="mdi mdi-menu"></i>
            </button>
        </li>                        
 
    </ul>

</nav>

</div>
<!-- Top Bar End -->