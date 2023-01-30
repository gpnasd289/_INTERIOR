<div class="col-xl-3 col-md-6">
    <div class="card bg-primary mini-stat position-relative">
        <div class="card-body">
            <div class="mini-stat-desc">
                <h6 class="text-uppercase verti-label text-white-50"></h6>
                <div class="text-white">
                    <h6 class="text-uppercase mt-0 text-white">{{ $attributes['title'] }}</h6>
                    <h3 class="mb-3 mt-0" id="{{ $attributes['id'] }}">{{ $data }}</h3>
                </div>
                <div class="mini-stat-icon">
                    <i class="mdi {{ $attributes['icon'] }} display-2"></i>
                </div>
            </div>
        </div>
    </div>
</div>