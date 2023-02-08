<?php
    return [
        [
            'label' => 'DashBoard',
            'route' => 'admin.dashboard',
            'icon'  => 'fas fa-home',
            'items' => []
        ] , 
        // =================================== EMPLOYEE ===================================
        [
            'label' => 'Quản lý nhân viên',
            'route' => '',
            'icon'  => 'mdi mdi-account',
            'items' => [
                [
                    'label' => 'Danh sách nhân viên',
                    'route' => 'admin.employee.list'
                ],
                [
                    'label' => 'Tạo mới nhân viên',
                    'route' => 'admin.employee.create'
                ]
            ]
        ] ,
        // =================================== Category ===================================
        [
            'label' => 'Quản lý loại sản phẩm',
            'route' => '',
            'icon'  => 'dripicons-checklist',
            'items' => [
                [
                    'label' => 'Danh sách loại sản phẩm',
                    'route' => 'admin.category.list'
                ],
                [
                    'label' => 'Tạo mới loại sản phẩm',
                    'route' => 'admin.category.create'
                ]
            ]
        ] , 
        // =================================== CUSTOMER ===================================
        [
            'label' => 'Quản lý khách hàng',
            'route' => '',
            'icon'  => 'fas fa-users',
            'items' => [
                [
                    'label' => 'Danh sách khách hàng',
                    'route' => 'admin.customer.list'
                ],
                [
                    'label' => 'Tạo mới khách hàng',
                    'route' => 'admin.customer.create'
                ]
            ]
        ] , 
        // =================================== BLOG ===================================
        [
            'label' => 'Quản lý bài viết',
            'route' => '',
            'icon'  => 'fas fa-pen-square',
            'items' => [
                [
                    'label' => 'Danh sách bài viết',
                    'route' => 'admin.blog.list'
                ],
                [
                    'label' => 'Tạo mới bài viết',
                    'route' => 'admin.blog.create'
                ],
                [
                    'label' => 'Thêm tag',
                    'route' => 'admin.blog.tag.create'
                ]
            ]
        ] , 
        // =================================== PRODUCT ===================================
        [
            'label' => 'Quản lý sản phẩm',
            'route' => '',
            'icon'  => 'fab fa-product-hunt',
            'items' => [
                [
                    'label' => 'Danh sách sản phẩm',
                    'route' => 'admin.product.list'
                ],
                [
                    'label' => 'Tạo mới sản phẩm',
                    'route' => 'admin.product.create'
                ]
            ]
        ] ,
        // =================================== THUMBNAIL IMAGE ===================================
        [
            'label' => 'Quản lý ảnh bìa',
            'route' => '',
            'icon'  => 'ion-android-image',
            'items' => [
                [
                    'label' => 'Danh sách ảnh',
                    'route' => 'admin.thumbnail.list'
                ],
                [
                    'label' => 'Thêm mới ảnh',
                    'route' => 'admin.thumbnail.create'
                ]
            ]
        ],
          // =================================== THUMBNAIL IMAGE ===================================
          [
            'label' => 'Đơn hàng',
            'route' => '',
            'icon'  => 'fas fa-shipping-fast',
            'items' => [
                [
                    'label' => 'Danh sách đơn hàng',
                    'route' => 'admin.bill.list'
                ]
            ]
        ]
        ,
            // =================================== PROMOTION IMAGE ===================================
            [
            'label' => 'Mã giảm giá',
            'route' => '',
            'icon'  => 'fas fa-pallet',
            'items' => [
                [
                    'label' => 'Danh sách mã giảm giá',
                    'route' => 'admin.promotion.list'
                ],
                [
                    'label' => 'Tạo mới mã giảm giá',
                    'route' => 'admin.promotion.create'
                ]
            ]
        ],// =================================== FILE MANAGER ===================================
        [
            'label' => 'Quản lý File',
            'route' => 'admin.filemanager',
            'icon'  => 'dripicons-folder-open',
            'items' => []
        ], 
    ]
?>