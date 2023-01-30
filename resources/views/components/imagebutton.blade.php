<div class="form-group">
    <label for="content" class="control-label" required>{{ $attributes['title'] }}</label>
</div>
<div class="input-group">            
    <span class="input-group-btn">
        <a style="margin-right: 5px;" id="file_{{ $attributes['id'] }}" data-input="thumbnail_{{ $attributes['id'] }}" data-preview="holder_{{ $attributes['id'] }}" class="btn btn-primary">
            <i class="fa fa-picture-o" ></i> Choose {{ $attributes['src'] }}
        </a>
    </span>
    @if ($attributes['src'] != '') 
        <input id="thumbnail_{{ $attributes['id'] }}" class="form-control" type="text" name="file_{{ $attributes['id'] }}" value="{{ $attributes['src'] ?? '' }}">
    @else 
        <input id="thumbnail_{{ $attributes['id'] }}" class="form-control" type="text" name="file_{{ $attributes['id'] }}" value="{{ $image_url ?? '' }}">
    @endif
</div>
<div id="holder_{{ $attributes['id'] }}" class="d-flex justify-content-center"  style="margin-top:15px; max-height:300px; padding-top:20px ">
    @if ($image_url != '') 
        <img src="{{ $image_url ?? '..' }}" height="200px" >
    @endif

    @if ($attributes['src'] != '') 
        <img src="{{ $attributes['src'] ?? '..' }}" height="200px" >
    @endif
</div>