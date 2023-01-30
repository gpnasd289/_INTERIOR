<div class="form-group">
    <label for="{{ $attributes['name'] }}" class="control-label" required>{{ $attributes['title'] }}</label>
    <div>
        @if ($isDisable)
        <div class="form-group">
            <input type="text" readonly disabled class="form-control floating-label" value="{{ $attributes['value'] }}" placeholder="dd/mm/yyyy" id="date" name="{{ $attributes['name'] }}">
        </div>
        
        @else
        <div class="form-group">
            <input type="text" class="form-control floating-label" value="{{ $attributes['value'] }}" placeholder="dd/mm/yyyy" id="date" name="{{ $attributes['name'] }}" data-dtp="dtp_pHo5W">
        </div>
        
        @endif
    
    </div>
</div>
@if($errors->has('$attributes["name"]'))
    <div class="error"> {{ $errors->first('$attributes["name"]') }} </div>
@endif