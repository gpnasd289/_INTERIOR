@if ($condition == $value)
    <input type="radio" name="{{ $name }}" value="{{ $value }}" checked />  {{ $title }}
    <div>
        <input type="text" name="{{ $name_value }}" id="{{ $name_value }}" value="" class="form-control" readonly>
    </div>
@else 
    <input type="radio" name="{{ $name }}" value="{{ $value }}"  />   {{ $title }}
    <div>
        <input type="text" name="{{ $name_value }}" id="{{ $name_value }}" value="" class="form-control" readonly>
    </div>
@endif