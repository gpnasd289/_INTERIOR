<div class="form-group">
    <label for="{{ $attributes['name'] }}" class="control-label" required>{{ $attributes['title'] }}</label>
    <div class="form-group">
        <textarea class="form-control"  name="{{ $attributes['name'] }}" id="{{ $attributes['id'] }}" placeholder="{{ $attributes['placeholder'] }}" rows="{{ $attributes['rows'] }} ?? 6">{{ $attributes['value'] }}</textarea>
    </div>
</div>
@if($errors->has('$attributes["name"]'))
    <div class="error"> {{ $errors->first('$attributes["name"]') }} </div>
@endif