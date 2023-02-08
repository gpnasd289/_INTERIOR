<div class="form-group">
    <label for="{{ $attributes['name'] }}" class=" control-label" required>{{ $attributes['title'] }}</label>
    <div class="form-group">
       
        <select name="{{ $attributes['name'] }}" id="{{ $attributes['id'] }}" class="select selectpicker form-control" data-live-search="true">
        
            <option value="NULL"  data-tokens="Bỏ trống" >Bỏ trống</option>
                @foreach($options as $option)        
                    @if ($isSameID($option['ID']))
                        <option value="{{ $option['ID'] }}" data-tokens="{{ $option['name'] }}" selected> {{ $option['name']}}  </option>
                    @else
                        <option value="{{ $option['ID'] }}" data-tokens="{{ $option['name'] }}" > {{ $option['name'] }}</option>
                    @endif
                    <x-optionitem :children="$option['children'] ?? []" :tab="$tab" :selected="$selected"></x-optionitem>
                @endforeach
            </select>
    </div>
</div>