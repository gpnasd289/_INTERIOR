<?php

use App\Http\Controllers\AdminDashboardController;
use App\Http\Controllers\BillController;
use App\Http\Controllers\BlogController;
use App\Http\Controllers\CartController;
use App\Http\Controllers\CategoryController;
use App\Http\Controllers\CustomerController;
use App\Http\Controllers\EmployeeController;
use App\Http\Controllers\FaceBookController;
use App\Http\Controllers\FileController;
use App\Http\Controllers\GoogleController;
use App\Http\Controllers\HomeController;
use App\Http\Controllers\ProductController;
use App\Http\Controllers\PromotionController;
use App\Http\Controllers\ShopController;
use App\Http\Controllers\ThumbnailImageController;
use App\Http\Controllers\PayPalController;
use App\Models\Blog;
use App\Models\Employee;
use App\Models\Product;
use App\Models\Promotion;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/
Route::group([], function() {
    Route::get('/',[HomeController::class,'index']) -> name('home');
    Route::get('/contact',[HomeController::class,'contact']) -> name('client.contact.view');
    //Facebook Login URL
    Route::prefix('facebook')->name('facebook.')->group( function(){
        Route::get('auth', [FaceBookController::class, 'loginUsingFacebook'])->name('login');
        Route::get('callback', [FaceBookController::class, 'callbackFromFacebook'])->name('callback');
    });
    // Google Login URL
    Route::prefix('google')->name('google.')->group( function(){
        Route::get('auth/google', [GoogleController::class, 'redirectToGoogle'])->name('login');
        Route::get('auth/google/callback', [GoogleController::class, 'handleGoogleCallback'])->name('callback');
    });

    //============================================= ACCOUNT =============================================
    Route::get('/verify-account/{id}',[CustomerController::class,'verify_account']) -> name('client.customer.verify_account');
    Route::get('/resend-verify-account/{id}',[CustomerController::class,'resent_verify_account']) -> name('client.customer.resend_verify');
    //============================================= PRODUCT =============================================
    Route::get('/p/{id}',[ProductController::class,'product_detail']) -> name('client.product.detail');

    //============================================= CART =============================================
    Route::post('/cart/add',[CartController::class,'add']) -> name('client.cart.add');
    Route::post('/cart/delete',[CartController::class,'delete']) -> name('client.cart.delete');
    Route::get('/cart',[CartController::class,'index']) -> name('client.cart.index');
    Route::post('/cart/clear',[CartController::class,'clearCart']) -> name('client.cart.clear');
    Route::post('/cart/update',[CartController::class,'update']) -> name('client.cart.update');
    //============================================= CUSTOMER =============================================

    Route::get('/c/login',[CustomerController::class,'login']) -> name('client.customer.login');
    Route::get('/c/clogin',[CustomerController::class,'handlelogin']) -> name('client.customer.clogin');
    Route::get('/c/register',[CustomerController::class,'register']) -> name('client.customer.register');
    Route::post('/c/cregister',[CustomerController::class,'handle_register']) -> name('client.customer.cregister');
    //============================================= SHOP =============================================
    Route::get('/shop',[ShopController::class,'index']) -> name('client.shop.view');
    Route::get('/shop/category/{id}',[ShopController::class,'shopWithCategory']) -> name('client.shop.cate.view');
    Route::get('/shop/product-type/{id}',[ShopController::class,'shopWithProductDisplayType']) -> name('client.shop.product.view');
    Route::get('/search',[HomeController::class,'search']) -> name('client.product.search');
    Route::get('/posts/show/{slug}',[HomeController::class,'showBlog']) -> name('client.blog.view');
    Route::get('/c/pdf/{id}', [BillController::class, 'clientPDF']) -> name('client.bill.pdf');
    Route::group(['middleware' => 'auth.client'],function () {

        Route::get('/c/verify-account/{id}',[CustomerController::class,'verify']) -> name('client.customer.verify');
        Route::get('/c/logout',[CustomerController::class,'logout']) -> name('client.customer.logout');

        Route::group(['middleware'=> ['auth.client.verify_account','auth.client.bill']], function () {
            Route::get('/checkout',[ShopController::class,'checkout'])  -> name('client.checkout.view');
            Route::post('/checkout/promotion',[PromotionController::class,'apply_promotion']) -> name('client.promotion.apply');
            Route::post('/bill/checkout',[BillController::class,'process_checkout']) -> name('client.bill.checkout');
            Route::post('/bill/user/cancel',[BillController::class,'updateCancelBill']) -> name('client.bill.cancel');
        });
        
        Route::group(['middleware' => ['auth.client.verify_account']], function () {
            Route::get('/c/profile-info/{id}',[CustomerController::class,'customerInfo']) -> name('client.profile.profile-info');
            Route::get('/c/profile/{id}',[CustomerController::class,'profile']) -> name('client.customer.profile');
            Route::post('/c/update/profile',[CustomerController::class,'update_profile']) -> name('client.profile.update');
            Route::get('/c/orders/{id}',[CustomerController::class,'customerOrders']) -> name('client.profile.orders');


            Route::get('create-transaction', [PayPalController::class, 'createTransaction'])->name('createTransaction');
            Route::get('process-transaction', [PayPalController::class, 'processTransaction'])->name('processTransaction');
            Route::get('success-transaction', [PayPalController::class, 'successTransaction'])->name('successTransaction');
            Route::get('cancel-transaction', [PayPalController::class, 'cancelTransaction'])->name('cancelTransaction');
        });
    });

});


