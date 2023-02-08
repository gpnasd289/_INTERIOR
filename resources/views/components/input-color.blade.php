<div class="form-group">
    <label class="control-label" required>{{ $attributes['label'] }}</label>
    <input type="text" class="colorpicker-large form-control" name="{{ $attributes['name'] }}" value="{{ $attributes['value'] ?? 'black' }}" readonly>
</div>