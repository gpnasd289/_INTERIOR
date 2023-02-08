
<div class="form-group">
    <label for="{{ $attributes['name'] }}" class="control-label" required>{{ $attributes['title'] }}</label>
    <div class="input-group">
        @if ($isDisable) 
            <input class="form-control" 
            type="{{ $attributes['type'] ?? 'text'}}" 
            name="{{ $attributes['name'] }}"
            value="{{ $attributes['value'] }}" 
            id="{{ $attributes['id'] }}" 
            readonly
            placeholder="{{ $attributes['placeholder'] }}">
            {{ $slot }}
        @else 
            <input class="form-control" 
            type="{{ $attributes['type'] ?? 'text'}}" 
            name="{{ $attributes['name'] }}"
            value="{{ $attributes['value'] }}" 
            id="{{ $attributes['id'] }}" 
            placeholder="{{ $attributes['placeholder'] }}">
            {{ $slot }}
        @endif
    </div>
</div>
@if($errors->has('$attributes["name"]'))
    <div class="error"> {{ $errors->first('$attributes["name"]') }} </div>
@endif