Route::prefix('admin')->group(function () {
    //============================================= GENERAL ADMIN ROUTE =============================================
    Route::get('login',[EmployeeController::class,'login']) -> name('admin.login');
    Route::post('syslogin',[EmployeeController::class,'handlelogin']) -> name('admin.sys.login');
    Route::get('logout',[EmployeeController::class,'logout']) -> name('admin.logout');

    //============================================ ADMIN AUTH ROUTE ================================================
    Route::group(['middleware'=> 'auth.admin'],function() {
        Route::get('dashboard',[ AdminDashboardController::class,'dashboard']) -> name('admin.dashboard');
        Route::get('adminfilemanager', [FileController::class,'index']) -> name('admin.filemanager');
        Route::group(['prefix' => 'laravel-filemanager'], function () {
            \UniSharp\LaravelFilemanager\Lfm::routes();
        });
        //============================================= EMPLOYEE ROUTE =============================================
        Route::prefix('employee')->group(function() {
            Route::get('list', [EmployeeController::class, 'listemployee']) -> name('admin.employee.list');
            Route::get('create', [EmployeeController::class, 'create']) -> name('admin.employee.create');
            Route::post('store', [EmployeeController::class, 'store']) -> name('admin.employee.store');
            Route::get('edit/{id}', [EmployeeController::class, 'edit']) -> name('admin.employee.edit');
            Route::post('update', [EmployeeController::class, 'update']) -> name('admin.employee.update');
            Route::post('delete/{id}', [EmployeeController::class, 'deleleEm']) -> name('admin.employee.delete');
            Route::get('detail/{id}', [EmployeeController::class, 'detail']) -> name('admin.employee.detail');
        });

        //============================================= CATEGORY ROUTE =============================================
        Route::prefix('category')->group(function() {
            Route::get('list', [CategoryController::class, 'index']) -> name('admin.category.list');
            Route::get('create', [CategoryController::class, 'create']) -> name('admin.category.create');
            Route::post('store', [CategoryController::class, 'store']) -> name('admin.category.store');
            Route::get('edit/{id}', [CategoryController::class, 'edit']) -> name('admin.category.edit');
            Route::post('update', [CategoryController::class, 'update']) -> name('admin.category.update');
            Route::post('delete/{id}', [CategoryController::class, 'delete']) -> name('admin.category.delete');
            Route::get('detail/{id}', [CategoryController::class, 'detail']) -> name('admin.category.detail');
        });

        //============================================= BLOG ROUTE =============================================
        Route::prefix('blog')->group(function() {
            Route::get('list', [BlogController::class, 'index']) -> name('admin.blog.list');
            Route::get('create', [BlogController::class, 'create']) -> name('admin.blog.create');
            Route::post('store', [BlogController::class, 'store']) -> name('admin.blog.store');
            Route::get('edit/{id}', [BlogController::class, 'edit']) -> name('admin.blog.edit');
            Route::post('update', [BlogController::class, 'update']) -> name('admin.blog.update');
            Route::post('delete/{id}', [BlogController::class, 'delele']) -> name('admin.blog.delete');
            Route::get('tag/create',[BlogController::class,'create_tag']) -> name('admin.blog.tag.create');
            Route::post('tag/store',[BlogController::class,'store_tag']) -> name('admin.blog.tag.store');
            Route::get('detail',[BlogController::class,'detail']) -> name('admin.blog.detail');
        });

        //============================================= PRODUCT ROUTE =============================================
        Route::prefix('product')->group(function() {
            Route::get('list', [ProductController::class, 'index']) -> name('admin.product.list');
            Route::get('create', [ProductController::class, 'create']) -> name('admin.product.create');
            Route::post('store', [ProductController::class, 'store']) -> name('admin.product.store');
            Route::get('edit/{id}', [ProductController::class, 'edit']) -> name('admin.product.edit');
            Route::post('update', [ProductController::class, 'update']) -> name('admin.product.update');
            Route::post('delete/{id}', [ProductController::class, 'delete']) -> name('admin.product.delete');
            Route::get('detail', [ProductController::class, 'detail']) -> name('admin.product.detail');
        });

        // =============================================  CUSTOMER ROUTE =============================================
        Route::prefix('customer')->group(function() {
            Route::get('list', [CustomerController::class, 'index']) -> name('admin.customer.list');
            Route::get('create', [CustomerController::class, 'create']) -> name('admin.customer.create');
            Route::post('store', [CustomerController::class, 'store']) -> name('admin.customer.store');
            Route::get('edit/{id}', [CustomerController::class, 'edit']) -> name('admin.customer.edit');
            Route::post('update', [CustomerController::class, 'update']) -> name('admin.customer.update');
            Route::post('delete/{id}', [CustomerController::class, 'deleteCus']) -> name('admin.customer.delete');
            Route::get('detail', [CustomerController::class, 'detail']) -> name('admin.customer.detail');
        });

        // =============================================  THUMBNAIL IMAGE ROUTE =============================================
        Route::prefix('thumbnail')->group(function() {
            Route::get('list', [ThumbnailImageController::class, 'index']) -> name('admin.thumbnail.list');
            Route::get('create', [ThumbnailImageController::class, 'create']) -> name('admin.thumbnail.create');
            Route::post('store', [ThumbnailImageController::class, 'store']) -> name('admin.thumbnail.store');
            Route::get('edit/{id}', [ThumbnailImageController::class, 'edit']) -> name('admin.thumbnail.edit');
            Route::post('update', [ThumbnailImageController::class, 'update']) -> name('admin.thumbnail.update');
            Route::post('delete/{id}', [ThumbnailImageController::class, 'delete']) -> name('admin.thumbnail.delete');
            Route::get('detail', [ThumbnailImageController::class, 'detail']) -> name('admin.thumbnail.detail');
        });

        // =============================================  PROMOTION IMAGE ROUTE =============================================
        Route::prefix('promotion')->group(function() {
            Route::get('list', [PromotionController::class, 'index']) -> name('admin.promotion.list');
            Route::get('create', [PromotionController::class, 'create']) -> name('admin.promotion.create');
            Route::post('store', [PromotionController::class, 'store']) -> name('admin.promotion.store');
            Route::get('edit/{id}', [PromotionController::class, 'edit']) -> name('admin.promotion.edit');
            Route::post('update', [PromotionController::class, 'update']) -> name('admin.promotion.update');
            Route::get('detail', [PromotionController::class, 'update']) -> name('admin.promotion.detail');
            Route::post('delete/{id}', [PromotionController::class, 'delete']) -> name('admin.promotion.delete');
        });

        // =============================================  BILL IMAGE ROUTE =============================================
        Route::prefix('bill')->group(function() {
            Route::get('list', [BillController::class, 'index']) -> name('admin.bill.list');
            Route::get('detail/{id}', [BillController::class, 'detail']) -> name('admin.bill.detail');
            Route::get('create', [BillController::class, 'create']) -> name('admin.bill.create');
            Route::post('store', [BillController::class, 'store']) -> name('admin.bill.store');
            Route::get('edit/{id}', [BillController::class, 'edit']) -> name('admin.bill.edit');
            Route::post('update', [BillController::class, 'update']) -> name('admin.bill.update');
            Route::post('delete/{id}', [BillController::class, 'delete']) -> name('admin.bill.delete');
            Route::get('download', [BillController::class, 'download_pdf']) -> name('admin.bill.download');
        });
        Route::get('pdf/{id}', [BillController::class, 'pdf']) -> name('admin.bill.pdf');
    });

});
