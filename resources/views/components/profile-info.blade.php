<div class="_profile_info">
    <div class="_profile_info_head">
        <div class="_profile_information">
            <i class=" {{ $icon }}"></i>
            {{ $title }}
        </div>
    
        <div class="_profile_setting_edit_option" data-id="{{ $customerid }}" data-url="{{ $url }}" data-type="{{ $type }}">
            <i class="fa fa-pencil"></i>
        </div>
    </div>
    <div class="_profile_info_body" id="{{ $attributes['id'] }}">
       {{ $slot }}
    </div>
</div>